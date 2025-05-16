import 'package:anybank/screens/account_screen.dart';
import 'package:anybank/services/transaction_service.dart';

void main() {
  TransactionService transactionService = TransactionService();
  transactionService.makeTransaction(
    idSender: "ID001",
    idReceiver: "ID002",
    amount: 63,
  );

  // AccountScreen accountScreen = AccountScreen();

  // accountScreen.initializeStream();
  // accountScreen.runChatBot();
}
