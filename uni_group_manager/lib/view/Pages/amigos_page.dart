import 'dart:math';
import 'package:flutter/material.dart';
import 'package:uni/controller/amizade_controller.dart';
import 'package:uni/view/Pages/search_student_page.dart';

class AmigosPage extends StatefulWidget {
  const AmigosPage({Key key,}) : super(key: key);

  @override
  _AmigosPageState createState() => _AmigosPageState();
}

class _AmigosPageState extends State<AmigosPage> {
  final AmizadeController _controller = AmizadeController('friendship');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('UNI', style: TextStyle(color: Colors.red, fontSize: 45)),
          iconTheme: const IconThemeData(color: Colors.red),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              const SizedBox(height: 10,),
              const Text('Amigos', style: TextStyle(fontSize: 35),),
              const SizedBox(height: 10,),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SearchStudent(up: AmizadeController.up)
                      ));
                  },
                  icon: const Icon(Icons.add, color: Colors.red),
                  key: Key('AddFriendButton'),
                ),
              ),
              const SizedBox(height: 10,),
              Expanded(
                  child: FutureBuilder(
                    future: _controller.interface.getData(AmizadeController.id, 'friendship'),
                    builder: (context, data){
                      if(data.hasError){
                        return Text('${data.error}');
                      }else if(data.hasData){
                        final items = data.data as List<dynamic>;
                        return ListView.builder(
                          // ignore: unnecessary_null_comparison
                            itemCount: items == null? 0: items.length,
                            itemBuilder: (context, index) {
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
                                                Text(items[index].nome, style: const TextStyle(fontSize: 25, color: Colors.black54),),
                                                Text(items[index].codigo, style: const TextStyle(fontSize: 25, color: Colors.black54),),
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () {

                                  },
                                ),
                              );
                            });
                      }else{
                        return const Center(child: CircularProgressIndicator(),);
                      }
                    },
                  )
              )
            ],
          ),
        )
    );

  }
}
