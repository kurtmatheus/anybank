import 'package:anybank/screens/account_screen.dart';

void main() {
  AccountScreen accountScreen = AccountScreen();

  accountScreen.initializeStream();
  accountScreen.runChatBot();
}
