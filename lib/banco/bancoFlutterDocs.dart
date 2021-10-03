import 'dart:async';

import 'package:postgres/postgres.dart';
import 'package:vacina/models/models.dart';
import 'package:intl/intl.dart';

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

  // ignore: missing_return
  Future<List<Map<String, String>>> allPaciente() async {
    PostgreSQLConnection db = await instance.database;
    var results = await db.query(
        'SELECT PACIENTE.paciente_id,PACIENTE.NOME,PACIENTE.EMAIL FROM PACIENTE ');

    //transformando em lista
    List<Map<String, String>> listaPacientes = [];
    Map<String, String> map;
    for (var row in results) {
      map = {"id": row[0].toString(), "name": row[1], "email": row[2]};
      listaPacientes.add(Map.from(map));
    }
    return listaPacientes;
  }

  Future<List<Laboratorio>> allLaboratorios() async {
    PostgreSQLConnection db = await instance.database;
    var results = await db.query('SELECT * FROM LABORATORIO');

    //transformando em lista
    List<Laboratorio> listaLaboratorios = [];
    for (var row in results) {
      listaLaboratorios.add(new Laboratorio(row[0], row[1].toString()));
    }
    return listaLaboratorios;
  }

  Future<Paciente> getPaciente(int pacienteId) async {
    PostgreSQLConnection db = await instance.database;
    var results = await db.query(
        'SELECT PACIENTE.NOME, PACIENTE.CONDICAO_ESPECIAL, PACIENTE.DATA_NASC FROM PACIENTE ' +
            'WHERE PACIENTE.PACIENTE_ID = ' +
            pacienteId.toString());
    //vai ter só uma linha, somente pra conversão msm
    Paciente paciente;
    final data = new DateFormat('yyyy-MM-dd');
    for (var row in results) {
      paciente = new Paciente(
          row[0], row[1], data.format(DateTime.parse(row[2].toString())));
    }
    return paciente;
  }

  Future<int> getLaboratorio(String laboratorioNome) async {
    PostgreSQLConnection db = await instance.database;
    var results = await db.query(
        'SELECT LABORATORIO.LAB_ID FROM LABORATORIO WHERE LABORATORIO.NOME LIKE ' +
            laboratorioNome);
    //vai ter só uma linha, somente pra conversão msm
    int resultado = 0;
    for (var row in results) {
      resultado = int.parse(row[0]);
    }
    return resultado;
  }

  Future<void> inserirVacina(Vacina vacina) async {
    PostgreSQLConnection db = await instance.database;
    await db.query(
        "INSERT INTO VACINA (NOME_VACINA,LOTE, VALIDADE, QUANTIDADE, LAB_ID)" +
            "VALUES ('" +
            vacina.nome.toString() +
            "', '" +
            vacina.lote.toString() +
            "','" +
            vacina.validade.toString() +
            "','" +
            vacina.quantidade.toString() +
            "'," +
            "(SELECT LABORATORIO.LAB_ID FROM LABORATORIO WHERE LABORATORIO.NOME LIKE '" +
            vacina.nomeLab.toString() +
            "')" +
            ")");
  }

  Future<void> inserirPaciente(String tipoPaciente, String condicaoEspecial,
      String nome, String email, String cpf, String dateNasc) async {
    print("object");
    PostgreSQLConnection db = await instance.database;
    await db.query(
        "INSERT INTO PACIENTE (TIPO_PACIENTE,CONDICAO_ESPECIAL,NOME,EMAIL,CPF,DATA_NASC) " +
            "VALUES ('" +
            tipoPaciente +
            "','" +
            condicaoEspecial +
            "','" +
            nome +
            "','" +
            email +
            "','" +
            cpf +
            "','" +
            dateNasc +
            "')");
    print("object2");
  }
}