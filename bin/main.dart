import 'package:http/http.dart';

void main() {
  print("Olá, Mundo!");
  requestData();
}

requestData() {
  String url = "https://gist.githubusercontent.com/kurtmatheus/52403cf53a5ce5a94e6b9529d447c3ef/raw/a99d5e2dba57d495f88ee4b3a0a28809a2d312be/gistfile1.txt";
  Future<Response> futureResponse = get(Uri.parse(url));
  print(futureResponse);
  futureResponse.then((Response response) {
      print(response);
      print(response.body);
  });
}