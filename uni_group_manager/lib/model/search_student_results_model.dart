import 'package:uni/controller/invites_controller.dart';
import 'package:uni/controller/users_controller.dart';

import '../controller/interface_controller.dart';
import 'invites_model.dart';

class SearchStudentResultsModel {
  final InterfaceController _interface = InterfaceController('friendsList');

  Future<void> sendFriendRequest(up, user) async {
    /*await SearchStudentResultsController.init(up, 'friendsList');
    List<dynamic> friends = await _interface.getNotificationsList();

    for(var friend in friends){
      if(friend.codigo == user.codigo) {
        return;
      }
    }*/
    await UsersController.init();
    final String profileName = await _interface.getValue(up, 'users', 'nome');
    //if not found in friends list
    await InvitesController.init(user.codigo, 'notificationsList');
    final Invite invite = Invite(id: 0, nome: profileName, texto: 'Enviou-te um pedido de amizade', tipo: 'amizade', codigo: up);
    await _interface.insertData(invite.toJson(), 'notificationsList');
  }
}