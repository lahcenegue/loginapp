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

        print("Accepted permission: false");
      }
    });

    final status = await OneSignal.shared.getDeviceState();
    osUserID = status?.userId;
  }
}

// Future permiNot() async {
//   PermissionStatus notificationPermission =
//       await Permission.notification.request();

//   if (notificationPermission == PermissionStatus.granted) {
//     print('permision granted');
//   } else if (notificationPermission == PermissionStatus.denied) {
//     openAppSettings();
//     print("notification diened");
//   } else if (notificationPermission == PermissionStatus.permanentlyDenied) {}
// }
