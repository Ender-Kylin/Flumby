#include "my_application.h"

#include <flutter_linux/flutter_linux.h>
#ifdef GDK_WINDOWING_X11
#include <gdk/gdkx.h>
#endif

#include "flutter/generated_plugin_registrant.h"

struct _MyApplication {
  GtkApplication parent_instance;
  char **dart_entrypoint_arguments;
  GtkWindow *window;
  FlMethodChannel *window_control_channel;
};

G_DEFINE_TYPE(MyApplication, my_application, GTK_TYPE_APPLICATION)

static gboolean is_window_maximized(GtkWindow *window) {
  GdkWindow *gdk_window = gtk_widget_get_window(GTK_WIDGET(window));
  if (gdk_window == nullptr) {
    return FALSE;
  }

  return (gdk_window_get_state(gdk_window) & GDK_WINDOW_STATE_MAXIMIZED) != 0;
}

static FlMethodResponse *handle_window_control_method(MyApplication *self,
                                                      const gchar *method,
                                                      FlValue *args) {
  if (self->window == nullptr) {
    return FL_METHOD_RESPONSE(fl_method_success_response_new(nullptr));
  }

  if (g_strcmp0(method, "startWindowDrag") == 0) {
    if (args != nullptr && fl_value_get_type(args) == FL_VALUE_TYPE_MAP) {
      FlValue *x_value = fl_value_lookup_string(args, "x");
      FlValue *y_value = fl_value_lookup_string(args, "y");
      const gint root_x = x_value == nullptr
                              ? 0
                              : static_cast<gint>(fl_value_get_float(x_value));
      const gint root_y = y_value == nullptr
                              ? 0
                              : static_cast<gint>(fl_value_get_float(y_value));
      gtk_window_begin_move_drag(self->window, 1, root_x, root_y,
                                 GDK_CURRENT_TIME);
    }
    return FL_METHOD_RESPONSE(fl_method_success_response_new(nullptr));
  }

  if (g_strcmp0(method, "minimizeMainWindow") == 0) {
    gtk_window_iconify(self->window);
    return FL_METHOD_RESPONSE(fl_method_success_response_new(nullptr));
  }

  if (g_strcmp0(method, "restoreMainWindow") == 0) {
    gtk_widget_show(GTK_WIDGET(self->window));
    gtk_window_deiconify(self->window);
    gtk_window_present(self->window);
    return FL_METHOD_RESPONSE(fl_method_success_response_new(nullptr));
  }

  if (g_strcmp0(method, "toggleMaximizeMainWindow") == 0) {
    if (is_window_maximized(self->window)) {
      gtk_window_unmaximize(self->window);
    } else {
      gtk_window_maximize(self->window);
    }
    return FL_METHOD_RESPONSE(fl_method_success_response_new(nullptr));
  }

  if (g_strcmp0(method, "isMainWindowMaximized") == 0) {
    return FL_METHOD_RESPONSE(fl_method_success_response_new(
        fl_value_new_bool(is_window_maximized(self->window))));
  }

  if (g_strcmp0(method, "closeMainWindow") == 0) {
    gtk_window_close(self->window);
    return FL_METHOD_RESPONSE(fl_method_success_response_new(nullptr));
  }

  return FL_METHOD_RESPONSE(fl_method_not_implemented_response_new());
}

static void window_control_method_call_cb(FlMethodChannel *channel,
                                          FlMethodCall *method_call,
                                          gpointer user_data) {
  MyApplication *self = MY_APPLICATION(user_data);
  const gchar *method = fl_method_call_get_name(method_call);
  FlValue *args = fl_method_call_get_args(method_call);
  g_autoptr(FlMethodResponse) response =
      handle_window_control_method(self, method, args);

  g_autoptr(GError) error = nullptr;
  if (!fl_method_call_respond(method_call, response, &error)) {
    g_warning("Failed to send window control response: %s", error->message);
  }
}

static void create_channels(MyApplication *self, FlView *view) {
  FlEngine *engine = fl_view_get_engine(view);
  FlBinaryMessenger *messenger = fl_engine_get_binary_messenger(engine);
  g_autoptr(FlStandardMethodCodec) codec = fl_standard_method_codec_new();

  self->window_control_channel = fl_method_channel_new(
      messenger, "flumby/window_control", FL_METHOD_CODEC(codec));
  fl_method_channel_set_method_call_handler(self->window_control_channel,
                                            window_control_method_call_cb, self,
                                            nullptr);
}

// Called when first Flutter frame received.
static void first_frame_cb(MyApplication *self, FlView *view) {
  gtk_widget_show(gtk_widget_get_toplevel(GTK_WIDGET(view)));
}

// Implements GApplication::activate.
static void my_application_activate(GApplication *application) {
  MyApplication *self = MY_APPLICATION(application);
  self->window =
      GTK_WINDOW(gtk_application_window_new(GTK_APPLICATION(application)));

  gtk_window_set_title(self->window, "flumby");
  gtk_window_set_decorated(self->window, FALSE);
  gtk_window_set_default_size(self->window, 1280, 720);

  g_autoptr(FlDartProject) project = fl_dart_project_new();
  fl_dart_project_set_dart_entrypoint_arguments(
      project, self->dart_entrypoint_arguments);

  FlView *view = fl_view_new(project);
  GdkRGBA background_color;
  // Background defaults to black, override it here if necessary, e.g. #00000000
  // for transparent.
  gdk_rgba_parse(&background_color, "#000000");
  fl_view_set_background_color(view, &background_color);
  gtk_widget_show(GTK_WIDGET(view));
  gtk_container_add(GTK_CONTAINER(self->window), GTK_WIDGET(view));

  // Show the window when Flutter renders.
  // Requires the view to be realized so we can start rendering.
  g_signal_connect_swapped(view, "first-frame", G_CALLBACK(first_frame_cb),
                           self);
  gtk_widget_realize(GTK_WIDGET(view));

  create_channels(self, view);
  fl_register_plugins(FL_PLUGIN_REGISTRY(view));

  gtk_widget_grab_focus(GTK_WIDGET(view));
}

// Implements GApplication::local_command_line.
static gboolean my_application_local_command_line(GApplication *application,
                                                  gchar ***arguments,
                                                  int *exit_status) {
  MyApplication *self = MY_APPLICATION(application);
  // Strip out the first argument as it is the binary name.
  self->dart_entrypoint_arguments = g_strdupv(*arguments + 1);

  g_autoptr(GError) error = nullptr;
  if (!g_application_register(application, nullptr, &error)) {
    g_warning("Failed to register: %s", error->message);
    *exit_status = 1;
    return TRUE;
  }

  g_application_activate(application);
  *exit_status = 0;

  return TRUE;
}

// Implements GApplication::startup.
static void my_application_startup(GApplication *application) {
  // MyApplication* self = MY_APPLICATION(object);

  // Perform any actions required at application startup.

  G_APPLICATION_CLASS(my_application_parent_class)->startup(application);
}

// Implements GApplication::shutdown.
static void my_application_shutdown(GApplication *application) {
  // MyApplication* self = MY_APPLICATION(object);

  // Perform any actions required at application shutdown.

  G_APPLICATION_CLASS(my_application_parent_class)->shutdown(application);
}

// Implements GObject::dispose.
static void my_application_dispose(GObject *object) {
  MyApplication *self = MY_APPLICATION(object);
  g_clear_pointer(&self->dart_entrypoint_arguments, g_strfreev);
  g_clear_object(&self->window_control_channel);
  G_OBJECT_CLASS(my_application_parent_class)->dispose(object);
}

static void my_application_class_init(MyApplicationClass *klass) {
  G_APPLICATION_CLASS(klass)->activate = my_application_activate;
  G_APPLICATION_CLASS(klass)->local_command_line =
      my_application_local_command_line;
  G_APPLICATION_CLASS(klass)->startup = my_application_startup;
  G_APPLICATION_CLASS(klass)->shutdown = my_application_shutdown;
  G_OBJECT_CLASS(klass)->dispose = my_application_dispose;
}

static void my_application_init(MyApplication *self) {}

MyApplication *my_application_new() {
  // Set the program name to the application ID, which helps various systems
  // like GTK and desktop environments map this running application to its
  // corresponding .desktop file. This ensures better integration by allowing
  // the application to be recognized beyond its binary name.
  g_set_prgname(APPLICATION_ID);

  return MY_APPLICATION(g_object_new(my_application_get_type(),
                                     "application-id", APPLICATION_ID, "flags",
                                     G_APPLICATION_NON_UNIQUE, nullptr));
}
