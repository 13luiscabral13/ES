import 'dart:io';
import 'package:uni/controller/interface_controller.dart';
import 'package:uni/controller/load_info.dart';
import 'package:uni/controller/local_storage/app_shared_preferences.dart';
import 'package:uni/controller/users_controller.dart';
import 'package:uni/model/app_state.dart';
import 'package:uni/model/entities/course.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:uni/view/Pages/edit_page.dart';
import 'package:uni/view/Pages/unnamed_page_view.dart';
import 'package:uni/view/Widgets/account_info_card.dart';
import 'package:uni/view/Widgets/course_info_card.dart';
import 'package:uni/view/Widgets/print_info_card.dart';

class ProfilePageView extends StatefulWidget {
  final String name;
  final String email;
  final Map<String, String> currentState;
  final List<Course> courses;
  ProfilePageView(
      {Key key,
      @required this.name,
      @required this.email,
      @required this.currentState,
      @required this.courses});
  @override
  State<StatefulWidget> createState() => ProfilePageViewState(
      name: name, email: email, currentState: currentState, courses: courses);
}

/// Manages the 'Personal user page' section.
class ProfilePageViewState extends UnnamedPageView {
  ProfilePageViewState(
      {Key key,
      @required this.name,
      @required this.email,
      @required this.currentState,
      @required this.courses});
  final String name;
  final String email;
  final Map<String, String> currentState;
  final List<Course> courses;

  @override
  Widget getBody(BuildContext context) {
    return FutureBuilder(
      future: childrenList(context),
      builder: (context, data) {
        final items = data.data as List<dynamic>;
        return ListView.builder(
          itemCount: items == null? 0: items.length,
          itemBuilder: (context, index) {
            return data.data[index];
          }
        );
      },
    );
  }

  @override
  Widget getTopRightButton(BuildContext context) {
    return Container();
  }

  /// Returns a list with all the children widgets of this page.
  Future<List<Widget>> childrenList(BuildContext context) async{
    await UsersController.init();
    final String up = await AppSharedPreferences.getUserNumber();
    final InterfaceController interface = InterfaceController('users');
    final String descricao = await interface.getValue(up, 'users', 'descricao');

    final List<Widget> list = [];
    list.add(Align(
      alignment: Alignment.topRight,
      child:TextButton(
        child: Text('Edit'),
        onPressed: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => EditPage(currentAbout: descricao,)
              ));
        }
        ,key: Key("EditPageButton"),)
      )
    );
    list.add(Padding(padding: const EdgeInsets.fromLTRB(5.0, 0, 5.0, 5.0)));
    list.add(profileInfo(context));
    list.add(Padding(padding: const EdgeInsets.all(5.0)));
    list.add(const SizedBox(height: 15,));

    list.add(Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.topLeft,
      child: Text('Descrição', style: TextStyle(fontSize: 24, fontWeight: FontWeight.normal, color: Colors.red)),
    ),);

    // ir buscar a descrição à gsheets
    list.add(ConstrainedBox(
      constraints: const BoxConstraints(
          minWidth: double.infinity,
      ),
      child: Card(
          elevation: 5,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Container(
            padding: const EdgeInsets.all(10),
            child: InkWell(
              child: Text(descricao, textAlign: TextAlign.left,),
            ),
          )
      ),
    ),);
    for (var i = 0; i < courses.length; i++) {
      list.add(CourseInfoCard(
          course: courses[i],
          courseState:
              currentState == null ? '?' : currentState[courses[i].name]));
      list.add(Padding(padding: const EdgeInsets.all(5.0)));
    }
    list.add(PrintInfoCard());
    list.add(Padding(padding: const EdgeInsets.all(5.0)));
    list.add(AccountInfoCard());
    return list;
  }

  /// Returns a widget with the user's profile info (Picture, name and email).
  Widget profileInfo(BuildContext context) {
    return StoreConnector<AppState, Future<File>>(
      converter: (store) => loadProfilePic(store),
      builder: (context, profilePicFile) => FutureBuilder(
        future: profilePicFile,
        builder: (BuildContext context, AsyncSnapshot<File> profilePic) =>
            Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                width: 150.0,
                height: 150.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: getDecorageImage(profilePic.data))),
            Padding(padding: const EdgeInsets.all(8.0)),
            Text(name,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400)),
            Padding(padding: const EdgeInsets.all(5.0)),
            Text(email,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300)),
          ],
        ),
      ),
    );
  }
}
