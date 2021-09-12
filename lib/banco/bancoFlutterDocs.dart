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

  void allQuery() async {
    PostgreSQLConnection db = await instance.database;
    print("Entrando em allQuery");
    var results = await db.query('SELECT NOME FROM PACIENTE');
    print("resultados:" + results.toString());
    print("resultados:" + results[0].toString());
  }
}
