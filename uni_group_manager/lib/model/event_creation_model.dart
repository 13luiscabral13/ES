import 'package:flutter/material.dart';
import 'package:uni/controller/invites_controller.dart';
import 'package:uni/controller/local_storage/app_shared_preferences.dart';
import 'package:uni/controller/user_groups_controller.dart';
import 'package:uni/model/invites_model.dart';
import 'package:uni/controller/events_controller.dart';
import 'package:uni/controller/interface_controller.dart';
import 'package:uni/model/events_model.dart';

class EventCreationModel {
  final InterfaceController interface = InterfaceController('eventsList');

  String checkEventDescription(String value) {
    if(value.length < 200) {
      return null;
    } else {
      return "Limite de 200 caracteres atingido!";
    }
  }

  String checkEventName(String name) {
    if(name == '') return 'Campo Obrigatório';

    if(name.length > 25) {
      return 'Nome inválido! O tamanho do nome não pode exceder 25 caracteres';
    }
    else {
      return null;
    }
  }

  bool validateDropdownValue(String value) {
    if(value == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<DateTime> selectDate(BuildContext context, DateTime date) => showDatePicker(
    context: context,
    initialDate: date,
    firstDate: DateTime(date.year - 5),
    lastDate: DateTime(date.year + 10),
  );

  Future<TimeOfDay> selectTime(BuildContext context, DateTime dateTime) => showTimePicker(
    context: context,
    initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute),
  );

  Future<void> submit(uid, String eventName, String eventDescription, DateTime eventDateTime, String groupId) async {
    await EventosController.init();
    final eventHours = eventDateTime.hour.toString().padLeft(2, '0');
    final eventMinutes = eventDateTime.minute.toString().padLeft(2, '0');
    await interface.insertData({
      EventosModel.id: 0,
      EventosModel.nome: eventName,
      EventosModel.date: '${eventDateTime.day} do ${eventDateTime.month}',
      EventosModel.time: '$eventHours:$eventMinutes horas',
      EventosModel.descricao: eventDescription,
      EventosModel.gid: groupId,
    }, 'eventsList');

    await UserGroupsController.init(UserGroupsController.up, UserGroupsController.id);
    final List<dynamic> membros = await interface.getData(groupId, 'groupMembers');

    //await UsersController.init();
    final String code = await AppSharedPreferences.getUserNumber();
    final String profileName = await interface.getValue(code, 'users', 'nome');
    await EventosController.init();
    final String eid = await interface.getValue(eventName, 'eventsList', 'id');

    for(var i = 0; i < membros.length; i++) {
      if(membros[i].id.toString() == uid.toString()) {
        continue;
      }
      await InvitesController.init(membros[i].codigo.toString(), 'notificationsList');
      final Invite invite = Invite(id: 0, nome: profileName, texto: '${profileName} criou um evento.', tipo: 'eventos', codigo: eid);
      await interface.insertData(invite.toJson(), 'notificationsList');
    }
  }
}