import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vacina/models/models.dart';
import 'package:vacina/banco/bancoFlutterDocs.dart';
import 'package:vacina/vacinasAplicadas/inserindoVacinasAplicadas.dart';
//import 'package:flutter/src/widgets/framework.dart';

class VacinasAplicadas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vacinas Aplicadas"),
      ),
      body: HomePage(),
    );
  }
}

//listTile with search
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
                                        new PacienteInformacaoProMedico(
                                            pacienteId: int.parse(
                                                _foundUsers[index]["id"]))));
                          },
                          leading: Icon(
                            Icons.account_circle,
                            color: Colors.black,
                          ),
                          title: Text(_foundUsers[index]['name']),
                          subtitle:
                              Text('${_foundUsers[index]["email"]} years old'),
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

//dentro do nome paciente

class PacienteInformacaoProMedico extends StatefulWidget {
  final int pacienteId;

  PacienteInformacaoProMedico({Key key, this.pacienteId}) : super(key: key);

  @override
  _PacienteInformacaoProMedicoState createState() =>
      _PacienteInformacaoProMedicoState();
}

class _PacienteInformacaoProMedicoState
    extends State<PacienteInformacaoProMedico> {
  final dbHelper = DatabaseHelper.instance;
  Paciente paciente;

  //controllers
  var nomePacienteController = TextEditingController()..text = "nome";
  var condicaoPacienteController = TextEditingController()..text = "Nenhuma";
  var dataPacienteController = TextEditingController()..text = "Data";

  //listas
  List<Map<String, dynamic>> _allVacinas = [];

  @override
  void initState() {
    dbHelper.getPaciente(widget.pacienteId).then((value) {
      setState(() {
        paciente = value;
        nomePacienteController.text = value.name;
        condicaoPacienteController.text = value.condicaoEspecial;
        dataPacienteController.text = value.dataNasc;
      });
    });
    dbHelper.getVacinaIdNomeDose(widget.pacienteId).then((value) {
      setState(() {
        _allVacinas = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vacinas Aplicadas"),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            //Alterções quanto ao front devem ser implementadas no InputDecoration, lembrar de disabilitar o
            //TextFormFild sim usar enabled : false, pois este cancela as alterções de InputDecoration
            TextFormField(
              controller: nomePacienteController,
              enabled: false,
              decoration: InputDecoration(
                labelText: 'Nome:',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            //condicao Especial (lembrar de alocar do banco aqui dps no initialValue)
            TextFormField(
              controller: condicaoPacienteController,
              enabled: false,
              decoration:
                  const InputDecoration(labelText: 'Condicao Especial:'),
            ),
            SizedBox(
              height: 20,
            ),
            //data Nascimento (fica pro futuro)
            TextFormField(
              controller: dataPacienteController,
              enabled: false,
              decoration: const InputDecoration(labelText: 'Data Nascimento:'),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              //style: style,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            InserindoVacinasAplicadas(paciente.name)));
              },
              child: const Text('inserir'),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              //style: style,
              onPressed: () {},
              child: const Text('excluir'),
            ),
            Expanded(
              child: _allVacinas.length > 0
                  ? ListView.builder(
                      itemCount: _allVacinas.length,
                      // front-end
                      itemBuilder: (context, index) => Card(
                        key: ValueKey(_allVacinas[index]["id"]),
                        color: Colors.blue,
                        elevation: 4,
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          //continuação trab
                          onTap: () {
                            setState(() {
                              //_allVacinas.removeAt(0);
                            });
                          },
                          leading: Icon(
                            Icons.medical_services_outlined,
                            color: Colors.black,
                          ),
                          title: Text(_allVacinas[index]['name']),
                          subtitle: Text(
                              '${_allVacinas[index]["dose"].toString()} dose'),
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
