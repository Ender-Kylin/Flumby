Drop the Linux libmpv runtime files here to bundle mpv with the app.

Expected files:
- `libmpv.so.2` or `libmpv.so`
- Any extra shared libraries required by that build if they are not available on the target system

When you run `flutter run -d linux` or build a Linux bundle, CMake copies these files into the app bundle `lib/` directory automatically.

The easiest way on Arch-based systems is:

```bash
./tooling/setup_linux_mpv.sh
```

That script downloads the required `mpv` runtime packages without installing them system-wide, places the needed shared libraries in this directory, and patches `libmpv` so it can load bundled dependencies from the app bundle.

You can also override the runtime location during development with:

```bash
FLUMBY_MPV_DIR=/absolute/path/to/mpv/libs flutter run -d linux
```
