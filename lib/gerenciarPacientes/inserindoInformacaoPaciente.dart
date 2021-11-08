import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vacina/banco/bancoFlutterDocs.dart';

import 'package:vacina/models/models.dart';

class InserindoInformacaoPaciente extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inserindo Paciente"),
      ),
      body: InserindoInformacaoPacienteMenu(),
    );
  }
}

// ignore: must_be_immutable
class InserindoInformacaoPacienteMenu extends StatelessWidget {
  final dbHelper = DatabaseHelper.instance;
  final dateFormat = new DateFormat('yyyy-MM-dd');
  //valores para mandar pro banco... eu sei bastante ne kk
  TextEditingController nomePacienteController = new TextEditingController();
  TextEditingController emailPacienteController = new TextEditingController();
  TextEditingController cpfPacienteController = new TextEditingController();
  TextEditingController senhaPacienteController = new TextEditingController();
  //use o controle de data somente para vizualizacao, mas na hora de mandar pro banco use _datetime
  TextEditingController dataNascPacienteController = new TextEditingController()
    ..text = DateFormat('yyyy-MM-dd').format(DateTime.now());
  TextEditingController tipoPacienteController = new TextEditingController();
  TextEditingController condicaoEspecialPacienteController =
      new TextEditingController();
  //datetime que vai pro banco
  DateTime _dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                controller: nomePacienteController,
                decoration: InputDecoration(
                    labelText: 'Nome',
                    suffixIcon: Icon(Icons.supervised_user_circle)),
              ),
              TextField(
                controller: emailPacienteController,
                decoration: InputDecoration(
                    labelText: 'Email',
                    suffixIcon: Icon(Icons.supervised_user_circle)),
              ),
              TextField(
                controller: cpfPacienteController,
                decoration: InputDecoration(
                    labelText: 'CPF',
                    suffixIcon: Icon(Icons.supervised_user_circle)),
              ),
              TextField(
                controller: senhaPacienteController,
                decoration: InputDecoration(
                    labelText: 'Senha',
                    suffixIcon: Icon(Icons.supervised_user_circle)),
              ),
              TextField(
                controller: dataNascPacienteController,
                decoration: InputDecoration(
                  labelText: 'Data-Nasc',
                  suffixIcon: Icon(Icons.supervised_user_circle),
                ),
                onTap: () {
                  showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2001),
                          lastDate: DateTime(2030))
                      .then((value) {
                    _dateTime = value;
                    dataNascPacienteController
                      ..text = dateFormat.format(_dateTime);
                  });
                },
              ),
              TextField(
                controller: tipoPacienteController,
                decoration: InputDecoration(
                    labelText: 'Tipo de Paciente',
                    suffixIcon: Icon(Icons.supervised_user_circle)),
              ),
              TextField(
                controller: condicaoEspecialPacienteController,
                decoration: InputDecoration(
                    labelText: 'Condicao Especial',
                    suffixIcon: Icon(Icons.supervised_user_circle)),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  primary: Colors.black,
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  dbHelper.inserirPaciente(
                      tipoPacienteController.value.text,
                      condicaoEspecialPacienteController.value.text,
                      senhaPacienteController.value.text,
                      nomePacienteController.value.text,
                      emailPacienteController.value.text,
                      cpfPacienteController.value.text,
                      dateFormat.format(_dateTime));
                },
                child: const Text('Inserir Paciente'),
              )
            ],
          )),
    );
  }
}
