//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <file_selector_windows/file_selector_windows.h>
#include <modal_progress_hud_nsn/modal_progress_hud_nsn_plugin_c_api.h>
#include <permission_handler_windows/permission_handler_windows_plugin.h>
#include <simple_animation_progress_bar/simple_animation_progress_bar_plugin_c_api.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  FileSelectorWindowsRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("FileSelectorWindows"));
  ModalProgressHudNsnPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("ModalProgressHudNsnPluginCApi"));
  PermissionHandlerWindowsPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("PermissionHandlerWindowsPlugin"));
  SimpleAnimationProgressBarPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("SimpleAnimationProgressBarPluginCApi"));
}
