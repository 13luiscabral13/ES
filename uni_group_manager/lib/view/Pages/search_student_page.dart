import 'package:flutter/material.dart';
import 'package:uni/controller/search_student_controller.dart';

class SearchStudent extends StatefulWidget {
  final String up;

  const SearchStudent({Key key, this.up}) : super(key: key);

  @override
  _SearchStudentState createState() => _SearchStudentState();
}

class _SearchStudentState extends State<SearchStudent> {
  String nome = '';
  String codigo = '';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SearchStudentController _controller = SearchStudentController();

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
        child: Form(
          key:_formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 60,
                    child: const Text('Procura de Estudantes', style: TextStyle(fontSize: 26, color: Colors.redAccent),),
                  ),
                  const Text('Código', style: TextStyle(fontSize: 19, height: 2.5)),
                  TextFormField(
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black45)),
                      focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                      errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                      focusedErrorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                      fillColor: Colors.black12,
                      filled: true,
                      labelText: 'Código do estudante',
                      labelStyle: const TextStyle(fontSize: 15, color: Colors.black38),
                      floatingLabelStyle: MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
                        final Color color = states.contains(MaterialState.error)
                            ? Theme.of(context).errorColor
                            : Colors.blue;
                        return TextStyle(color: color);
                      }),
                    ),
                    key: Key('CódigoField'),
                    onSaved: (String value){
                      codigo = value;
                    },
                    validator: _controller.search.checkCodeValid,
                  ),
                  const SizedBox(height: 10),
                  const Text('Nome', style: TextStyle(fontSize: 19, height: 2.5)),
                  TextFormField(
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black45)),
                      focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                      fillColor: Colors.black12,
                      filled: true,
                      labelText: 'Nome do estudante',
                      labelStyle: const TextStyle(fontSize: 15, color: Colors.black38),
                      floatingLabelStyle: MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
                        final Color color = states.contains(MaterialState.error)
                            ? Theme.of(context).errorColor
                            : Colors.blue;
                        return TextStyle(color: color);
                      }),
                    ),
                    key: Key('NameField'),
                    onSaved: (String value){
                      nome = value;
                    },
                  ),
                  const SizedBox(height: 50,),
                  Container(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        key: Key('SearchButton'),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.redAccent,
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12)
                          ),
                          child: const Text('Procurar', style: TextStyle(color: Colors.white70, fontSize: 16, fontWeight: FontWeight.bold)),
                          onPressed: () {
                            if(_formKey.currentState.validate()){
                              _formKey.currentState.save();
                              _controller.search.submit(nome, codigo, widget.up, context);
                            }
                          }
                      )
                  )
                ]
            )
        ),
      )
    );
  }
}

