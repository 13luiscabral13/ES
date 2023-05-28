import 'package:uni/model/event_creation_model.dart';
import 'package:uni/controller/interface_controller.dart';

class EventCreationController {
  String type;
  InterfaceController interface;

  EventCreationController(this.type) {
    interface = InterfaceController(type);
  }

  final EventCreationModel event = EventCreationModel();
}