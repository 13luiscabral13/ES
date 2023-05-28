import 'package:flutter/material.dart';
import 'package:uni/controller/events_controller.dart';
import 'package:uni/controller/user_groups_controller.dart';
import 'package:uni/view/Pages/evento_page.dart';
import 'event_creation_page.dart';


class EventosPage extends StatefulWidget {
  const EventosPage({Key key,}) : super(key: key);

  @override
  _EventosPageState createState() => _EventosPageState();
}

class _EventosPageState extends State<EventosPage> {

  final EventosController _controller = EventosController('eventsList');

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
              const Text('Eventos', style: TextStyle(fontSize: 35),),
              const SizedBox(height: 10,),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () async{
                    await UserGroupsController.init(UserGroupsController.up, UserGroupsController.id);
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EventCreationPage(id: UserGroupsController.id)
                      ));
                  },
                  icon: const Icon(Icons.add, color: Colors.red),
                  key: Key('EventCreationButton'),
                ),
              ),
              const SizedBox(height: 10,),
              Expanded(
                  child: FutureBuilder(
                    future: _controller.interface.getData(UserGroupsController.id, 'eventsList'),
                    builder: (context, data) {
                      if(data.hasError){
                        return Text('${data.error}');
                      }else if(data.hasData){
                        final items = data.data as List<dynamic>;
                        return ListView.builder(
                          // ignore: unnecessary_null_comparison
                            itemCount: items == null? 0: (items.length~/2),
                            itemBuilder: (context, index) {
                              index += index;
                              return Card(
                                elevation: 5,
                                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                child: InkWell(
                                  child: Container(
                                    padding: const EdgeInsets.all(20),
                                    child: Row(
                                      children: [
                                        Text(items[index].nome, style: const TextStyle(fontSize: 25, color: Colors.black,), textAlign: TextAlign.center, overflow: TextOverflow.ellipsis,),
                                        SizedBox(width: 15,),
                                        Text(items[index+1].nome, style: const TextStyle(fontSize: 20), overflow: TextOverflow.ellipsis,),
                                        SizedBox(width: 15,),
                                        Column(
                                          children: [
                                            Text(items[index].date, style: const TextStyle(fontSize: 15), overflow: TextOverflow.ellipsis,),
                                            Text(items[index].time, style: const TextStyle(fontSize: 15), overflow: TextOverflow.ellipsis,),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () async {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (_) => EventoPage(evento: items[index],up: UserGroupsController.up),
                                        ));
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