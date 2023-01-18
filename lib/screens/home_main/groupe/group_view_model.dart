import 'package:loginapp/screens/home_main/groupe/groupe_model.dart';

class GroupViewModel {
  final GroupeResponseModel _groupeResponseModel;
  GroupViewModel({required GroupeResponseModel groupeResponseModel})
      : _groupeResponseModel = groupeResponseModel;

  int get amount {
    return _groupeResponseModel.amount!;
  }

  int get sharebutton {
    return _groupeResponseModel.sharebutton!;
  }

  String get name {
    return _groupeResponseModel.name!;
  }

  String get amountall {
    return _groupeResponseModel.amountall!;
  }

  String get md5id {
    return _groupeResponseModel.md5id!;
  }

  String get comment {
    return _groupeResponseModel.comment!;
  }

  String get show1 {
    return _groupeResponseModel.show1!;
  }

  String get date1 {
    return _groupeResponseModel.date1!;
  }
}
