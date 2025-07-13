import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_app/data/db/db/data_inventory.dart';

class FirestoreService {
  final inventoryRef = FirebaseFirestore.instance
      .collection('inventory')
      .withConverter<DataInventory>(
        fromFirestore: (snapshot, _) =>
            DataInventory.fromJson(snapshot.data()!),
        toFirestore: (inventory, _) => inventory.toJson(),
      );

  Future addInventory(DataInventory inventory, int quantity) async {
    await inventoryRef.doc(inventory.id.toString()).set(inventory);
  }

  Future removeInventory(int inventoryId, String id) async {
    await inventoryRef.doc(inventoryId.toString()).delete();
  }

  Future<bool> isInventory(int inventoryId) async {
    final result = await inventoryRef.doc(inventoryId.toString()).get();
    return result.exists;
  }

  Future<List<DataInventory>> getAllInventory() async {
    final dataSnapshot = await inventoryRef.get();
    return dataSnapshot.docs.map((doc) => doc.data()).toList();
  }

  Stream<QuerySnapshot> getAllInventoryRealtime() {
    return inventoryRef.snapshots();
  }
}
