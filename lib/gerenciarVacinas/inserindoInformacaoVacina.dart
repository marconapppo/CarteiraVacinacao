import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vacina/banco/bancoFlutterDocs.dart';
import 'package:vacina/models/models.dart';

class InserindoInformacaoVacina extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inserindo Paciente"),
      ),
      body: InserindoInformacaoVacinaMenu(),
    );
  }
}

class InserindoInformacaoVacinaMenu extends StatefulWidget {
  @override
  _InserindoInformacaoVacinaMenu createState() =>
      _InserindoInformacaoVacinaMenu();
}

// ignore: must_be_immutable
class _InserindoInformacaoVacinaMenu
    extends State<InserindoInformacaoVacinaMenu> {
  final dbHelper = DatabaseHelper.instance;
  TextEditingController loteVacinaController = new TextEditingController();
  TextEditingController quantidadeVacinaController =
      new TextEditingController();
  DateTime _dateTime;
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentLab;
  List<Laboratorio> _listLab;
  final dataFormat = new DateFormat('yyyy-MM-dd');

  @override
  initState() {
    dbHelper.allLaboratorios().then((value) {
      setState(() {
        _listLab = value;
        _dropDownMenuItems = getDropDownMenuItems(_listLab);
        _currentLab = _dropDownMenuItems[0].value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              //lote
              TextField(
                controller: loteVacinaController,
                decoration: InputDecoration(
                    labelText: 'Lote',
                    suffixIcon: Icon(Icons.supervised_user_circle)),
              ),
              SizedBox(
                height: 20,
              ),
              //quantidade
              TextField(
                controller: quantidadeVacinaController,
                decoration: InputDecoration(
                    labelText: 'Quantidade',
                    suffixIcon: Icon(Icons.supervised_user_circle)),
              ),
              SizedBox(
                height: 20,
              ),
              //validade
              ElevatedButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  primary: Colors.black,
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2001),
                          lastDate: DateTime(2030))
                      .then((value) {
                    _dateTime = value;
                  });
                },
                child: const Text('Pegar Data Validade'),
              ),
              SizedBox(
                height: 20,
              ),
              //comboBox
              DropdownButton(
                value: _currentLab,
                items: _dropDownMenuItems,
                onChanged: (value) {
                  setState(() {
                    _currentLab = value;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              //inserindo no banco.
              ElevatedButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  primary: Colors.black,
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  Vacina vac = new Vacina(
                      0,
                      int.parse(loteVacinaController.value.text),
                      dataFormat.format(_dateTime),
                      int.parse(quantidadeVacinaController.value.text),
                      _currentLab.toString());
                  dbHelper.inserirVacina(vac);
                },
                child: const Text('Inserir Vacina'),
              )
            ],
          )),
    );
  }
}

List<DropdownMenuItem<String>> getDropDownMenuItems(List<Laboratorio> listLab) {
  List<DropdownMenuItem<String>> items = new List();
  for (var lab in listLab) {
    items.add(new DropdownMenuItem(
        value: lab.nome.toString(), child: new Text(lab.nome.toString())));
  }
  return items;
}
