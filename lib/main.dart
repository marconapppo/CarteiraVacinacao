import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:vacina/menu.dart';

import 'loginMenu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Carteira de vacinação'),
        ),
        body: CarteiraLoginMenu(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainMenuProfissional extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Carteira do Profissional de Saúde"),
      ),
      body: Menu(),
    );
  }
}
