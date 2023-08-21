//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <emoji_picker_flutter/emoji_picker_flutter_plugin_c_api.h>
#include <file_selector_windows/file_selector_windows.h>
#include <firebase_core/firebase_core_plugin_c_api.h>
#include <modal_progress_hud_nsn/modal_progress_hud_nsn_plugin.h>
#include <pdfx/pdfx_plugin.h>
#include <rive_common/rive_plugin.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  EmojiPickerFlutterPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("EmojiPickerFlutterPluginCApi"));
  FileSelectorWindowsRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("FileSelectorWindows"));
  FirebaseCorePluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("FirebaseCorePluginCApi"));
  ModalProgressHudNsnPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("ModalProgressHudNsnPlugin"));
  PdfxPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("PdfxPlugin"));
  RivePluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("RivePlugin"));
}
