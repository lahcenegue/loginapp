import 'package:loginapp/screens/home_main/drawer/update/update_info/update_info_model.dart';

class GetInfoViewModel {
  final GetInfoModel _getInfoModel;
  GetInfoViewModel({required GetInfoModel getInfoModel})
      : _getInfoModel = getInfoModel;

  String get message {
    return _getInfoModel.msg!;
  }

  String get email {
    return _getInfoModel.email!;
  }

  String get info {
    return _getInfoModel.info!;
  }
}
