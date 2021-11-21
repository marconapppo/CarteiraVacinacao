import 'package:flutter/material.dart';

import 'login.dart';

class CarteiraLoginMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 204, 235, 253),
      body: Column(
        //grupo de botoes
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        //mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/logo.png',
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                onPrimary: Colors.black,
                textStyle: const TextStyle(fontSize: 20),
                //padding: EdgeInsets.all(10.0),
                alignment: Alignment.center,
              ),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
              child: const Text('Login'),
            ),
          ),
        ],
      ),
    );
  }
}
