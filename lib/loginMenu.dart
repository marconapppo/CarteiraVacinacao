import 'package:flutter/material.dart';
import 'package:vacina/cadastro.dart';

import 'login.dart';

class CarteiraLoginMenu extends StatelessWidget {
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
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login()));
            },
            child: const Text('Login'),
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
                  context, MaterialPageRoute(builder: (context) => Cadastro()));
            },
            child: const Text('Cadastrar'),
          ),
        ],
      ),
    );
  }
}
