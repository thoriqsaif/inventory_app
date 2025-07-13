class InventoryItem {
  final String id;
  final String name;
  final int quantity;

  InventoryItem({required this.id, required this.name, required this.quantity});

  factory InventoryItem.fromMap(String id, Map<String, dynamic> data) {
    return InventoryItem(
      id: id,
      name: data['name'] ?? '',
      quantity: data['quantity'] ?? 0,
    );
  }
  Map<String, dynamic> toMap() {
    return {'name': name, 'quantity': quantity};
  }
}
