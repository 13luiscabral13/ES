import 'package:flutter/material.dart';
import 'package:uni/controller/users_controller.dart';
import 'package:uni/view/Pages/search_student_results_page.dart';
import '../controller/interface_controller.dart';

class SearchStudentModel {
  final InterfaceController _interface = InterfaceController('users');

  Future<void> submit(String _name, String _number, String up, BuildContext context) async {
    if( _number.length == 9 ) {
      _number = 'up' + _number;
    }
    await UsersController.init();
    final List<dynamic> users = await _interface.getNotificationsList('users');
    final List<dynamic> filtered = [];
    for(var user in users){
      if(_number != '' && user.codigo == _number && user.codigo != up){
        filtered.add(user);
        break;
      }
      else if(user.nome.contains(_name) /*&& user.nome != profileNome*/ && _name != ''){
        filtered.add(user);
      }
    }

    Navigator.push(context,
        MaterialPageRoute(builder: (_) => SearchStudentResults(up: up, results: filtered),
        ));
  }

  String checkCodeValid(String code){
    if(code == '') return null;

    var aux = 0;
    int n = 0;
    bool isNumber = true;
    code = code?.toLowerCase();

    if( code[0] == 'u' && code[1] == 'p' && code.length == 11 ) {
      try {
        n = int.parse(code.substring(2, 11));
      } catch(e) {
        isNumber = false;
        aux = -1;
      }
    } else if( code.length == 9 ) {
      try {
        n = int.parse(code);
      } catch(e) {
        isNumber = false;
        aux = -1;
      }
    } else {
      isNumber = false;
      aux = -1;
    }

    if( isNumber ) {
      if( n < 129000000 ) {
        aux = -1;
      }
    }

    if(aux == 0) {
      return null;
    } else {
      return 'Código inválido! Code must have up20xxxxxxx (e.g. up201905916)';
    }
  }
}
