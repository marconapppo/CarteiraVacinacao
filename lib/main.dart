import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:vacina/menu.dart';

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
          title: const Text('Home'),
        ),
        body: Menu(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
