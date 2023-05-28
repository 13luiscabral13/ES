
import 'package:gsheets/gsheets.dart';
import 'package:uni/controller/events_controller.dart';
import 'package:uni/controller/grupos_controller.dart';
import 'package:uni/controller/users_controller.dart';
import 'package:uni/model/amizade_model.dart';
import 'package:uni/model/events_model.dart';
import 'package:uni/model/grupos_model.dart';
import 'package:uni/model/invites_model.dart';
import 'package:uni/model/user_grupos_model.dart';
import 'package:uni/model/users_model.dart';

class InterfaceController{
  String type;

  InterfaceController(this.type);

  static const _credentials = r'''
  {
    "type": "service_account",
    "project_id": "es-project-349020",
    "private_key_id": "6987a64a33a909fd662524e43e1a1dd89f9bfc5a",
    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCyhchbigluS23k\nTkQ69c3Z1kLoDhe09IVXxw4ewD7l6sazB1UW70ODMQj+AXznwzTmjdP+y5BF4JJL\nWl6aMSW82fHSHIYefEwNaVlBB9BnVr1rugpueSJNEPZG9dmv2D9HWU2k/pf9Jkw5\n7uhcG2x6qGsJ5jnqNKs3uSNlv+lOW1JKFcCGY366b/xVtFpcCm7ZArwBDGFdhazR\n7xfJpXS7o57uDYnBP/wlhm7FY6ti/XxiADJpWtmJl3jlSXGw3rifkn4seEPykmbp\n1s+D+RHsTLmrA4udE/xZum+LH3OCxHctaSB+hyFt+v2hUKgVhX6o5FumcykJZKMT\n2P+hFvU9AgMBAAECggEATnPVW0j7oQE7709n06NOzdLHf1QmHesxKCR9c40XdxGo\nNWfdAGGwQRiM85cyzWTvO/yK89eAdPzePYget9MuWuJKT4QieoY0I9aulxH4h1lK\nj+tnhynrpYN1PzTub8Tv9gpsQTxzDZhFelYfvc59ax/VPjnzLJXtwmS1hhMC0+A4\nzWGig0Y09BL+z7OobZ4Ew7ft8Yy8xZ3epxXWp5HKpXqMDqXdEgnSKP2zbrTnHq1y\n4ILttf22SvARyeNSZmF3E8oXeDJCOuhrLBng1DgmsSMRlIs65onm/1VJNSlJd4Uz\nN69O/3KVgnli6fW5QO7dD6O+gvOclh15IRs8UNw9nwKBgQDhe5bzDNKiszADcgda\ng26+xweHcTBGI/8o6+Ygzy1W+Gxjr/8Toa+Oe39H2RCfQmJpFZOPRQcyfrO+Yq2N\nJvWiz3vnrD1jvvt7a0LVMEJCfYbLHf6xpi1FwmSFyZ3SdvdR9slIYWIj4VQndTBY\ndCrh7RZEnkDWnb2Q8FRfQ0gq8wKBgQDKryQQHC3JvwL4SH347sSrmyH5/oglGxf2\nsUoSlm5xgoNPTXPV4w883LwmSvkd/RKLP3dgmNvX2ouCos/V/9fNKtqisZUoyRMS\nlR1vEPtrNIlLn7EBJebz8q/ib70rTHqO2kHCf6TvbLlrZLOoX7/mQJdUXxZZSPkC\nbVzIiuwLDwKBgAyd0LVqy0JlSlN3BuhOoFy2YDp4392c2AMfJ/JABWZvYgk16Mzd\naChNyrJnd+GhYkZE+cuzbhKqOj514QYb3vSsLV+qKIkzP3kJaGTrXVnBElC9Leoc\nxT25AczmmhkTpQUGDP8qy8X8LqxCh2D7pwabMHrIbBJWIyw/9kiaSCh3AoGAP5ES\nVGMiESXw/oFt0MbBs7hhvZAQjuKib2JHAvFfDgaKvDJkY+5kdwgbkj7tRnR6fmWX\nQRpvyJDoND5vxIQK4HPSQjhDuZjmfGt74buHvqWpcahR0TRb7KJueyvkPlIsFeVp\nvmBeECEfPglFN0dgXgxf6bwwvCvgvNwjv1mikg0CgYEAi0i4/KBjjKdJYEuUI9bS\nR2N5oBHVIx/Tj/Tp7eBA+ub5pTlVzhdDMoP2F3qJbBclT66DOdtiOkWr4zmcZHP0\nvk17yiE+N6NKXsa7svCkVXsOqDjkQnyivfe7RJrQulN54eU5pn4dmuAkJVxrBPUv\nlogfWdRJf25ytNG3kbyXMEI=\n-----END PRIVATE KEY-----\n",
    "client_email": "es-project@es-project-349020.iam.gserviceaccount.com",
    "client_id": "113367117254932729913",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/es-project%40es-project-349020.iam.gserviceaccount.com"
  }
  ''';

  static const _spreadsheetId = '1x8mq4l7rKS4Iz8ql8m6Jz2iaF7x_r4h5Xw2V_yzRG2k';
  static final _gsheets = GSheets(_credentials);
  static Worksheet _userSheet;

  /* Initialize the gsheet */
  static Future init(title, type) async {
    try {
      final spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);
      switch(type){
        case 'users':
          _userSheet = await _getWorkSheet(spreadsheet, title: title);

          final firstRow = Users.getFields();
          _userSheet.values.insertRow(1, firstRow);
          break;
        case 'notificationsList':
          _userSheet = await _getWorkSheet(spreadsheet, title: title);

          final firstRow = InvitesModel.getFields();
          _userSheet.values.insertRow(1, firstRow);
          break;
        case 'friendship':
          _userSheet = await _getWorkSheet(spreadsheet, title: title);

          final firstRow = AmizadeModel.getFields();
          _userSheet.values.insertRow(1, firstRow);
          break;
        case 'groupsList':
          _userSheet = await _getWorkSheet(spreadsheet, title: title);

          final firstRow = GruposModel.getFields();
          _userSheet.values.insertRow(1, firstRow);
          break;
        case 'user_group':
          _userSheet = await _getWorkSheet(spreadsheet, title: title);

          final firstRow = UserGroupsModel.getFields();
          _userSheet.values.insertRow(1, firstRow);
          break;
        case 'eventsList':
          _userSheet = await _getWorkSheet(spreadsheet, title: title);
          break;
        default:
          print('Invalid sheet name');
          break;
      }
    } catch (e) {
      print('Init Error: $e');
    }
  }

  static Future<Worksheet> _getWorkSheet(Spreadsheet spreadsheet, {String title,}) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title);
    }
  }

  /* reading data */
  Future<dynamic> getById(int id, criteria) async{
    if(_userSheet == null) return null;

    final json = await _userSheet.values.map.rowByKey(id, fromColumn: 1);

    switch(criteria){
      case 'users':
        return json == null ? null : User.fromJson(json);
      case 'notificationsList':
        return json == null ? null : Invite.fromJson(json);
      case 'friendship':
        return json == null ? null : Amizade.fromJson(json);
      case 'groupsList':
        return json == null ? null : Grupo.fromJson(json);
      case 'user_group':
        return json == null ? null : UserGroup.fromJson(json);
      case 'eventsList':
        return json == null ? null : Evento.fromJson(json);
        break;
      default:
        break;
    }
  }

  /* list of notifications */
  Future<List<dynamic>> getNotificationsList(criteria) async{
    final List<dynamic> res = [];

    for(var i = 1; i < _userSheet.rowCount; i++){
      final item = await getById(i, criteria);
      if(item == null) break;
      print(item.toJson());
      res.add(item);
    }

    return res;
  }

  /* get all the Data except notifications */
  Future<List<dynamic>> getData(id, criteria) async{
    print(_userSheet.title);
    List<dynamic> res = [];

    if(criteria == 'groupEvents') {
      await EventosController.init();
    }

    var item;
    for(var i = 1; i < _userSheet.rowCount; i++){
      if(criteria == 'groupMembers') {
        item = await getById(i, 'user_group');
      }else if(criteria == 'eventsList'){
        item = await getById(i, 'user_group');
      }else if(criteria == 'groupEvents'){
        item = await getById(i, 'eventsList');
      }else{
        item = await getById(i, criteria);
      }
      if(item == null) break;
      print(item.toJson());

      switch(criteria){
        case 'user_group':
          if(id.toString() == item.uid.toString()){
            res.add(item);
          }
          break;
        case 'groupMembers':
          if(id.toString() == item.gid.toString()){
            res.add(item);
          }
          break;
        case 'friendship':
          if(id.toString() == item.uid1.toString()){
            res.add(item);
          }
          break;
        case 'eventsList':
          if(id.toString() == item.uid.toString()){
            res.add(item);
          }
          break;
        case 'groupEvents':
          if(id.toString() == item.gid.toString()){
            res.add(item);
          }
          break;
        default:
          break;
      }
    }
    if(criteria == 'groupEvents') return res;
    return await getFromList(res, criteria);
  }

  /* gets a list and chooses the ones that matters in the list */
  Future<List<dynamic>> getFromList(List<dynamic> list, String criteria) async{
    final List<dynamic> res = [];
    final String criteriaAux = criteria;

    switch(criteria){
      case 'user_group':
        criteria = 'groupsList';
        await GruposController.init();
        break;
      case 'groupMembers':
        criteria = 'users';
        await UsersController.init();
        break;
      case 'friendship':
        criteria = 'users';
        await UsersController.init();
        break;
      case 'eventsList':
        criteria = 'eventsList';
        await EventosController.init();
        break;
      default:
        break;
    }

    for(var i = 1; i < _userSheet.rowCount; i++){
      final item = await getById(i, criteria);
      if(item == null) break;
      print(item.toJson());

      for(var l in list){
        switch(criteriaAux){
          case 'user_group':
            if(item.id.toString() == l.gid.toString()){
              res.add(item);
            }
            break;
          case 'groupMembers':
            if(item.id.toString() == l.uid.toString()){
              res.add(item);
            }
            break;
          case 'friendship':
            if(item.id.toString() == l.uid2.toString()){
              res.add(item);
            }
            break;
          case 'eventsList':
            if(item.gid.toString() == l.gid.toString()){
              res.add(item);

              await GruposController.init();
              criteria = 'groupsList';
              for(var i = 1; i < _userSheet.rowCount; i++) {
                final item = await getById(i, criteria);
                if (item == null) break;
                print(item.toJson());

                if(item.id.toString() == l.gid.toString()){
                  res.add(item);
                  break;
                }
              }
              await EventosController.init();
              criteria = 'eventsList';
            }
            break;
          default:
            break;
        }
      }
    }
    print(res);
    return res;
  }

  /* delete Data */
  Future<bool> deleteById(int id) async{
    if(_userSheet == null) return false;
    final index = await _userSheet.values.rowIndexOf(id);
    if(index == -1) return false;

    return _userSheet.deleteRow(index);
  }

  /* update IDs of gsheets after deleting */
  Future updateDataId({int id, criteria}) async{
    for(var i = id; i < _userSheet.rowCount; i++){
      final item = await getById(i, criteria);
      if(item == null) break;

      /* decrementar o Id 1 unidade (este é final, não dá para fazer com um setter */
      _userSheet.values.insertValueByKeys(item.id - 1, columnKey: 'id', rowKey: i);
    }
  }

  /* insert Data on gsheet */
  Future insertData(Map<String, dynamic> row, criteria) async{
    print(row);
    if(_userSheet == null) return null;

    var i = 1;
    for (i = 1; i < _userSheet.rowCount; i++) {
      final item = await getById(i, criteria);
      if (item == null) break;
      print(item.toJson());
    }

    _userSheet.values.map.appendRow(row);

    /* atualizar o id para o correto */
    switch(criteria){
      case 'friendship':
        _userSheet.values.insertValueByKeys(i, columnKey: 'id', rowKey: row[AmizadeModel.id]);
        break;
      case 'notificationsList':
        _userSheet.values.insertValueByKeys(i, columnKey: 'id', rowKey: row[AmizadeModel.id]);
        break;
      case 'user_group':
        _userSheet.values.insertValueByKeys(i, columnKey: 'id', rowKey: row[UserGroupsModel.id]);
        break;
      case 'users':
        _userSheet.values.insertValueByKeys(i, columnKey: 'id', rowKey: row[Users.id]);
        break;
      case 'groupsList':
        _userSheet.values.insertValueByKeys(i, columnKey: 'id', rowKey: row[GruposModel.id]);
        break;
      case 'eventsList':
        _userSheet.values.insertValueByKeys(i, columnKey: 'id', rowKey: row[EventosModel.id]);
        break;
      default:
        break;
    }
  }

  /* get the id from users */
  Future<dynamic> getValue(input, criteria, value) async{
    print(_userSheet.title);
    if(_userSheet == null) return -1;
    for(var i = 1; i < _userSheet.rowCount; i++){
      final item = await getById(i, criteria);
      if(item == null) break;
      print(item.toJson());

      switch(criteria){
        case 'users':
          if(item.codigo.toString() == input.toString() || item.id.toString() == input.toString()) {
            if(value == 'id') {
              return item.id;
            } else if(value == 'nome'){
              return item.nome;
            }else if(value == 'descricao'){
              return item.descricao;
            }
          }
          break;
        case 'groupsList':
          if(value == 'id'){
            if(item.nome.toString() == input.toString()){
              return item.id;
            }
          }else if(value == 'nome'){
            if(item.id.toString() == input.toString()) return item.nome;
          }
          break;
        case 'friendship':
          if(item.codigo.toString() == input.toString()) return item.nome;
          break;
        case 'eventsList':
          if(value == 'id'){
            if(item.nome.toString() == input.toString()) return item.id.toString();
          }
          else if(value == 'nome'){
            if(item.id.toString() == input.toString()) return item.nome.toString();
          }
          break;
        default:
          print('invalid criteria');
          break;
      }
    }
    return -1;
  }

  Future insertValue(value, id) async{
    if(_userSheet == null) return null;

    _userSheet.values.insertValueByKeys(value, columnKey: 'descricao', rowKey: id);
  }
}
