import 'package:device_info_plus/device_info_plus.dart';
import 'package:loginapp/widgets/one_signal_controller.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> checkNotification() async {
  final androidInfo = await DeviceInfoPlugin().androidInfo;
  late final PermissionStatus statusess;

  if (androidInfo.version.sdkInt == 33) {
    statusess = await Permission.notification.request();
    print('statuse : $statusess');
    OneSignalControler.inite();
  } else {
    OneSignalControler.inite();
  }
}
