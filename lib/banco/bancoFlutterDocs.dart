import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:postgres/postgres.dart';

class DatabaseHelper {
  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  //instanciando o objeto para ele realizar a conexão com o banco
  static PostgreSQLConnection _database;
  Future<PostgreSQLConnection> get database async {
    _database = await initDatabase();
    return _database;
  }

  // Realizando a conexao com o banco
  // 10.0.2.2 = é o localhost para android
  Future<PostgreSQLConnection> initDatabase() async {
    var conn = PostgreSQLConnection('10.0.2.2', 5432, 'vacinadb',
        username: 'postgres', password: 'Bakate');
    await conn.open();
    return conn;
  }

  Future<List<Map<String, dynamic>>> allPaciente() async {
    PostgreSQLConnection db = await instance.database;
    var results = await db.query('SELECT * FROM PACIENTE');

    //transformando em lista
    List<Map<String, dynamic>> listaPacientes = [];
    Map<String, dynamic> map;
    for (var row in results) {
      map = {"id": row[0], "name": row[1], "age": row[2]};
      listaPacientes.add(Map.from(map));
    }

    return listaPacientes;
  }
}
