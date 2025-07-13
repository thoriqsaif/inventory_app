import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_app/data/models/inventory_item.dart';

class InventoryService {
  final _collection = FirebaseFirestore.instance.collection('inventory');

  Stream<List<InventoryItem>> getInventoryItems() {
    return _collection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return InventoryItem.fromMap(doc.id, doc.data());
      }).toList();
    });
  }

  Future<void> addItem(String name, int qty) async {
    await _collection.add(
      InventoryItem(id: '', name: name, quantity: qty).toMap(),
    );
  }

  Future<void> deleteItem(String id) async {
    await _collection.doc(id).delete();
  }
}
