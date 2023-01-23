import 'package:loginapp/constants/constants.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class OneSignalControler {
  static String? osUserID = "";
  static Future<void> inite() async {
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    OneSignal.shared.setAppId(Constants.onSignalID);

    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
      if (accepted) {
        print("=========================");
        print("Accepted permission: true");
      } else {
        openAppSettings();
      }
    });

    final status = await OneSignal.shared.getDeviceState();
    osUserID = status?.userId;
  }
}
