import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'banco/bancoFlutterDocs.dart';

class Cadastro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastrando Profissional Saude"),
      ),
      backgroundColor: Color.fromARGB(255, 204, 235, 253),
      body: InserindoInformacaoProfissionalSaudeMenu(),
    );
  }
}

class InserindoInformacaoProfissionalSaudeMenu extends StatelessWidget {
  final dbHelper = DatabaseHelper.instance;
  final dateFormat = new DateFormat('yyyy-MM-dd');
  //valores para mandar pro banco... eu sei bastante ne kk
  TextEditingController nomeProfissionalController =
      new TextEditingController();
  TextEditingController emailProfissionalController =
      new TextEditingController();
  TextEditingController cpfProfissionalController = new TextEditingController();
  //use o controle de data somente para vizualizacao, mas na hora de mandar pro banco use _datetime
  TextEditingController dataNascProfissionalController =
      new TextEditingController()
        ..text = DateFormat('yyyy-MM-dd').format(DateTime.now());
  TextEditingController SenhaProfissionalController =
      new TextEditingController();
  TextEditingController AdmProfissionalController = new TextEditingController();
  TextEditingController tipoProfissionalController =
      new TextEditingController();
  TextEditingController CrmProfissionalController = new TextEditingController();
  //datetime que vai pro banco
  DateTime _dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 204, 235, 253),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                controller: nomeProfissionalController,
                decoration: InputDecoration(
                    labelText: 'Nome',
                    suffixIcon: Icon(Icons.supervised_user_circle)),
              ),
              TextField(
                controller: emailProfissionalController,
                decoration: InputDecoration(
                    labelText: 'Email',
                    suffixIcon: Icon(Icons.supervised_user_circle)),
              ),
              TextField(
                controller: cpfProfissionalController,
                decoration: InputDecoration(
                    labelText: 'CPF',
                    suffixIcon: Icon(Icons.supervised_user_circle)),
              ),
              TextField(
                controller: dataNascProfissionalController,
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
                    dataNascProfissionalController
                      ..text = dateFormat.format(_dateTime);
                  });
                },
              ),
              TextField(
                controller: SenhaProfissionalController,
                decoration: InputDecoration(
                    labelText: 'Senha de Profissional de Saude',
                    suffixIcon: Icon(Icons.supervised_user_circle)),
              ),
              TextField(
                controller: AdmProfissionalController,
                decoration: InputDecoration(
                    labelText: 'Adm de Profissional de Saude',
                    suffixIcon: Icon(Icons.supervised_user_circle)),
              ),
              TextField(
                controller: tipoProfissionalController,
                decoration: InputDecoration(
                    labelText: 'tipo de profissional',
                    suffixIcon: Icon(Icons.supervised_user_circle)),
              ),
              TextField(
                controller: CrmProfissionalController,
                decoration: InputDecoration(
                    labelText: 'CRM do profissional',
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
                  dbHelper.inserirProfissional(
                      AdmProfissionalController.text,
                      tipoProfissionalController.text,
                      CrmProfissionalController.text,
                      SenhaProfissionalController.text,
                      nomeProfissionalController.text,
                      emailProfissionalController.text,
                      cpfProfissionalController.text,
                      dateFormat.format(_dateTime));
                },
                child: const Text('Cadastrar Profissional da Saúde'),
              )
            ],
          )),
    );
  }
}
