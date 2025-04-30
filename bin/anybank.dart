void main(List<String> arguments) {
  String email = "krt@gmail.com";
  double saldo = 1000.0;
  bool ativo = true;

  receberParametros(email: email, saldo: saldo, ativo: ativo);
}

void receberParametros({required String email, required double saldo, required bool ativo}) {
  if (ativo) {
    print("Email: $email\nSaldo: $saldo");
  }

  Usuario("kurt", email: "email", senha: "wsdfwseg", cpf: null, ativo: false);
}

class Usuario {
  String nome;
  String email;
  String senha;
  String? cpf;
  bool? ativo;

  Usuario(this.nome, {required this.email, required this.senha, this.cpf, this.ativo});
}