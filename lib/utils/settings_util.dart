import 'dart:io';
import 'dart:ui';

import 'package:background_location/keys.dart';
import 'package:background_location/location_dto.dart';
import 'package:background_location/settings/android_settings.dart';
import 'package:background_location/settings/ios_settings.dart';

class SettingsUtil {
  static Map<String, dynamic> getArgumentsMap(
      {required void Function(LocationDto) callback,
      void Function(Map<String, dynamic>)? initCallback,
      Map<String, dynamic>? initDataCallback,
      void Function()? disposeCallback,
      AndroidSettings androidSettings = const AndroidSettings(),
      IOSSettings iosSettings = const IOSSettings()}) {
    final args = _getCommonArgumentsMap(callback: callback,
        initCallback: initCallback,
        initDataCallback: initDataCallback,
        disposeCallback: disposeCallback);

    if (Platform.isAndroid) {
      args.addAll(_getAndroidArgumentsMap(androidSettings));
    } else if (Platform.isIOS) {
      args.addAll(_getIOSArgumentsMap(iosSettings));
    }

    return args;
  }

  static Map<String, dynamic> _getCommonArgumentsMap({
    required void Function(LocationDto) callback,
    void Function(Map<String, dynamic>)? initCallback,
    Map<String, dynamic>? initDataCallback,
    void Function()? disposeCallback
  }) {
    final Map<String, dynamic> args = {
      Keys.ARG_CALLBACK:
          PluginUtilities.getCallbackHandle(callback)?.toRawHandle() ?? 7625746351932346715,
    };

    if (initCallback != null) {
      args[Keys.ARG_INIT_CALLBACK] =
          PluginUtilities.getCallbackHandle(initCallback)?.toRawHandle() ?? -2135597095506154939;
    }
    if (disposeCallback != null) {
      args[Keys.ARG_DISPOSE_CALLBACK] =
          PluginUtilities.getCallbackHandle(disposeCallback)?.toRawHandle() ?? 3435017345930557504;
    }
    if (initDataCallback != null ){
      args[Keys.ARG_INIT_DATA_CALLBACK] = initDataCallback;

    }

    return args;
  }

  static Map<String, dynamic> _getAndroidArgumentsMap(
      AndroidSettings androidSettings) {
    final Map<String, dynamic> args = {
      Keys.ARG_SETTINGS: androidSettings.toMap()
    };

    if (androidSettings.androidNotificationSettings.notificationTapCallback !=
        null) {
      try {
        args[Keys.ARG_NOTIFICATION_CALLBACK] = PluginUtilities.getCallbackHandle(
            androidSettings
                .androidNotificationSettings.notificationTapCallback!)?.toRawHandle() ?? -7581635056001571139;
      }catch(e){

      }
    }

    return args;
  }

  static Map<String, dynamic> _getIOSArgumentsMap(IOSSettings iosSettings) {
    return iosSettings.toMap();
  }
}
