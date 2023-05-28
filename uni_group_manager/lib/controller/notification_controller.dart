import 'package:uni/controller/amizade_controller.dart';
import 'package:uni/controller/events_controller.dart';
import 'package:uni/controller/interface_controller.dart';
import 'package:uni/controller/user_groups_controller.dart';
import 'package:uni/controller/users_controller.dart';
import 'package:uni/model/amizade_model.dart';
import 'package:uni/model/user_grupos_model.dart';

class NotificationController {
  String type;
  InterfaceController interface;
  // ignore: prefer_typing_uninitialized_variables

  NotificationController(this.type){
    interface = InterfaceController(type);
  }

  Future<void> acceptInvite(id, codigo, tipo, uid) async{
    await interface.deleteById(id);
    await interface.updateDataId(id: id+1, criteria: 'notificationsList');
    switch(tipo){
      case 'amizade':
        await UsersController.init();
        final int uid2 = await interface.getValue(codigo, 'users', 'id');
        await AmizadeController.init(null, null);
        interface = InterfaceController('friendship');

        /* insert both friendships */
        await interface.insertData({
          AmizadeModel.id: 0,
          AmizadeModel.uid1: uid,
          AmizadeModel.uid2: uid2,
        }, 'friendship');

        await interface.insertData({
          AmizadeModel.id: 0,
          AmizadeModel.uid1: uid2,
          AmizadeModel.uid2: uid,
        }, 'friendship');
        break;
      case 'grupo':
        await UserGroupsController.init(null, null);
        interface = InterfaceController('user_group');
        await interface.insertData({
          UserGroupsModel.id: 0,
          UserGroupsModel.uid: uid,
          UserGroupsModel.gid: codigo,
        }, 'user_group');
        break;
      case 'eventos':
        interface = InterfaceController('eventosList');
        break;
      default:
        return;
    }
  }

  Future<void> rejectInvite(id, tipo, codigo) async{
      await interface.deleteById(id);
      await interface.updateDataId(id: id+1, criteria: 'notificationsList');

      if (tipo == 'evento') {
        await EventosController.init();
        interface = InterfaceController('eventsList');
        await interface.deleteById(int.parse(codigo));
        await interface.updateDataId(id: int.parse(codigo)+1, criteria: 'eventsList');
      }
  }
}