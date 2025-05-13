import 'dart:async';
import 'dart:convert';

import 'package:anybank/api_key.dart';
import 'package:http/http.dart';

StreamController<String> stmController = StreamController<String>();

void main() {
  StreamSubscription stmSubscription = stmController.stream.listen((
    String info,
  ) {
    print(info);
  });
  // print("Olá, Mundo!");

  String url =
      "https://gist.githubusercontent.com/kurtmatheus/52403cf53a5ce5a94e6b9529d447c3ef/raw/a99d5e2dba57d495f88ee4b3a0a28809a2d312be/gistfile1.txt";

  requestData(url);
  requestDataAsync(url);

  String urlPost =
      "https://api.github.com/gist/52403cf53a5ce5a94e6b9529d447c3ef";

  sendDataAsync({
    "id": "NEW001",
    "firstName": "Kurt",
    "lastName": "Flutter",
    "balance": 5000,
  }, urlPost);
}

requestData(String url) {
  Future<Response> futureResponse = get(Uri.parse(url));
  futureResponse.then((Response response) {
    stmController.add("${DateTime.now()}: Realizou GET usando THEN.");
  });
}

Future<List<dynamic>> requestDataAsync(String url) async {
  Response response = await get(Uri.parse(url));
  stmController.add("${DateTime.now()}: Realizou GET.");
  return json.decode(response.body);
}

sendDataAsync(Map<String, dynamic> mapAccount, String url) async {
  List<dynamic> accounts = await requestDataAsync(url);
  accounts.add(mapAccount);
  String content = json.encode(accounts);

  Response response = await post(
    Uri.parse(url),
    headers: {
      "Authorization": "Bearer $githubApiKey",
      "Accept": "application/vnd.github+json",
      "X-GitHub-Api-Version": "2022-11-28",
    },
    body: json.encode({
      "description": "account.json",
      "public": true,
      "files": {
        "accounst.json": {"content": content},
      },
    }),
  );

  if (response.statusCode.toString()[0] == "2") {
    stmController.add("${DateTime.now()}: Requisição POST bem sucedido.");
  } else {
    stmController.add("${DateTime.now()}: Requisição POST falhou.");
  }
}
