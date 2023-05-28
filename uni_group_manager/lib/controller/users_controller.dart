import 'package:uni/controller/interface_controller.dart';
import 'package:uni/model/users_model.dart';

class UsersController {
  final Users search = Users();

  static Future<void> init() async{
    await InterfaceController.init('users', 'users');
  }
}