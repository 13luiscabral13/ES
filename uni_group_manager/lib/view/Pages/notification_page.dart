// ignore_for_file: must_be_immutable

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:uni/controller/events_controller.dart';
import 'package:uni/controller/grupos_controller.dart';
import 'package:uni/controller/interface_controller.dart';
import 'package:uni/controller/invites_controller.dart';
import 'package:uni/controller/notification_controller.dart';
import 'package:uni/view/Pages/home_page_view.dart';

class NotificationPage extends StatefulWidget {
  final String up;
  final int uid;
  int id;
  String nome;
  String codigo;
  String texto;
  String tipo;

  NotificationPage({Key key, @required this.up, @required this.uid, @required this.id, @required this.nome, @required this.codigo, @required this.texto, @required this.tipo}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final NotificationController _controller = NotificationController('notificationsList');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('UNI', style: TextStyle(color: Colors.red, fontSize: 45)),
        iconTheme: const IconThemeData(color: Colors.red),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(padding: EdgeInsets.all(10)),
          Icon(Icons.account_circle, size: 250, color: Colors.primaries[Random().nextInt(Colors.primaries.length)],),
          Column(
            children: [
              const Padding(padding: EdgeInsets.all(15)),
              Text(widget.nome, style: const TextStyle(fontSize: 35, color: Colors.black),),
              Text(widget.texto, style: const TextStyle(fontSize: 25, color: Colors.black54),),
              const SizedBox(height: 45,),

              FutureBuilder(
                  future: groupEventDisplay(widget.codigo, widget.tipo),
                  builder: (context, data){
                    if(data.hasError){
                      return Text('${data.error}');
                    }else if(data.hasData){
                      final nome = data.data as String;
                      return ConstrainedBox(
                          constraints: const BoxConstraints(
                              minWidth: 300,
                              minHeight: 50,
                          ),
                        child: Card(
                          elevation: 5,
                          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          child: InkWell(
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 25),
                              child: Text(nome, style: const TextStyle(fontSize: 25, color: Colors.black,), textAlign: TextAlign.center, ),
                            )
                            ),
                        )
                      );
                    }
                    else{
                      return const SizedBox(height: 0,);
                    }
                  }
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Colors.lightGreen,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton( //accept
                        onPressed: () async {
                          await InvitesController.init(widget.up, 'notificationsList');
                          _controller.acceptInvite(widget.id, widget.codigo, widget.tipo, widget.uid);
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => HomePageView())
                          );
                        },
                        child: const Text('Aceitar', style: TextStyle(color: Colors.white, fontSize: 25),),
                    ),
                  ),
                  const SizedBox(width: 15,),
                  Container(
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton( //deny
                      onPressed: () async {
                        await InvitesController.init(widget.up, 'notificationsList');
                        _controller.rejectInvite(widget.id, widget.tipo, widget.codigo);
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => HomePageView())
                        );
                      },
                      child: const Text('Rejeitar', style: TextStyle(color: Colors.white, fontSize: 25),),
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      )
    );
  }
}

Future<String> groupEventDisplay(String codigo, String tipo) async {
  if(tipo == 'grupo'){
    final InterfaceController interface = InterfaceController('groupsList');
    await GruposController.init();
    return await interface.getValue(codigo, 'groupsList', 'nome');
  }
  else if (tipo == 'evento'){
    final InterfaceController interface = InterfaceController('eventsList');
    await EventosController.init();
    return await interface.getValue(codigo, 'eventsList', 'nome');
  }
  else return null;
}
