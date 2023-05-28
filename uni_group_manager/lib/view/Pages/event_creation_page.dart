import 'package:flutter/material.dart';
import 'package:uni/controller/event_creation_controller.dart';

class EventCreationPage extends StatefulWidget {
  final int id;
  const EventCreationPage({Key key, @required this.id}) : super(key: key);

  @override
  _EventCreationPageState createState() => _EventCreationPageState();
}

class _EventCreationPageState extends State<EventCreationPage> {
  final EventCreationController _controller = EventCreationController('groupsList');
  final GlobalKey<FormState> _eventCreationKey = GlobalKey<FormState>();

  String eventName = '';
  String eventDescription = '';
  Set<dynamic> groupsList = {};
  DateTime eventDateTime = DateTime.now();
  String dropdownValue;
  List<dynamic> groups;
  Future storedFuture;

  @override
  void initState() {
    storedFuture = fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final eventHours = eventDateTime.hour.toString().padLeft(2, '0');
    final eventMinutes = eventDateTime.minute.toString().padLeft(2, '0');

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
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Form(
                  key: _eventCreationKey,
                  child: Column(
                    children: [
                      const Text('Novo Evento', style: TextStyle(fontSize: 27, color: Colors.redAccent,),),
                      Column(
                        children: [
                          const Text('Nome do Evento', style: TextStyle(fontSize: 20, height: 4)),
                          SizedBox(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black45)),
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                                fillColor: Colors.white,
                                filled: true,
                              ),
                              onSaved: (String value) {
                                eventName = value;
                              },
                              validator: _controller.event.checkEventName,
                              key: Key('NomeEventoForm'),
                            ),
                          ),
                        ],
                      ),

                      const Text('Descrição', style: TextStyle(fontSize: 20, height: 4)),
                      TextFormField(
                        keyboardType: TextInputType.multiline,
                        minLines: 3,
                        maxLines: null,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black45)),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        onSaved: (String value) {
                          eventDescription = value;
                        },
                        validator: _controller.event.checkEventDescription,
                        key: Key('DescriEventoForm'),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              const Text('Data', style: TextStyle(fontSize: 20, height: 3)),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(150, 10),
                                  primary: Colors.redAccent,
                                  padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                                ),
                                child: Row(
                                  children: [
                                    Text('${eventDateTime.day}/${eventDateTime.month}/${eventDateTime.year} ', style: TextStyle(fontSize: 18),),
                                    Icon(Icons.calendar_month, size: 20,),
                                  ],
                                ),
                                onPressed: () async {
                                  final date = await _controller.event.selectDate(context, eventDateTime);
                                  if(date == null) return;  // pressed 'CANCEL'
                                  final newDateTime = DateTime(
                                    date.year,
                                    date.month,
                                    date.day,
                                    eventDateTime.hour,
                                    eventDateTime.minute,
                                  );
                                  setState(() {
                                    eventDateTime = newDateTime;
                                  });
                                },
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const Text('Hora', style: TextStyle(fontSize: 20, height: 3)),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(150, 10),
                                  primary: Colors.redAccent,
                                  padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                                ),
                                child: Row(
                                  children: [
                                    Text('$eventHours:$eventMinutes ', style: TextStyle(fontSize: 18),),
                                    Icon(Icons.access_time_rounded, size: 20,),
                                  ],
                                ),
                                onPressed: () async {
                                  final time = await _controller.event.selectTime(context, eventDateTime);
                                  if(time == null) return; // pressed 'CANCEL'
                                  final newDateTime = DateTime(
                                    eventDateTime.year,
                                    eventDateTime.month,
                                    eventDateTime.day,
                                    time.hour,
                                    time.minute,
                                  );
                                  setState(() {
                                    eventDateTime = newDateTime;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 50),
              const Text('Grupo', style: TextStyle(fontSize: 20)),
              const SizedBox(height: 10),
              FutureBuilder(
                future: storedFuture,
                builder: (context, data) {
                  if(data.connectionState == ConnectionState.done) {
                    if(data.hasError) {
                      return Text('${data.error}');
                    } else if(data.hasData) {
                      final items = data.data as List<dynamic>;
                      if(items.isEmpty) {
                        return Text('Não pertence a nenhum grupo.', style: TextStyle(fontSize: 18, color: Colors.orange),);
                      } else {
                        groups = items;
                        return DropdownButton<String>(
                          key: Key('GroupChoiceForm'),
                          dropdownColor: Colors.white,
                          iconSize: 22,
                          icon: const Icon(Icons.group, color: Colors.red),
                          items: loadGroups(),
                          value: dropdownValue,
                          onChanged: (value) async {
                            return setState(()  => this.dropdownValue = value);
                          },
                        );
                      }
                    } else {
                      return const Center(child: CircularProgressIndicator(),);
                    }
                  } else {
                    return const Center(child: CircularProgressIndicator(),);
                  }

                }
              ),
              const SizedBox(height: 50,),
              Container(
                  child: ElevatedButton(
                    key: Key('CreateEventoButton'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.fromLTRB(25, 15, 25, 15),
                      primary: Colors.redAccent,
                    ),
                      child: const Text('Criar Evento', style: TextStyle(fontSize: 20, color: Colors.white),),
                      onPressed: () async {
                        if(_eventCreationKey.currentState.validate()){
                          if(_controller.event.validateDropdownValue(dropdownValue)) {
                            _eventCreationKey.currentState.save();
                            await _controller.event.submit(widget.id, eventName, eventDescription, eventDateTime, dropdownValue);
                            Navigator.pop(context);
                          }
                        }
                      }
                  ),
              )
            ]),
        ),
      ),
    );
  }

  Future<dynamic> fetchData() async {
    return _controller.interface.getData(widget.id, 'user_group');
  }

  List<DropdownMenuItem<String>> loadGroups() {
    return List<DropdownMenuItem<String>>.generate(groups.length+1, (int index) {
      if(index == 0) {
        return DropdownMenuItem(
          value: null,
          child: Container(
            width: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('    Selecionar', style: TextStyle(fontSize: 20),),
              ],
            ),
          ),
        );
      }
      return (
        DropdownMenuItem(
          value: groups[index-1].id.toString(),
          child: Container(
            width: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(groups[index-1].nome.toString(), style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.red[400 + ((index % 2) * 400)],
                ), overflow: TextOverflow.ellipsis,),
                Text(groups[index-1].descricao.toString(), style: TextStyle(fontSize: 14), overflow: TextOverflow.ellipsis,),
              ],
            ),
          ),
        )
      );
    });
  }
}