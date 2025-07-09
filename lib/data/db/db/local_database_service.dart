import 'package:hive/hive.dart';
import 'package:inventory_app/data/db/db/data_inventory.dart';

class LocalDatabaseService {
  final Box<DataInventory> box;

  LocalDatabaseService({required this.box});

  Future<void> addInventory(DataInventory dataInventory) async {
    await box.add(dataInventory);
  }

  Future<void> removeInventory(int index) async {
    await box.deleteAt(index);
  }

  Future<bool> isInventory(int index) async {
    return box.containsKey(index);
  }

  Future<List<DataInventory>> getAllInventory() async {
    return box.values.toList();
  }
}
