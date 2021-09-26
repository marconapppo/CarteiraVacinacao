class Vacinas {
  final String nome;
  final String dose;

  Vacinas(this.nome, this.dose);
}

class Paciente {
  final String name;
  final String condicaoEspecial;
  final String dataNasc;

  Paciente(this.name, this.condicaoEspecial, this.dataNasc);
}

class Laboratorio {
  final int idLab;
  final String nome;

  Laboratorio(this.idLab, this.nome);
}

class Vacina {
  final int idVac;
  final int lote;
  final String validade;
  final int quantidade;
  final String nomeLab;

  Vacina(this.idVac, this.lote, this.validade, this.quantidade, this.nomeLab);
}
