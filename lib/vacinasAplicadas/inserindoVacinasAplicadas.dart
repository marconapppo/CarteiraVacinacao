import 'package:flutter/material.dart';

class InserindoVacinasAplicadas extends StatelessWidget {
  InserindoVacinasAplicadas(this.namePaciente);

  final String namePaciente;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inserindo Vacinas Aplicadas"),
      ),
      body: InserindoVacinasAplicadasMenu(namePaciente),
    );
  }
}

class InserindoVacinasAplicadasMenu extends StatelessWidget {
  InserindoVacinasAplicadasMenu(this.namePaciente);

  final String namePaciente;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
                labelText: namePaciente,
                suffixIcon: Icon(Icons.supervised_user_circle)),
          ),
        ],
      ),
    );
  }
}
