import 'package:uni/controller/interface_controller.dart';

class EventosController {
  String type;
  InterfaceController interface;

  EventosController(this.type){
    interface = InterfaceController(type);
  }

  static Future<void> init() async{
    await InterfaceController.init('eventsList', 'eventsList');
  }
}