import 'package:loginapp/screens/home/main/main_model.dart';

class MainViewModel {
  final MainModel _mainModel;
  MainViewModel({required MainModel mainModel}) : _mainModel = mainModel;

  String get msg {
    return _mainModel.msg!;
  }

  String get name {
    return _mainModel.name!;
  }

  String get group {
    return _mainModel.group!;
  }

  int get not {
    return _mainModel.not!;
  }

  String get id {
    return _mainModel.id!;
  }

  String get balance {
    return _mainModel.balance!;
  }
}
