import 'dart:math';

import 'package:flutter/material.dart';
import 'package:uni/controller/group_creation_controller.dart';

class GroupCreationPage extends StatefulWidget {
  final int id;
  const GroupCreationPage({Key key, @required this.id}) : super(key: key);

  @override
  _GroupCreationPageState createState() => _GroupCreationPageState();
}

class _GroupCreationPageState extends State<GroupCreationPage> {
  final GroupCreationController _controller = GroupCreationController('friendship');
  final GlobalKey<FormState> _groupCreationKey = GlobalKey<FormState>();

  String groupName = '';
  String groupDescription = '';
  Set<dynamic> groupMembers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
            'UNI', style: TextStyle(color: Colors.red, fontSize: 45)),
        iconTheme: const IconThemeData(color: Colors.red),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
          child: Column(
            children: [
              Form(
                key: _groupCreationKey,
                child: Column(
                  children: [
                    const Text('Novo Grupo', style: TextStyle(fontSize: 26, color: Colors.redAccent),),
                    const Text('Nome do Grupo', style: TextStyle(fontSize: 18, height: 4)),
                    TextFormField(
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black45)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      onSaved: (String value) {
                        groupName = value;
                      },
                      validator: _controller.group.checkNameGroup,
                      key: Key('NomeForm'),
                    ),
                    const Text('Descrição', style: TextStyle(fontSize: 18, height: 4)),
                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      minLines: 3,
                      maxLines: null,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black45)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      onSaved: (String value) {
                        groupDescription = value;
                      },
                      validator: _controller.group.checkDescription,
                      key: Key('DiscForm'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: FutureBuilder(
                  future: _controller.interface.getData(widget.id, 'friendship'),
                  builder: (context, data){
                    if(data.hasError){
                      return Text('${data.error}');
                    }else if(data.hasData){
                      final items = data.data as List<dynamic>;
                      return ListView.builder(
                          itemCount: items == null? 0: items.length,
                          itemBuilder: (context, index){
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
                                          Container(
                                            child: Column(
                                              children: [
                                                Text(items[index].nome, style: const TextStyle(fontSize: 25, color: Colors.black54),),
                                                Text(items[index].codigo, style: const TextStyle(fontSize: 25, color: Colors.black54),),
                                              ],
                                            ),
                                          ),
                                          IconButton(
                                            padding: EdgeInsets.fromLTRB(25, 0, 15, 0),
                                            onPressed: () {
                                              groupMembers.add(items[index]);
                                              print(groupMembers);
                                            },
                                            icon: Icon(Icons.add),
                                            focusColor: Colors.amber,
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                      );
                    }else{
                      return const Center(child: CircularProgressIndicator(),);
                    }
                  },
                ),
              ),
              const SizedBox(height: 15,),
              Container(
                padding: const EdgeInsets.all(15),
                child: TextButton(
                    key: Key('CreateButton'),
                  child: const Text('Criar Grupo', style: TextStyle(fontSize: 20, color: Colors.white),),
                  onPressed: () async {
                    if(_groupCreationKey.currentState.validate()){
                      _groupCreationKey.currentState.save();
                      await _controller.group.submit(widget.id, groupName, groupDescription, groupMembers);
                    }
                    Navigator.pop(context);
                  }
                ),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(10),
                )
              )
            ]),
        ),
    );
  }
}