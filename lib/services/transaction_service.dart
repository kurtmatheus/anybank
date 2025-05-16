import 'package:anybank/helpers/helper_taxes.dart';
import 'package:anybank/models/account.dart';
import 'package:anybank/services/account_service.dart';

class TransactionService {
  AccountService accountService = AccountService();

  makeTransaction({
    required String idSender,
    required String idReceiver,
    required double amount,
  }) async {
    List<Account> accounts = await accountService.getAll();

    Account accountSender = accounts.firstWhere((e) => e.id == idSender);

    Account accountReceiver = accounts.firstWhere((e) => e.id == idReceiver);

    double valorTransacao = 0.0;

    if(accountSender.type != null) {
      valorTransacao = calcularTaxa(accountSender.type!, amount);
    } else {
      valorTransacao = amount * 0.01;
    }

    print(accountSender.copyWith(balance: (accountSender.balance - valorTransacao)));
    print(accountReceiver.copyWith(balance: (accountReceiver.balance - valorTransacao)));
  }
}
