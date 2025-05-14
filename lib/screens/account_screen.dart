import 'dart:io';

import 'package:anybank/models/account.dart';
import 'package:anybank/services/account_service.dart';

class AccountScreen {
  final AccountService _service = AccountService();

  void initializeStream() {
    _service.streamInfos.listen((event) {
      print(event);
    });
  }

  void runChatBot() async {
    print("Bom dia! Eu sou o Lewis, assistente do Banco d'Ouro!");
    print("Que bom te ter aqui com a gente.\n");

    bool isRunning = true;
    while (isRunning) {
      print("Como eu posso te ajudar? (digite o número desejado)");
      print("1 - Ver todas sua contas.");
      print("2 - Adicionar nova conta.");
      print("3 - Sair\n");

      String? input = stdin.readLineSync();

      switch (input) {
        case "1":
          {
            await _getAllAccounts();
            break;
          }
        case "2":
          {
            await _addAccount();
            break;
          }
        case "3":
          {
            print("Até a próxima.");
            isRunning = false;
            break;
          }
        default:
          {
            print("Não entendi. Tente novamente.");
            break;
          }
      }
    }
  }

  _getAllAccounts() async {
    List<Account> accounts = await _service.getAll();

    for (Account acc in accounts) {
      print(acc.toString());
      print("-------------");
    }
  }

  _addAccount() async {
    _service.addAccount(
      Account.fromMap({
        "id": "ID012",
        "name": "Harpia",
        "lastName": "Flasvia",
        "balance": 5000.0,
      }),
    );
  }
}
