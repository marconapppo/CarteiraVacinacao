import 'package:flutter/material.dart';
import 'package:vacina/gerenciarPacientes/editarInformacaoPaciente.dart';

import 'gerenciarPacientes/inserindoInformacaoPaciente.dart';
import 'gerenciarVacinas/inserindoInformacaoVacina.dart';

class GerenciarVacinas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gerenciar Vacinas"),
      ),
      body: MenuGerenciarVacinas(),
    );
  }
}

class MenuGerenciarVacinas extends StatelessWidget {
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
                      builder: (context) => InserindoInformacaoVacina()));
            },
            child: const Text('Inserir Vacina'),
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
