double calculateTransactionTaxes(String accountType, double amount) {
  switch (accountType.toUpperCase()) {
    case "AMBROSIA":
      return amount * (0.5 / 100);
    case "CANJICA":
      return amount * (0.33 / 100);
    case "PUDIM":
      return amount * (0.25 / 100);
    default:
      return amount * (0.1 / 100);
  }
}
