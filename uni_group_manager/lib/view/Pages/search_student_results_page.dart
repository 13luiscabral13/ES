import 'package:flutter/material.dart';
import 'package:uni/controller/search_student_results_controller.dart';
import 'dart:math';

class SearchStudentResults extends StatefulWidget {
  final String up;
  final List<dynamic> results;
  const SearchStudentResults({Key key, this.up, this.results}) : super(key: key);

  @override
  _SearchStudentResultsState createState() => _SearchStudentResultsState();
}

class _SearchStudentResultsState extends State<SearchStudentResults> {

  final SearchStudentResultsController _controller = SearchStudentResultsController();

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
          margin: const EdgeInsets.all(20),
          child: createResults(),
        )
    );
  }

  Widget createResults() {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 60,
          child: const Text('Procura de Estudantes', style: TextStyle(fontSize: 26, color: Colors.redAccent),),
        ),
        const SizedBox(height: 30),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Text('Resultados: ' + widget.results.length.toString(), style: const TextStyle(color: Colors.black54, fontSize: 18)),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.black26),
            ),
          ),
        ),
        Column(
          children: loadResults(),
        ),
      ],
    );
  }

  List<Widget> loadResults() {
    return List<Widget>.generate(widget.results.length, (int index) {
      return (
          Row(
            children: <Widget> [
              Expanded(

                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: ListTile(
                    leading: Icon(Icons.account_circle, color: Colors.primaries[Random().nextInt(Colors.primaries.length)], size: 55,),
                    title: Text(widget.results[index].nome.toString(), style: const TextStyle(fontSize: 18),),
                    subtitle: Text(widget.results[index].codigo.toString(), style: const TextStyle(fontSize: 15),),
                    //dense: true,
                    //onTap: () {},
                  ),
                )
              ),
              IconButton(
                onPressed: () {
                  _controller.results.sendFriendRequest(widget.up, widget.results[index]);
                },
                icon: const Icon(Icons.add, color: Colors.red),
                iconSize: 28,
                highlightColor: Colors.red[100],
              ),
              Container(
                width: 10,
              )
            ],
          )
      );
    });
  }
}