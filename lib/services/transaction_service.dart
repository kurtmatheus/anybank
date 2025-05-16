import 'dart:async';
import 'dart:convert';

import 'package:anybank/api_key.dart';
import 'package:anybank/helpers/helper_taxes.dart';
import 'package:anybank/models/account.dart';
import 'package:anybank/models/transaction.dart';
import 'package:anybank/services/account_service.dart';
import 'package:http/http.dart';

class TransactionService {
  AccountService accountService = AccountService();
  final StreamController<String> _stmController = StreamController<String>();
  Stream<String> get streamInfos => _stmController.stream;
  String url = "https://api.github.com/gists/52403cf53a5ce5a94e6b9529d447c3ef";

  makeTransaction({
    required String idSender,
    required String idReceiver,
    required double amount,
  }) async {
    List<Account> accounts = await accountService.getAll();

    Account accountSender = accounts.firstWhere((e) => e.id == idSender);

    Account accountReceiver = accounts.firstWhere((e) => e.id == idReceiver);

    double taxValue = 0.0;

    if (accountSender.type != null) {
      taxValue = calculateTransactionTaxes(accountSender.type!, amount);
    }

    double transactionAmount = amount + taxValue;

    if (hasBalance(accountSender, transactionAmount)) {
      // addTransaction(
      //   Transaction(
      //     id: "ID001",
      //     senderAccountId: idSender,
      //     receiverAccountId: idReceiver,
      //     date: DateTime.now(),
      //     amount: transactionAmount,
      //     taxes: taxValue,
      //   ),
      // );

    Account senderUpdate = accountSender.copyWith(balance: (accountSender.balance - transactionAmount));
    Account receiverUpdate = accountReceiver.copyWith(balance: (accountReceiver.balance + amount));

    print(senderUpdate);
    print(receiverUpdate);

    accounts = accountService.update(accounts, accountSender, senderUpdate);
    accounts = accountService.update(accounts, accountReceiver, receiverUpdate);

    await accountService.save(accounts);

    } else {
      print("Saldo do Remetente Insuficiente.");
    }
  }

  bool hasBalance(Account sender, double amount) {
    return sender.balance >= amount;
  }

  Future<List<Transaction>> getAll() async {
    Response response = await get(Uri.parse(url));
    _stmController.add("${DateTime.now()}: Realizou GET.");

    Map<String, dynamic> mapResponse = json.decode(response.body);
    List<dynamic> listDyn = json.decode(
      mapResponse["files"]["transactions.json"]["content"],
    );

    List<Transaction> listAcc =
        listDyn
            .map((dyn) => Transaction.fromMap(dyn as Map<String, dynamic>))
            .toList();

    return listAcc;
  }

  addTransaction(Transaction transaction) async {
    List<Transaction> transactions = await getAll();

    transactions.add(transaction);

    await saveTransaction(transactions, transaction);
  }

  saveTransaction(
    List<Transaction> transactions,
    Transaction transaction,
  ) async {
    String content = json.encode(
      transactions.map((acc) => acc.toMap()).toList(),
    );

    Response response = await post(
      Uri.parse(url),
      headers: {
        "Authorization": "Bearer $githubApiKey",
        "Accept": "application/vnd.github+json",
        "X-GitHub-Api-Version": "2022-11-28",
      },
      body: json.encode({
        "description": "transactions.json",
        "public": true,
        "files": {
          "transactions.json": {"content": content},
        },
      }),
    );

    if (response.statusCode.toString()[0] == "2") {
      _stmController.add(
        "${DateTime.now()}: Requisição POST bem sucedido para Transaction.",
      );
    } else {
      _stmController.add("${DateTime.now()}: Requisição POST falhou.");
    }
  }
}
