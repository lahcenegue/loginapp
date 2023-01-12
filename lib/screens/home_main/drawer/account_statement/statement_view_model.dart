import 'package:loginapp/screens/home_main/drawer/account_statement/statement_model.dart';

class StatementViewModel {
  final StatementModel _statementModel;

  StatementViewModel({required StatementModel statementModel})
      : _statementModel = statementModel;

  String get id {
    return _statementModel.id!;
  }

  String get counter {
    return _statementModel.counter!;
  }

  String get catid {
    return _statementModel.catid!;
  }

  String get catid2 {
    return _statementModel.catid2!;
  }

  String get md5id {
    return _statementModel.md5id!;
  }

  String get dateadd {
    return _statementModel.dateadd!;
  }

  String get text1 {
    return _statementModel.text1!;
  }

  String get text2 {
    return _statementModel.text2!;
  }

  String get text3 {
    return _statementModel.text3!;
  }

  String get text4 {
    return _statementModel.text4!;
  }

  String get text5 {
    return _statementModel.text5!;
  }

  String get userid {
    return _statementModel.userid!;
  }

  String get token {
    return _statementModel.token!;
  }
}
