
import 'package:flutter/material.dart';
import 'package:uni/controller/invites_controller.dart';
import 'package:uni/view/Pages/notification_page.dart';

class InvitesPage extends StatefulWidget {
  final String up;
  final int id;
  const InvitesPage({Key key, this.up, this.id}) : super(key: key);

  @override
  _InvitesPageState createState() => _InvitesPageState();
}

class _InvitesPageState extends State<InvitesPage> {
  final InvitesController _controller = InvitesController('notificationsList');

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
        children: [
          const SizedBox(height: 15,),
          const Text('Notificações', style: TextStyle(fontSize: 35),),
          const SizedBox(height: 10,),
          Expanded(
            child: FutureBuilder(
              future: _controller.interface.getNotificationsList('notificationsList'),
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
                                  Text(items[index].nome, style: const TextStyle(fontSize: 25, color: Colors.black),),
                                  Text(items[index].texto, style: const TextStyle(fontSize: 20, color: Colors.black54),),
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          NotificationPage(
                                            up: widget.up,
                                            uid: widget.id,
                                            id: items[index].id,
                                            nome: items[index].nome,
                                            codigo: items[index].codigo,
                                            texto: items[index].texto,
                                            tipo: items[index].tipo,)
                                  )
                              );
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
      )
    );
  }
}
