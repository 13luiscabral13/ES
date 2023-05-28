import 'package:test/test.dart';
import 'package:uni/controller/amizade_controller.dart';
import 'package:uni/controller/interface_controller.dart';
import 'package:uni/controller/invites_controller.dart';
import 'package:uni/controller/notification_controller.dart';
import 'package:uni/controller/user_groups_controller.dart';

void main() {
  group('aceitando um invite', () {
    InterfaceController interface;
    final notific = NotificationController('notificationsList');

    test('aceitando, diminui o numero de notificações 1 unidade', () async {
      interface = InterfaceController('notificationsList');

      await InvitesController.init('up201704987', 'notificationsList');
      final List<dynamic> invites = await interface.getNotificationsList('notificationsList');

      await notific.acceptInvite(1, 'up201905916', 'nothing', '1',);

      await InvitesController.init('up201704987', 'notificationsList');
      final List<dynamic> invites2 = await interface.getNotificationsList('notificationsList');

      expect(invites2.length, invites.length - 1);
    });

    test('aumenta o numero de amizades por 2 unidades', () async {
      interface = InterfaceController('friendship');

      await AmizadeController.init(null, null);
      final List<dynamic> amigos = await interface.getData(2, 'friendship');
      print("ola $amigos");

      await InvitesController.init('up201704987', 'notificationsList');
      await notific.acceptInvite(1, 'up201704987', 'amizade', '1', );

      await AmizadeController.init(null, null);
      final List<dynamic> amigos2 = await interface.getData(2, 'friendship');
      print("ola2 $amigos2");

      expect(amigos2.length, amigos.length + 1);
    });

    test('aumenta o numero de relações user-group 1 unidade', () async{
      interface = InterfaceController('user_group');

      await UserGroupsController.init(null, null);
      final List<dynamic> grupos = await interface.getData(2, 'user_group');

      await InvitesController.init('up201704987', 'notificationsList');
      await notific.acceptInvite(1, '2', 'grupo', '2',);

      await UserGroupsController.init(null, null);
      final List<dynamic> grupos2 = await interface.getData(2, 'user_group');

      expect(grupos2.length, grupos.length + 1);
    });
  });

  group('rejeitando um invite', () {
    InterfaceController interface;
    final notific = NotificationController('notificationsList');

    test('rejeitando, diminui o numero de notificações 1 unidade', () async {
      interface = InterfaceController('notificationsList');

      await InvitesController.init('up201704987', 'notificationsList');
      final List<dynamic> invites = await interface.getNotificationsList('notificationsList');

      await notific.rejectInvite(1, '', '');

      await InvitesController.init('up201704987', 'notificationsList');
      final List<dynamic> invites2 = await interface.getNotificationsList('notificationsList');

      expect(invites2.length, invites.length - 1);
    });

    test('rejeitando um invite de um evento, diminui o numero de eventos 1 unidade', () async {
      interface = InterfaceController('eventsList');

      await UserGroupsController.init(null, null);
      final List<dynamic> eventos = await interface.getData(1, 'eventsList');

      await InvitesController.init('up201704987', 'notificationsList');
      await notific.rejectInvite(5, 'evento', '1');

      await UserGroupsController.init(null, null);
      final List<dynamic> eventos2 = await interface.getData(1, 'eventsList');

      expect(eventos2.length, eventos.length - 2);
    });
  });
}