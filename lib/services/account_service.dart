import 'dart:async';
import 'dart:convert';

// import 'package:anybank/api_key.dart';
import 'package:anybank/models/account.dart';
import 'package:http/http.dart';

class AccountService {
  StreamController<String> _stmController = StreamController<String>();
  Stream<String> get streamInfos => _stmController.stream;
  String url = "https://api.github.com/gist/52403cf53a5ce5a94e6b9529d447c3ef";

  Future<List<Account>> getAll() async {
    Response response = await get(Uri.parse(url));
    _stmController.add("${DateTime.now()}: Realizou GET.");

    Map<String, dynamic> mapResponse = json.decode(response.body);
    print(mapResponse);
    List<dynamic> listDyn = json.decode(
      mapResponse["files"]["README.jmd"]["content"],
    );

    List<Account> listAcc = listDyn.map(
        (dyn) => Account.fromMap(dyn as Map<String, dynamic>)
        ) as List<Account>;

    return listAcc;
  }

  addAccount(Map<String, dynamic> mapAccount) async {
    List<dynamic> accounts = await getAll();
    accounts.add(mapAccount);
    String content = json.encode(accounts);

    Response response = await post(
      Uri.parse(url),
      headers: {
        "Authorization": "Bearer githubApiKey",
        "Accept": "application/vnd.github+json",
        "X-GitHub-Api-Version": "2022-11-28",
      },
      body: json.encode({
        "description": "account.json",
        "public": true,
        "files": {
          "accounts.json": {"content": content},
        },
      }),
    );

    if (response.statusCode.toString()[0] == "2") {
      _stmController.add("${DateTime.now()}: Requisição POST bem sucedido.");
    } else {
      _stmController.add("${DateTime.now()}: Requisição POST falhou.");
    }
  }
}
