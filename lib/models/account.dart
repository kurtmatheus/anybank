import 'dart:convert';

class Account {
  String id;
  String name;
  String lastName;
  double balance;

  Account({
    required this.id,
    required this.name,
    required this.lastName,
    required this.balance,
  });

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      id: map["id"],
      name: map["name"],
      lastName: map["lastName"],
      balance: map["balance"],
    );
  }

  Map<String, dynamic> toMap() {
    return {"id": id, "name": name, "lastName": lastName, "balance": balance};
  }

  Account copyWith({
    String? id,
    String? name,
    String? lastName,
    double? balance,
  }) {
    return Account(
      id: id ?? this.id,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      balance: balance ?? this.balance,
    );
  }

  String toJson() => json.encode(toMap());

  factory Account.fromJson(String source) =>
      Account.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant Account other) {
    if(identical(this, other)) return true;

    return other.id == id &&
    other.name == name &&
    other.lastName == lastName &&
    other.balance == balance;
  }
}
