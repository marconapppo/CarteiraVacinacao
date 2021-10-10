import 'package:flutter/material.dart';
import 'package:vacina/models/models.dart';

import 'package:vacina/models/UserCpf.dart' as user;

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

class InserindoVacinasAplicadasMenu extends StatefulWidget {
  InserindoVacinasAplicadasMenu(this.namePaciente);

  final String namePaciente;

  @override
  _InserindoVacinasAplicadasMenu createState() =>
      _InserindoVacinasAplicadasMenu(namePaciente);
}

class _InserindoVacinasAplicadasMenu
    extends State<InserindoVacinasAplicadasMenu> {
  _InserindoVacinasAplicadasMenu(this.namePaciente);

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
          ElevatedButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue,
              primary: Colors.black,
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {
              //print(usuario.cpf);
              print(user.cpf);
            },
            child: const Text('Cadastrar Profissional da Saúde'),
          )
        ],
      ),
    );
  }
}
