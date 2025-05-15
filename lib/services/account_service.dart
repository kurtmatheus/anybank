import 'dart:async';
import 'dart:convert';

import 'package:anybank/api_key.dart';
import 'package:anybank/models/account.dart';
import 'package:http/http.dart';

class AccountService {
  final StreamController<String> _stmController = StreamController<String>();
  Stream<String> get streamInfos => _stmController.stream;
  String url = "https://api.github.com.br/gists/52403cf53a5ce5a94e6b9529d447c3ef";

  Future<List<Account>> getAll() async {
    Response response = await get(Uri.parse(url));
    _stmController.add("${DateTime.now()}: Realizou GET.");

    Map<String, dynamic> mapResponse = json.decode(response.body);
    List<dynamic> listDyn = json.decode(
      mapResponse["files"]["accounts.json"]["content"],
    );

    List<Account> listAcc = listDyn.map((dyn) => Account.fromMap(dyn as Map<String, dynamic>)).toList();

    return listAcc;
  }

  addAccount(Account account) async {
    List<Account> accounts = await getAll();

    accounts.add(account);

    String content = json.encode(accounts.map((acc) => acc.toMap()).toList());

    Response response = await post(
      Uri.parse(url),
      headers: {
        "Authorization": "Bearer $githubApiKey",
        "Accept": "application/vnd.github+json",
        "X-GitHub-Api-Version": "2022-11-28",
      },
      body: json.encode({
        "description": "accounts.json",
        "public": true,
        "files": {
          "accounts.json": {"content": content},
        },
      }),
    );

    if (response.statusCode.toString()[0] == "2") {
      _stmController.add("${DateTime.now()}: Requisição POST bem sucedido para Conta de ${account.name}.");
    } else {
      _stmController.add("${DateTime.now()}: Requisição POST falhou para Conta de ${account.name}.");
    }
  }
}
