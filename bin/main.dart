import 'dart:convert';

import 'package:http/http.dart';

void main() {
  print("Olá, Mundo!");
  String url =
      "https://gist.githubusercontent.com/kurtmatheus/52403cf53a5ce5a94e6b9529d447c3ef/raw/a99d5e2dba57d495f88ee4b3a0a28809a2d312be/gistfile1.txt";
  // requestData(url);
  // requestDataAsync(url)
  sendDataAsync({
    "id": "NEW001",
    "firstName": "Kurt",
    "lastName": "Flutter",
    "balance": 5000
  }, url);
}

requestData(String url) {
  
  Future<Response> futureResponse = get(Uri.parse(url));
  print(futureResponse);
  futureResponse.then((Response response) {
    print(response);
    // print(response.body);

    List<dynamic> listAccounts = json.decode(response.body);
    Map<String, dynamic> mapCarla = listAccounts.firstWhere((e) => e["name"] == "Carla");
    print(mapCarla["balance"]);
  });
}

Future<List<dynamic>> requestDataAsync(String url) async {
  Response response = await get(Uri.parse(url));
  return json.decode(response.body);
}

sendDataAsync(Map<String, dynamic> mapAccount, String url) async {
  List<dynamic> accounts = await requestDataAsync(url);
  accounts.add(mapAccount);
  String content = json.encode(accounts);
  print(content);
}