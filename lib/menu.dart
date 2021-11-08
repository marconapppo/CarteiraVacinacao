import 'package:flutter/material.dart';
import 'package:vacina/gerenciarPacientes.dart';
import 'package:vacina/gerenciarVacinas.dart';
import 'package:vacina/gerenciarVacinasAplicadas.dart';

import 'banco/bancoFlutterDocs.dart';
import 'cadastro.dart';
import 'gerenciarVacinas.dart';
//import 'package:flutter/src/widgets/framework.dart';
import 'models/UserCpf.dart' as user;

class Menu extends StatefulWidget {
  @override
  _Menu createState() => _Menu();
}

class _Menu extends State<Menu> {
  final dbHelper = DatabaseHelper.instance;
  bool Adm = false;

  @override
  void initState() {
    dbHelper.getAdm(user.cpf).then((value) {
      setState(() {
        Adm = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        //grupo de botoes
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ElevatedButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue,
              primary: Colors.black,
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => VacinasAplicadas()));
            },
            child: const Text('Gerenciar Vacinas Aplicadas'),
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
                      builder: (context) => GerenciarPacientes()));
            },
            child: const Text('Gerenciar Pacientes'),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue,
              primary: Colors.black,
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => GerenciarVacinas()));
            },
            child: const Text('Gerenciar Vacina'),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue,
              primary: Colors.black,
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: Adm
                ? () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Cadastro()))
                : null,
            child: const Text('Cadastrar Profissional Saude'),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue,
              primary: Colors.black,
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {},
            child: const Text('Sair'),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
