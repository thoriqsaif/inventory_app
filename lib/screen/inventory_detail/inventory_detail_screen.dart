import 'package:flutter/material.dart';
import 'package:inventory_app/data/models/inventory_item.dart';

class DetailInventoryPage extends StatelessWidget {
  final InventoryItem item;
  const DetailInventoryPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Inventory')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Item Name:', style: Theme.of(context).textTheme.labelLarge),
            Text(item.name, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            Text('Quantity:', style: Theme.of(context).textTheme.labelLarge),
            Text(
              item.quantity.toString(),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
      ),
    );
  }
}
