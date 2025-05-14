import 'package:anybank/services/account_service.dart';

void main() {
  AccountService service = AccountService();

  print(service.getAll());
  // sendDataAsync({
  //   "id": "NEW001",
  //   "firstName": "Kurt",
  //   "lastName": "Flutter",
  //   "balance": 5000,
  // }, urlPost);

}
