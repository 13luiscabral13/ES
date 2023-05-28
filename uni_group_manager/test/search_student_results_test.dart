import 'package:test/test.dart';
import 'package:uni/controller/interface_controller.dart';
import 'package:uni/controller/invites_controller.dart';
import 'package:uni/model/search_student_results_model.dart';
import 'package:uni/model/users_model.dart';

void main() {
  group('adicionando um amigo', () {
    InterfaceController interface;
    final result = SearchStudentResultsModel();

    test('aumenta o numero de notiicações da pessoa para qual o pedido foi mandado', () async{
      interface = InterfaceController('notificationsList');

      await InvitesController.init('up201905916', 'notificationsList');
      final List<dynamic> invites = await interface.getNotificationsList('notificationsList');

      const item = User(id: 0, codigo: 'up201905916', nome: 'André Costa', descricao: 'Descrição André');
      await result.sendFriendRequest('up202004682', item);

      await InvitesController.init('up201905916', 'notificationsList');
      final List<dynamic> invites2 = await interface.getNotificationsList('notificationsList');

      expect(invites2.length, invites.length + 1);
    });
  });
}