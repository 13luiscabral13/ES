import 'package:uni/controller/interface_controller.dart';

class AmizadeController {
  String type;
  InterfaceController interface;
  static String up;
  static int id;

  AmizadeController(this.type){
    interface = InterfaceController(type);
  }

  static Future<void> init(code, uid) async{
    await InterfaceController.init('friendship', 'friendship');

    up = code;
    id = uid;
  }
}