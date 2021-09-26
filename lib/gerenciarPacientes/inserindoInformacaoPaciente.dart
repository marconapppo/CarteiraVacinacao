import 'package:flutter/material.dart';
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
  TextEditingController nomePacienteController = new TextEditingController();
  TextEditingController idadePacienteController = new TextEditingController();
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
                controller: idadePacienteController,
                decoration: InputDecoration(
                    labelText: 'Age',
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
                  // Paciente paciente = new Paciente(nomePacienteController.text,
                  //     int.parse(idadePacienteController.text));
                  // dbHelper.inserirPaciente(paciente);
                },
                child: const Text('Inserir Paciente'),
              )
            ],
          )),
    );
  }
}
