
import 'package:uni/controller/interface_controller.dart';

class GruposController {
  String type;
  InterfaceController interface;

  GruposController(this.type){
    interface = InterfaceController(type);
  }

  static Future<void> init() async{
    await InterfaceController.init('groupsList', 'groupsList');
  }
}