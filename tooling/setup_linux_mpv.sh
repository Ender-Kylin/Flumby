#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET_DIR="${ROOT_DIR}/linux/third_party/mpv"
WORK_DIR="${ROOT_DIR}/.tmp/linux-mpv"

PACKAGES=(
  mpv
  libcdio
  libcdio-paranoia
  mujs
  luajit
  uchardet
  libsixel
  libxpresent
)

require_cmd() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "Missing required command: $1" >&2
    exit 1
  fi
}

download_pkg() {
  local package="$1"
  local url
  url="$(pacman -Sup "${package}" | rg "/${package}-.*\\.pkg\\.tar\\.zst$" | head -n 1)"
  if [[ -z "${url}" ]]; then
    echo "Failed to resolve package URL for ${package}" >&2
    exit 1
  fi

  echo "Downloading ${package}"
  curl -L --fail "${url}" -o "${WORK_DIR}/pkgs/${package}.pkg.tar.zst"
}

extract_libs() {
  local package="$1"
  mkdir -p "${WORK_DIR}/extract/${package}"
  bsdtar -xf "${WORK_DIR}/pkgs/${package}.pkg.tar.zst" \
    -C "${WORK_DIR}/extract/${package}" \
    usr/lib

  find "${WORK_DIR}/extract/${package}/usr/lib" \
    -maxdepth 1 \
    \( -type f -o -type l \) \
    -name '*.so*' \
    -exec cp -Lf {} "${TARGET_DIR}/" \;
}

main() {
  require_cmd pacman
  require_cmd curl
  require_cmd bsdtar
  require_cmd rg
  require_cmd patchelf
  require_cmd ldd

  mkdir -p "${TARGET_DIR}" "${WORK_DIR}/pkgs"

  for package in "${PACKAGES[@]}"; do
    download_pkg "${package}"
    extract_libs "${package}"
  done

  if [[ ! -f "${TARGET_DIR}/libmpv.so.2.5.0" ]]; then
    echo "Expected libmpv.so.2.5.0 in ${TARGET_DIR}, but it was not extracted." >&2
    exit 1
  fi

  patchelf \
    --replace-needed /usr/lib/libmujs.so libmujs.so \
    --set-rpath '$ORIGIN' \
    "${TARGET_DIR}/libmpv.so.2.5.0"

  rm -f "${TARGET_DIR}/libmpv.so" "${TARGET_DIR}/libmpv.so.2"
  ln -s "libmpv.so.2.5.0" "${TARGET_DIR}/libmpv.so.2"
  ln -s "libmpv.so.2" "${TARGET_DIR}/libmpv.so"

  echo
  echo "Verifying bundled mpv runtime"
  LD_LIBRARY_PATH="${TARGET_DIR}" ldd "${TARGET_DIR}/libmpv.so.2.5.0"
}

main "$@"
