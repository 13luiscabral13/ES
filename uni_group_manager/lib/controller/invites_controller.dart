
import 'package:uni/controller/interface_controller.dart';

class InvitesController{
  String type;
  InterfaceController interface;

  InvitesController(this.type){
    interface = InterfaceController(type);
  }

  static Future<void> init(up, type) async{
    final String title = up + ' - ' + type;
    await InterfaceController.init(title, type);
  }
}
