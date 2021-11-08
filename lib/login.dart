import 'dart:io';

import 'package:flutter/material.dart';

import 'banco/bancoFlutterDocs.dart';
import 'main.dart';
import 'package:vacina/gerenciarVacinasAplicadas.dart';

import 'models/UserCpf.dart' as user;

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: LoginMenu(),
    );
  }
}

class LoginMenu extends StatefulWidget {
  @override
  _LoginMenu createState() => _LoginMenu();
}

class _LoginMenu extends State<LoginMenu> {
  final dbHelper = DatabaseHelper.instance;
  //valores para mandar pro banco
  TextEditingController cpfController = new TextEditingController();
  //use o controle de data somente para vizualizacao, mas na hora de mandar pro banco use _datetime
  TextEditingController SenhaController = new TextEditingController();
  bool validacaoUser = false;

  int pacienteId;

  //comboBox
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentUsuario;

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentUsuario = _dropDownMenuItems[0].value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                controller: cpfController,
                decoration: InputDecoration(
                    labelText: 'Cpf',
                    suffixIcon: Icon(Icons.supervised_user_circle)),
              ),
              TextField(
                controller: SenhaController,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: 'Senha',
                    suffixIcon: Icon(Icons.supervised_user_circle)),
              ),
              DropdownButton(
                value: _currentUsuario,
                items: _dropDownMenuItems,
                onChanged: (value) {
                  setState(() {
                    _currentUsuario = value;
                  });
                },
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
                onPressed: () async {
                  user.cpf = cpfController.text;
                  validacaoUser = false;
                  if (_currentUsuario == "Profissional") {
                    await dbHelper
                        .getUsuarioProfissional(
                            cpfController.text, SenhaController.text)
                        .then((value) {
                      setState(() {
                        validacaoUser = value;
                      });
                    });
                    sleep(Duration(seconds: 1));
                    if (validacaoUser == true) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MainMenuProfissional()));
                    } else {
                      print("n deu");
                    }
                  } else {
                    await dbHelper
                        .getUsuarioPaciente(
                            cpfController.text, SenhaController.text)
                        .then((value) {
                      setState(() {
                        validacaoUser = value;
                      });
                    });
                    await dbHelper
                        .getIdPaciente(cpfController.text)
                        .then((value) {
                      setState(() {
                        pacienteId = value;
                      });
                    });
                    if (validacaoUser == true) {
                      user.cpf = null;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PacienteInformacaoProMedico(
                                  pacienteId: pacienteId)));
                    } else {
                      print("n deu");
                    }
                  }
                },
                child: const Text('Login'),
              )
            ],
          )),
    );
  }
}

List<DropdownMenuItem<String>> getDropDownMenuItems() {
  List<DropdownMenuItem<String>> items = new List();
  List tipoUsuario = ["Profissional", "Paciente"];
  for (String item in tipoUsuario) {
    items.add(new DropdownMenuItem(value: item, child: new Text(item)));
  }
  return items;
}
