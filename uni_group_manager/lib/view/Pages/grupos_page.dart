import 'package:flutter/material.dart';
import 'package:uni/controller/amizade_controller.dart';
import 'package:uni/controller/grupos_controller.dart';
import 'package:uni/controller/user_groups_controller.dart';
import 'package:uni/view/Pages/group_creation_page.dart';
import 'package:uni/view/Pages/grupo_page.dart';

class GruposPage extends StatefulWidget {
  const GruposPage({Key key,}) : super(key: key);

  @override
  _GruposPageState createState() => _GruposPageState();
}

class _GruposPageState extends State<GruposPage> {
  final GruposController _controller = GruposController('user_group');

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
              const Text('Grupos', style: TextStyle(fontSize: 35),),
              const SizedBox(height: 10,),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () async{
                    await AmizadeController.init(UserGroupsController.up, UserGroupsController.id);
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => GroupCreationPage(id: UserGroupsController.id)
                    ));
                  },
                  icon: const Icon(Icons.add, color: Colors.red),
                  key: Key('GroupCreationButton'),
                ),
              ),
              const SizedBox(height: 10,),
              Expanded(
                  child: FutureBuilder(
                    future: _controller.interface.getData(UserGroupsController.id, 'user_group'),
                    builder: (context, data) {
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
                                    padding: const EdgeInsets.all(20),
                                    child: Text(items[index].nome, style: const TextStyle(fontSize: 25, color: Colors.black,), textAlign: TextAlign.center,),
                                  ),
                                  onTap: () async {
                                    await UserGroupsController.init(UserGroupsController.up, UserGroupsController.id);
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (_) => GrupoPage(grupo: items[index],up: UserGroupsController.up),
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
