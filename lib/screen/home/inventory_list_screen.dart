import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:inventory_app/controllers/inventory_list_controller/inventory_list_controller.dart';
import 'package:inventory_app/data/db/firestore/firestore_service.dart';
import 'package:inventory_app/navigations/navigations_routes.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryListState();
}

class _InventoryListState extends State<InventoryPage> {
  InventoryListController inventoryListController = Get.put(
    InventoryListController(Get.put(FirestoreService())),
  );

  @override
  void initState() {
    Future.microtask(() {
      inventoryListController.getAllInventoryList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class StreamInventoryList extends StatefulWidget {
  final Stream<QuerySnapshot> snapshots;
  const StreamInventoryList({super.key, required this.snapshots});

  @override
  State<StreamInventoryList> createState() => _StreamInventoryListState();
}

class _StreamInventoryListState extends State<StreamInventoryList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inventory List')),
      body: StreamBuilder<QuerySnapshot>(
        stream: widget.snapshots,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final item = snapshot.data!.docs;
          if (item.isEmpty) return const Center(child: Text('No data'));

          return ListView.builder(
            itemCount: item.length,
            itemBuilder: (context, index) {
              final data = item[index];
              return ListTile(
                title: Text(data['name']),
                subtitle: Text('Qty: ${data['quantity']}'),
                trailing: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => Navigator.pushNamed(
                    context,
                    NavigationsRoutes.detailInventory,
                    arguments: item,
                  ),
                ),
              );
            },
          );
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () =>
      //       Navigator.pushNamed(context, NavigationsRoutes.addInventory),
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
