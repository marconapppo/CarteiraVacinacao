import 'package:flutter/material.dart';
import 'package:vacina/banco/bancoFlutterDocs.dart';
import 'package:vacina/models/models.dart';

class EditandoInformacaoPaciente extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editando Paciente"),
      ),
      body: HomePage(),
    );
  }
}

class EditandoInformacaoPacienteMenu extends StatefulWidget {
  final Paciente paciente;

  EditandoInformacaoPacienteMenu({Key key, this.paciente}) : super(key: key);

  @override
  _EditandoInformacaoPacienteMenuState createState() =>
      _EditandoInformacaoPacienteMenuState();
}

class _EditandoInformacaoPacienteMenuState
    extends State<EditandoInformacaoPacienteMenu> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

//listTile with search
class _HomePageState extends State<HomePage> {
  //inicializador do banco
  final dbHelper = DatabaseHelper.instance;
  List<Map<String, dynamic>> pacientes;

  // This list holds the data for the list view
  List<Map<String, dynamic>> _foundUsers = [];
  @override
  initState() {
    // at the beginning, all users are shown

    //utilizando then para futuro
    dbHelper.allPaciente().then((value) {
      setState(() {
        pacientes = value;
        _foundUsers = pacientes;
      });
    });
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = pacientes;
    } else {
      results = pacientes
          .where((user) =>
              user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: InputDecoration(
                  labelText: 'Search', suffixIcon: Icon(Icons.search)),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: _foundUsers.length > 0
                  ? ListView.builder(
                      itemCount: _foundUsers.length,
                      // front-end
                      itemBuilder: (context, index) => Card(
                        key: ValueKey(_foundUsers[index]["id"]),
                        color: Colors.blue,
                        elevation: 4,
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          //continuação trab
                          onTap: () {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) =>
                                        new EditandoInformacaoPacienteMenu(
                                            paciente: new Paciente(
                                                _foundUsers[index]['name'],
                                                28))));
                          },
                          leading: Icon(
                            Icons.account_circle,
                            color: Colors.black,
                          ),
                          title: Text(_foundUsers[index]['name']),
                          subtitle: Text(
                              '${_foundUsers[index]["age"].toString()} years old'),
                        ),
                      ),
                    )
                  : Text(
                      'No results found',
                      style: TextStyle(fontSize: 24),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
