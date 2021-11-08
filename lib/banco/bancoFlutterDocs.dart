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
    await db.close();
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
    await db.close();
    return listaLaboratorios;
  }

  Future<List<String>> getVacina(int vacinaId) async {
    PostgreSQLConnection db = await instance.database;
    var results = await db
        .query('SELECT * FROM VACINA WHERE VACINA_ID =' + vacinaId.toString());
    List<String> listaInformacoesVacina = [];
    for (var row in results) {
      listaInformacoesVacina.add(row[1].toString());
      listaInformacoesVacina.add(row[2].toString());
      listaInformacoesVacina.add(row[3].toString());
      listaInformacoesVacina.add(row[4].toString());
      listaInformacoesVacina.add(row[5].toString());
    }
    await db.close();
    return listaInformacoesVacina;
  }

  Future<List<Map<String, dynamic>>> getVacinaIdNomeDose(int pacienteId) async {
    PostgreSQLConnection db = await instance.database;
    var results = await db.query(
        "SELECT VACINA.VACINA_ID, VACINA.NOME_VACINA, VACINA.LOTE FROM REGISTRO_VACINACAO" +
            " INNER JOIN VACINA ON VACINA.VACINA_ID = REGISTRO_VACINACAO.VACINA_ID" +
            " INNER JOIN PACIENTE ON PACIENTE.PACIENTE_ID = REGISTRO_VACINACAO.PACIENTE_ID" +
            " WHERE PACIENTE.PACIENTE_ID = " +
            pacienteId.toString());
    List<Map<String, dynamic>> listaVacina = [];
    Map<String, dynamic> map;
    for (var row in results) {
      map = {
        "id": row[0].toString(),
        "name": row[1],
        "dose": int.parse(row[2])
      };
      listaVacina.add(Map.from(map));
    }
    await db.close();
    return listaVacina;
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
    await db.close();
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
    await db.close();
    return resultado;
  }

  Future<String> getLaboratoriaPorId(int laboratorioId) async {
    PostgreSQLConnection db = await instance.database;
    var results = await db.query('SELECT NOME FROM LABORATORIO WHERE LAB_ID =' +
        laboratorioId.toString());
    String resultado = "";
    for (var row in results) {
      resultado = row[0].toString();
    }
    await db.close();
    return resultado;
  }

  Future<List<String>> getAllVacinaNome() async {
    PostgreSQLConnection db = await instance.database;
    var results = await db.query('SELECT NOME_VACINA FROM VACINA');
    List<String> resutado = new List<String>();
    for (var row in results) {
      resutado.add(row[0].toString());
    }
    await db.close();
    return resutado;
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
    await db.close();
  }

  Future<void> inserirPaciente(
      String tipoPaciente,
      String condicaoEspecial,
      String senha,
      String nome,
      String email,
      String cpf,
      String dateNasc) async {
    PostgreSQLConnection db = await instance.database;
    await db.query(
        "INSERT INTO PACIENTE (TIPO_PACIENTE,CONDICAO_ESPECIAL,SENHA,NOME,EMAIL,CPF,DATA_NASC) " +
            "VALUES ('" +
            tipoPaciente +
            "','" +
            condicaoEspecial +
            "','" +
            senha +
            "','" +
            nome +
            "','" +
            email +
            "','" +
            cpf +
            "','" +
            dateNasc +
            "')");
    await db.close();
  }

  Future<void> inserirProfissional(
      String Adm,
      String Tipo,
      String Crm,
      String senha,
      String nome,
      String email,
      String cpf,
      String dateNasc) async {
    PostgreSQLConnection db = await instance.database;
    await db.query(
        "INSERT INTO PROFISSIONAL_SAUDE (ADM,TIPO_PROFISSIONAL,CRM,SENHA,NOME,EMAIL,CPF,DATA_NASC) " +
            "VALUES (" +
            Adm +
            ",'" +
            Tipo +
            "','" +
            Crm +
            "','" +
            senha +
            "','" +
            nome +
            "','" +
            email +
            "','" +
            cpf +
            "','" +
            dateNasc +
            "')");
    await db.close();
  }

  Future<void> inserirRegistroVacinacao(
      String local,
      String dataVacinado,
      String dataProxDose,
      String nomeVacina,
      String nomePaciente,
      String profissionalCpf) async {
    PostgreSQLConnection db = await instance.database;
    await db.query(
        "INSERT INTO REGISTRO_VACINACAO ( LOCAL, DATA_VACINADO, DATA_PROX_DOSE, VACINA_ID, PACIENTE_ID, PROFISSIONAL_SAUDE_ID) " +
            "VALUES ('" +
            local +
            "', '" +
            dataVacinado +
            "', '" +
            dataProxDose +
            "', (" +
            "SELECT VACINA_ID FROM VACINA WHERE NOME_VACINA LIKE '" +
            nomeVacina +
            "'" +
            "), (" +
            "SELECT PACIENTE_ID FROM PACIENTE WHERE NOME LIKE '" +
            nomePaciente +
            "'" +
            "), (" +
            "SELECT PROFISSIONAL_SAUDE_ID FROM PROFISSIONAL_SAUDE WHERE CPF LIKE '" +
            profissionalCpf +
            "'" +
            "))");
    await db.close();
  }

  Future<bool> getUsuarioProfissional(String cpf, String senha) async {
    PostgreSQLConnection db = await instance.database;
    var result = await db.query(
        "SELECT NOME FROM PROFISSIONAL_SAUDE WHERE CPF LIKE '" +
            cpf +
            "' AND SENHA LIKE '" +
            senha +
            "'");
    String resultado = "";
    for (var row in result) {
      resultado = row[0].toString();
    }
    await db.close();
    if (resultado.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<bool> getUsuarioPaciente(String cpf, String senha) async {
    PostgreSQLConnection db = await instance.database;
    var result = await db.query("SELECT NOME FROM PACIENTE WHERE CPF LIKE '" +
        cpf +
        "' AND SENHA LIKE '" +
        senha +
        "'");
    await db.close();
    String resultado;
    for (var row in result) {
      resultado = row[0];
    }
    if (resultado.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<bool> getAdm(String cpf) async {
    PostgreSQLConnection db = await instance.database;
    var result = await db.query(
        "SELECT ADM FROM PROFISSIONAL_SAUDE WHERE CPF LIKE '" + cpf + "'");
    String resultado;
    await db.close();
    for (var row in result) {
      resultado = row[0].toString();
    }
    if (resultado.isNotEmpty) {
      if (resultado == "true") {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  Future<int> getIdPaciente(String cpf) async {
    PostgreSQLConnection db = await instance.database;
    var result = await db
        .query("SELECT PACIENTE_ID FROM PACIENTE WHERE CPF LIKE '" + cpf + "'");
    await db.close();
    int resultado;
    for (var row in result) {
      resultado = int.parse(row[0].toString());
    }
    return resultado;
  }

  Future<void> removeRegistroVacinacaoSendoProfissional(
      int vacinaId, int pacienteId) async {
    PostgreSQLConnection db = await instance.database;
    var result = await db.query(
        "DELETE FROM REGISTRO_VACINACAO WHERE VACINA_ID =" +
            vacinaId.toString() +
            " AND PACIENTE_ID =" +
            pacienteId.toString());
    await db.close();
  }

  Future<void> removeRegistroVacinacaoSendoPaciente(
      int vacinaId, int pacienteId) async {
    //DELETE FROM REGISTRO_VACINACAO WHERE VACINA_ID = 1 AND PACIENTE_ID = 1 AND PROFISSIONAL_SAUDE_ID is null;
    PostgreSQLConnection db = await instance.database;
    var result = await db.query(
        "DELETE FROM REGISTRO_VACINACAO WHERE VACINA_ID =" +
            vacinaId.toString() +
            " AND PACIENTE_ID =" +
            pacienteId.toString() +
            " AND PROFISSIONAL_SAUDE_ID IS null");
    await db.close();
  }
}
