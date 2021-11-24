import 'package:flutter/material.dart';
import 'package:vacina/banco/bancoFlutterDocs.dart';
import 'package:vacina/models/UserCpf.dart' as user;

class InformacaoVacina extends StatelessWidget {
  InformacaoVacina(this.vacinaId, this.pacienteId);

  final int vacinaId;
  final int pacienteId;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vacina informacoes"),
      ),
      backgroundColor: Color.fromARGB(255, 204, 235, 253),
      body: InformacaoVacinaMenu(vacinaId, pacienteId),
    );
  }
}

class InformacaoVacinaMenu extends StatefulWidget {
  InformacaoVacinaMenu(this.vacinaId, this.pacienteId);

  final int vacinaId;
  final int pacienteId;

  @override
  _InformacaoVacinaMenuMenu createState() =>
      _InformacaoVacinaMenuMenu(vacinaId, pacienteId);
}

class _InformacaoVacinaMenuMenu extends State<InformacaoVacinaMenu> {
  _InformacaoVacinaMenuMenu(this.vacinaId, this.pacienteId);

  final int vacinaId;
  final int pacienteId;

  final dbHelper = DatabaseHelper.instance;

  //controllers
  var nomeVacinaController = TextEditingController()..text = "nome";
  var loteVacinaController = TextEditingController()..text = "lote";
  var validadeVacinaController = TextEditingController()..text = "validade";
  var quantidadeVacinaController = TextEditingController()..text = "quantidade";
  var labVacinaController = TextEditingController()..text = "laboratorio";

  //vairaveis
  int labId = 0;

  //listas
  List<String> informacaoVacina = [];

  @override
  initState() {
    dbHelper.getVacina(vacinaId).then((value) {
      setState(() {
        informacaoVacina = value;
        nomeVacinaController.text = informacaoVacina.elementAt(0);
        loteVacinaController.text = informacaoVacina.elementAt(1);
        validadeVacinaController.text = informacaoVacina.elementAt(2);
        quantidadeVacinaController.text = informacaoVacina.elementAt(3);
        labId = int.parse(informacaoVacina.elementAt(4));
        //pegando nome do laboratorio
        dbHelper.getLaboratoriaPorId(labId).then((value) {
          setState(() {
            labVacinaController.text = value;
          });
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextFormField(
            controller: nomeVacinaController,
            enabled: false,
            decoration: InputDecoration(
              labelText: 'Nome:',
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: loteVacinaController,
            enabled: false,
            decoration: InputDecoration(
              labelText: 'Lote:',
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: validadeVacinaController,
            enabled: false,
            decoration: InputDecoration(
              labelText: 'Validade:',
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: quantidadeVacinaController,
            enabled: false,
            decoration: InputDecoration(
              labelText: 'Quantidade:',
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: labVacinaController,
            enabled: false,
            decoration: InputDecoration(
              labelText: 'LabId:',
            ),
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
              print(user.cpf);
              print(pacienteId);
              print(vacinaId);
              if (user.cpf.isNotEmpty) {
                await dbHelper.removeRegistroVacinacaoSendoProfissional(
                    vacinaId, pacienteId);
                Navigator.pop(context);
              } else {
                await dbHelper.removeRegistroVacinacaoSendoPaciente(
                    vacinaId, pacienteId);
                Navigator.pop(context);
              }
            },
            child: const Text('Remover'),
          ),
        ],
      ),
    );
  }
}
