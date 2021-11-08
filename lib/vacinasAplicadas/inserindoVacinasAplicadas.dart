import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vacina/banco/bancoFlutterDocs.dart';

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

  //controller
  TextEditingController localVacinaController = new TextEditingController();
  TextEditingController dataVacinadoController = new TextEditingController()
    ..text = DateFormat('yyyy-MM-dd').format(DateTime.now());
  TextEditingController dataProxDoseController = new TextEditingController()
    ..text = DateFormat('yyyy-MM-dd').format(DateTime.now());
  final dataFormat = new DateFormat('yyyy-MM-dd');
  DateTime _dataVacinado;
  DateTime _dataProxDose;

  //comboBox
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentVac;

  //listas
  List<String> _listVac;

  final dbHelper = DatabaseHelper.instance;

  @override
  initState() {
    dbHelper.getAllVacinaNome().then((value) {
      setState(() {
        _listVac = value;
        _dropDownMenuItems = getDropDownMenuItems(_listVac);
        _currentVac = _dropDownMenuItems[0].value;
      });
    });
    super.initState();
  }

  final String namePaciente;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            controller: localVacinaController,
            decoration: InputDecoration(
                labelText: 'Local',
                suffixIcon: Icon(Icons.supervised_user_circle)),
          ),
          TextField(
            controller: dataVacinadoController,
            decoration: InputDecoration(
              labelText: 'Data dia Vacinado',
              suffixIcon: Icon(Icons.supervised_user_circle),
            ),
            onTap: () {
              showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2001),
                      lastDate: DateTime(2030))
                  .then((value) {
                _dataVacinado = value;
                dataVacinadoController..text = dataFormat.format(_dataVacinado);
              });
            },
          ),
          TextField(
            controller: dataProxDoseController,
            decoration: InputDecoration(
              labelText: 'Data Próxima dose',
              suffixIcon: Icon(Icons.supervised_user_circle),
            ),
            onTap: () {
              showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2001),
                      lastDate: DateTime(2030))
                  .then((value) {
                _dataProxDose = value;
                dataProxDoseController..text = dataFormat.format(_dataProxDose);
              });
            },
          ),
          DropdownButton(
            value: _currentVac,
            items: _dropDownMenuItems,
            onChanged: (value) {
              setState(() {
                _currentVac = value;
              });
            },
          ),
          ElevatedButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue,
              primary: Colors.black,
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {
              dbHelper.inserirRegistroVacinacao(
                  localVacinaController.text,
                  dataVacinadoController.text,
                  dataProxDoseController.text,
                  _currentVac.toString(),
                  namePaciente,
                  user.cpf);
            },
            child: const Text('Cadastrar Profissional da Saúde'),
          )
        ],
      ),
    );
  }
}

List<DropdownMenuItem<String>> getDropDownMenuItems(List<String> listVac) {
  List<DropdownMenuItem<String>> items = new List();
  for (String item in listVac) {
    items.add(new DropdownMenuItem(value: item, child: new Text(item)));
  }
  return items;
}
