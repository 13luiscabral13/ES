import 'package:uni/controller/grupos_controller.dart';
import 'package:uni/controller/invites_controller.dart';
import 'package:uni/controller/local_storage/app_shared_preferences.dart';
import 'package:uni/controller/user_groups_controller.dart';
import 'package:uni/controller/users_controller.dart';
import 'package:uni/model/grupos_model.dart';
import 'package:uni/model/invites_model.dart';
import 'package:uni/model/user_grupos_model.dart';

import '../controller/interface_controller.dart';

class GroupCreationModel {
  final InterfaceController interface = InterfaceController('groupsList');

  String checkNameGroup(String name){
    if(name == '') return 'Campo Obrigatório';

    if(name.length > 25){
      return 'Nome inválido! O tamanho do nome não pode exceder 25 caracteres';
    }
    else {
      return null;
    }
  }

  String checkDescription(String description){
    if(description == '') return null;

    if(description.length > 200){
      return 'Descrição inválida! O tamanho da descrição não pode exceder 200 caracteres';
    }else{
      return null;
    }
  }

  Future<void> submit(uid, grpname, grpdescription, grpmembers) async {
    await GruposController.init();
    await interface.insertData({
      GruposModel.id: 0,
      GruposModel.nome: grpname,
      GruposModel.descricao: grpdescription,
    }, 'groupsList');

    await UsersController.init();
    final String profileName = await interface.getValue(uid, 'users', 'nome');
    await GruposController.init();
    final int gid = await interface.getValue(grpname, 'groupsList', 'id');

    await UserGroupsController.init(UserGroupsController.up, uid);
    await interface.insertData({
      UserGroupsModel.id: 0,
      UserGroupsModel.uid: uid,
      UserGroupsModel.gid: gid,
    }, 'user_group');

    for(var friend in grpmembers){
      await InvitesController.init(friend.codigo, 'notificationsList');
      final Invite invite = Invite(id: 0, nome: profileName, texto: 'Convidou-te para um grupo', tipo: 'grupo', codigo: gid.toString());

      await interface.insertData(invite.toJson(), 'notificationsList');
    }
  }
}