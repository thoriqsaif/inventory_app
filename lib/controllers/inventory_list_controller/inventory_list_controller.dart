import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:inventory_app/data/db/db/data_inventory.dart';
import 'package:inventory_app/data/db/firestore/firestore_service.dart';

class InventoryListController extends GetxController {
  final FirestoreService dbService;

  InventoryListController(this.dbService);

  final RxBool _isInventory = false.obs;

  get isInventory => _isInventory.value;

  findingInventoryList(int inventoryId) async {
    final inventoryList = await dbService.isInventory(inventoryId);
    if (inventoryList) {
      _isInventory.value = true;
    } else {
      _isInventory.value = false;
    }
  }

  setInventoryStatus(bool status) {
    _isInventory.value = status;
  }

  Future<void> addInventory(
    DataInventory inventoryId,
    dynamic secondArg,
  ) async {
    await dbService.addInventory(inventoryId, secondArg);
    _isInventory.value = true;

    await getAllInventoryList();
  }

  Future<void> removeInventory(int inventoryId, [dynamic secondArg]) async {
    await dbService.removeInventory(inventoryId, secondArg);
    _isInventory.value = false;
    await getAllInventoryList();
  }

  final Rx<List<DataInventory>> _inventoryList = Rx<List<DataInventory>>([]);

  get inventoryList => _inventoryList.value;

  getAllInventoryList() async {
    _inventoryList.value = await dbService.getAllInventory();
  }

  Stream<QuerySnapshot> streamAllInventoryList() {
    final snapshots = dbService.getAllInventoryRealtime();
    return snapshots;
  }
}
