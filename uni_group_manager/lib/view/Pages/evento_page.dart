import 'dart:math';

import 'package:flutter/material.dart';
import 'package:uni/controller/events_controller.dart';
import 'package:uni/model/events_model.dart';


// ignore: must_be_immutable
class EventoPage extends StatefulWidget {
  final String up;
  final Evento evento;

  const EventoPage({Key key, @required this.evento, @required this.up}) : super(key: key);

  @override
  _EventoPageState createState() => _EventoPageState();
}

class _EventoPageState extends State<EventoPage> {
  final EventosController _controller = EventosController('eventoList');

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
          const SizedBox(height: 24),
          Text(widget.evento.nome, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 40, color: Colors.red)),
          const SizedBox(height: 24),
          Text('Descrição do evento', style: TextStyle(fontSize: 30, fontWeight: FontWeight.normal, color: Colors.red)),
          ConstrainedBox(
            constraints: const BoxConstraints(
                minWidth: double.infinity,
                minHeight: 150
            ),
            child: Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: InkWell(
                    child: Text(widget.evento.descricao, textAlign: TextAlign.left,),
                  ),
                )
            ),
          ),
          SizedBox(height: 24,),
          Text("Horário", style: TextStyle(fontSize: 30, color: Colors.redAccent),),
          SizedBox(height: 24,),
          Text("${widget.evento.date} pelas ${widget.evento.time}", style: TextStyle(fontSize: 24),),
        ],
      ),
    );
  }

}