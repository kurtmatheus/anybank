class Transaction {
  String id;
  String senderAccountId;
  String receiverAccountId;
  DateTime date;
  double amount;
  double taxes;

  Transaction({
    required this.id,
    required this.senderAccountId,
    required this.receiverAccountId,
    required this.date,
    required this.amount,
    required this.taxes,
  });

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map["id"] as String,
      senderAccountId: map["senderAccountId"] as String,
      receiverAccountId: map["receiverAccountId"] as String,
      date: map["date"] as DateTime,
      amount: map["amount"] as double,
      taxes: map["taxes"] as double,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "senderAccountId": senderAccountId,
      "receiverAccountId": receiverAccountId,
      "date": date,
      "amount": amount,
      "taxes": taxes,
    };
  }
}
