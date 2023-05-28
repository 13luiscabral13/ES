import 'package:flutter/material.dart';
import 'package:uni/controller/interface_controller.dart';
import 'package:uni/controller/local_storage/app_shared_preferences.dart';
import 'package:uni/controller/users_controller.dart';

class EditPage extends StatefulWidget {
  final String currentAbout;

  const EditPage({Key key, @required this.currentAbout}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {

  TextEditingController displayAboutController = TextEditingController();
  bool _bioValid = true;

  updateProfileBio() async{
    setState(() {
      displayAboutController.text.trim().length > 280 ? _bioValid = false :
          _bioValid = true;
    });

    if(_bioValid) {
      await UsersController.init();
      final String up = await AppSharedPreferences.getUserNumber();
      final InterfaceController interface = InterfaceController('users');
      final int id = await interface.getValue(up, 'users', 'id');
      interface.insertValue(displayAboutController.text.trim(), id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('UNI', style: TextStyle(color: Colors.red, fontSize: 45)),
        iconTheme: const IconThemeData(color: Colors.red),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.done,
                  size: 30.0,
                  color: Colors.red,
                )
            ),
          ),
        ],
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
            TextField(
              controller: displayAboutController,
              decoration: InputDecoration(
                hintText: widget.currentAbout,
                labelStyle: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),
              key: Key('NewDescriptionField'),
              obscureText: false,
              maxLines: 5,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              onPressed: () async{
                await updateProfileBio();
              },
              child: const Text('Atualizar Perfil', style: TextStyle(color: Colors.red, fontSize: 20.0, fontWeight: FontWeight.bold,),key:Key('UpdateProfileButton'),),
            ),
          )
        ],
      ),
    );
  }
}