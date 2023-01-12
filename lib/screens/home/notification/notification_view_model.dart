import 'package:loginapp/screens/home/notification/notification_model.dart';

class NotificationViewModel {
  final NotificationModel _notificationModel;

  NotificationViewModel({required NotificationModel notificationModel})
      : _notificationModel = notificationModel;

  String get id {
    return _notificationModel.id!;
  }

  String get counter {
    return _notificationModel.counter!;
  }

  String get catid {
    return _notificationModel.catid!;
  }

  String get catid2 {
    return _notificationModel.catid2!;
  }

  String get md5id {
    return _notificationModel.md5id!;
  }

  String get dateadd {
    return _notificationModel.dateadd!;
  }

  String get text1 {
    return _notificationModel.text1!;
  }

  String get text2 {
    return _notificationModel.text2!;
  }

  String get text3 {
    return _notificationModel.text3!;
  }

  String get text4 {
    return _notificationModel.text4!;
  }

  String get text5 {
    return _notificationModel.text5!;
  }

  String get userid {
    return _notificationModel.userid!;
  }

  String get token {
    return _notificationModel.token!;
  }
}
