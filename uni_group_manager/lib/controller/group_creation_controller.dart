import 'package:uni/model/group_creation_model.dart';
import 'package:uni/controller/interface_controller.dart';

class GroupCreationController {
  String type;
  InterfaceController interface;

  GroupCreationController(this.type) {
    interface = InterfaceController(type);
  }

  final GroupCreationModel group = GroupCreationModel();
}