import 'package:hive/hive.dart';

// part 'data_inventory.g.dart';

@HiveType(typeId: 1)
class DataInventory {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int quantity;

  @HiveField(3)
  final int price;

  DataInventory({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
  });

  factory DataInventory.fromJson(Map<String, dynamic> json) => DataInventory(
    id: json['id'],
    name: json['name'],
    quantity: json['quantity'],
    price: json['price'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'quantity': quantity,
    'price': price,
  };
}
