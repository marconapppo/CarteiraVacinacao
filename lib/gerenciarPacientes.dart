import 'package:flutter/material.dart';
import 'package:vacina/gerenciarPacientes/editarInformacaoPaciente.dart';
import 'package:vacina/models/models.dart';

import 'banco/bancoFlutterDocs.dart';
import 'gerenciarPacientes/inserindoInformacaoPaciente.dart';

class GerenciarPacientes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gerenciar Pacientes"),
      ),
      backgroundColor: Color.fromARGB(255, 204, 235, 253),
      body: MenuGerenciarPacientes(),
    );
  }
}

class MenuGerenciarPacientes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ElevatedButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue,
              primary: Colors.black,
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => InserindoInformacaoPaciente()));
            },
            child: const Text('Inserir Paciente'),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue,
              primary: Colors.black,
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditandoInformacaoPaciente()));
            },
            child: const Text('Editar Paciente'),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue,
              primary: Colors.black,
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => InserindoInformacaoPaciente()));
            },
            child: const Text('Excluir Paciente'),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
