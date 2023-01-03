import 'package:loginapp/constants/constants.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class OneSignalControler {
  static late final String? osUserID;
  static Future<void> inite() async {
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    OneSignal.shared.setAppId(Constants.onSignalID);

    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
      print("Accepted permission: $accepted");
    });

    final status = await OneSignal.shared.getDeviceState();
    osUserID = status?.userId;
  }
}
