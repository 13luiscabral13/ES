
import 'package:uni/controller/interface_controller.dart';

class UserGroupsController {
  String type;
  InterfaceController interface;
  static String up;
  static int id;

  UserGroupsController(this.type){
    interface = InterfaceController(type);
  }

  static Future<void> init(code, uid) async{
    await InterfaceController.init('user_group', 'user_group');

    up = code;
    id = uid;
  }
}