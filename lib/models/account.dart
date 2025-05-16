import 'dart:convert';

class Account {
  String id;
  String name;
  String lastName;
  double balance;
  String? type;

  Account({
    required this.id,
    required this.name,
    required this.lastName,
    required this.balance,
    this.type
  });

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      id: map["id"] as String,
      name: map["name"] as String,
      lastName: map["lastName"] as String,
      balance: map["balance"] as double,
      type: (map["type"] != null) ? map["type"] as String : null
    );
  }

  Map<String, dynamic> toMap() {
    return {"id": id, "name": name, "lastName": lastName, "balance": balance, "type": type};
  }

  Account copyWith({
    String? id,
    String? name,
    String? lastName,
    double? balance,
    String? type
  }) {
    return Account(
      id: id ?? this.id,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      balance: balance ?? this.balance,
      type: type
    );
  }

  String toJson() => json.encode(toMap());

  factory Account.fromJson(String source) =>
      Account.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant Account other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.lastName == lastName &&
        other.balance == balance &&
        other.type == type;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ lastName.hashCode ^ balance.hashCode;
  }

  @override
  String toString() {
    return "Conta de Nº: $id\nNome: $name $lastName\nSaldo: $balance\n--------------------";
  }
}
