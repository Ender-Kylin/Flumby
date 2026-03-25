#include "my_application.h"

#include <locale.h>

int main(int argc, char** argv) {
  // libmpv rejects non-C numeric locales on Linux because decimal parsing
  // becomes ambiguous. Keep the rest of the user's locale intact.
  setlocale(LC_ALL, "");
  setlocale(LC_NUMERIC, "C");
  g_autoptr(MyApplication) app = my_application_new();
  return g_application_run(G_APPLICATION(app), argc, argv);
}
