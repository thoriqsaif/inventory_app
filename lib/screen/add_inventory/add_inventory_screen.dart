import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:inventory_app/data/db/db/data_inventory.dart';
import 'package:inventory_app/data/db/firestore/firestore_service.dart';

class AddInventoryPage extends StatefulWidget {
  final int inventoryId;
  const AddInventoryPage({super.key, required this.inventoryId});

  @override
  State<AddInventoryPage> createState() => _AddInventoryPageState();
}

class _AddInventoryPageState extends State<AddInventoryPage> {
  final _nameCtrl = TextEditingController();
  final _quantityCtrl = TextEditingController();
  // final _priceCtrl = TextEditingController();
  bool _loading = false;

  Future<void> _submit() async {
    setState(() => _loading = true);
    try {
      final name = _nameCtrl.text.trim();
      final quantity = int.tryParse(_quantityCtrl.text.trim()) ?? 0;
      if (name.isEmpty || quantity > 0) {
        await FirestoreService().addInventory(name as DataInventory, quantity);
        if (mounted) Navigator.pop(context);
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Inventory')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameCtrl,
              decoration: InputDecoration(labelText: 'Item Name'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _quantityCtrl,
              decoration: InputDecoration(labelText: 'Quantity'.tr),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loading ? null : _submit,
              child: _loading
                  ? const CircularProgressIndicator()
                  : const Text('Add Item'),
            ),
          ],
        ),
      ),
    );
  }
}
