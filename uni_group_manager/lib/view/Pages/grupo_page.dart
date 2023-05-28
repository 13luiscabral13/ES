import 'dart:math';

import 'package:flutter/material.dart';
import 'package:uni/controller/user_groups_controller.dart';
import 'package:uni/model/grupos_model.dart';

// ignore: must_be_immutable
class GrupoPage extends StatefulWidget {
  final String up;
  final Grupo grupo;

  const GrupoPage({Key key, @required this.grupo, @required this.up}) : super(key: key);

  @override
  _GrupoPageState createState() => _GrupoPageState();
}

class _GrupoPageState extends State<GrupoPage> {
  final UserGroupsController _controller = UserGroupsController('user_group');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('UNI', style: TextStyle(color: Colors.red, fontSize: 45)),
        iconTheme: const IconThemeData(color: Colors.red),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),

              Align(
                alignment: Alignment.center,
                child: Text(widget.grupo.nome, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 40, color: Colors.red)),
              ),

              const SizedBox(height: 24),

              const Align(
                alignment: Alignment.center,
                child: Text('Descrição', style: TextStyle(fontSize: 28, fontWeight: FontWeight.normal, color: Colors.red)),
              ),

              ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: double.infinity,
                  minHeight: 100,
                ),
                child: Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: InkWell(
                      child: Text(widget.grupo.descricao, textAlign: TextAlign.left,),
                    ),
                  ),
                ),
              ),

              FutureBuilder(
                future: Future.wait([fetchData('groupMembers'), fetchData('groupEvents')]),
                builder: (context, data){
                  if(data.hasError){
                    return Text('${data.error}');
                  }else if(data.hasData){
                    final items = data.data as List<dynamic>; //members
                    return Column(
                      children: loadMembersEvents(items),
                    );
                  }
                  else{
                    return const Center(child: CircularProgressIndicator(),);
                  }
                },
              ),

            ],
          ),
        ),
      ),

    );
  }

  Future<dynamic> fetchData(String criteria) async {
    if(criteria == 'groupMembers') {
      return _controller.interface.getData(widget.grupo.id, 'groupMembers');
    } else if(criteria == 'groupEvents') {
      return _controller.interface.getData(widget.grupo.id, 'groupEvents');
    }
  }

  List<Widget> loadMembersEvents(List<dynamic> items) {
    return List<Widget>.generate((items[0].length + items[1].length + 2), (int index) {
      print((items[0].length + items[1].length + 2));
      if(index == 0) {
        return Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              const SizedBox(height: 24),
              Text('Membros', style: TextStyle(fontSize: 28, fontWeight: FontWeight.normal, color: Colors.red)),
              const SizedBox(height: 16),
            ],
          ),
        );
      } else if(index <= items[0].length) {
        return Card(
          elevation: 5,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: InkWell(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.account_circle, color: Colors.primaries[Random().nextInt(Colors.primaries.length)], size: 50,),
                      const SizedBox(width: 15,),
                      Column(
                        children: [
                          Text('${items[0][index-1].nome}', style: const TextStyle(fontSize: 25, color: Colors.black),),
                          Text('${items[0][index-1].codigo}', style: const TextStyle(fontSize: 25, color: Colors.black),),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      } else if(index == items[0].length+1) {
        return Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              const SizedBox(height: 24),
              Text('Eventos', style: TextStyle(fontSize: 28, fontWeight: FontWeight.normal, color: Colors.red)),
              const SizedBox(height: 16),
            ],
          ),
        );
      }
      return Card(
        elevation: 5,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: InkWell(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        Text('${items[1][index - (items[0].length+2)].nome}', style: const TextStyle(fontSize: 25, color: Colors.black),),
                        Row(
                          children: [
                            Text('${items[1][index - (items[0].length+2)].date}', style: const TextStyle(fontSize: 18, color: Colors.black),),
                            Text(' às ', style: const TextStyle(fontSize: 18, color: Colors.black),),
                            Text('${items[1][index - (items[0].length+2)].time}', style: const TextStyle(fontSize: 18, color: Colors.black),),
                          ],
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }

}