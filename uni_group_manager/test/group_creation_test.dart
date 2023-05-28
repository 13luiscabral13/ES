import 'package:test/test.dart';
import 'package:uni/controller/interface_controller.dart';
import 'package:uni/controller/invites_controller.dart';
import 'package:uni/controller/user_groups_controller.dart';
import 'package:uni/model/group_creation_model.dart';
import 'package:uni/model/users_model.dart';

void main() {
  group('criando um grupo', () {
    InterfaceController interface;
    final GroupCreationModel creationModel = GroupCreationModel();

    test('aumentar no user_group 1 unidade', () async{
      interface = InterfaceController('user_group');

      await UserGroupsController.init(null, null);
      final List<dynamic> uGrupos = await interface.getData('1', 'user_group');

      await UserGroupsController.init('up201905916', 1);
      await creationModel.submit(1, 'Test1', 'hello', []);

      await UserGroupsController.init(null, null);
      final List<dynamic> uGrupos2 = await interface.getData('1', 'user_group');

      expect(uGrupos2.length, uGrupos.length + 1);
    });

    test('aumentar na notificationList de um possível membro 1 invite', () async{
      interface = InterfaceController('groupsList');

      await InvitesController.init('up202006464', 'notificationsList');
      final List<dynamic> notific = await interface.getNotificationsList('notificationsList');

      const item = User(id: 4, codigo: 'up202006464', nome: 'Luís Cabral', descricao: 'Descrição Luís');
      await UserGroupsController.init('up201905916', 1);
      await creationModel.submit(1, 'Test1', 'hello', [item]);

      await InvitesController.init('up202006464', 'notificationsList');
      final List<dynamic> notific2 = await interface.getNotificationsList('notificationsList');

      expect(notific2.length, notific.length + 1);
    });
  });
}