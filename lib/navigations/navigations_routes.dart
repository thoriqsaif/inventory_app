import 'package:flutter/material.dart';
import 'package:inventory_app/data/models/inventory_item.dart';
import 'package:inventory_app/screen/home/inventory_list_screen.dart';
import 'package:inventory_app/screen/inventory_detail/inventory_detail_screen.dart';
import 'package:inventory_app/screen/register_screen/register_screen.dart';
import 'package:inventory_app/screen/signin_screen/signin_screen.dart';

class NavigationsRoutes {
  static const String signin = '/signin';
  static const String register = '/register';
  static const String inventory = '/inventory';
  static const String addInventory = '/add';
  static const String detailInventory = '/detail';

  static Map<String, WidgetBuilder> get map => {
    signin: (_) => const SignInScreen(),
    register: (_) => const RegisterScreen(),
    inventory: (_) => const InventoryPage(),
    // addInventory: (_) => const  AddInventoryPage(Set<dynamic>(), inventoryId: 0),
    NavigationsRoutes.detailInventory: (context) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is InventoryItem) {
        return DetailInventoryPage(item: args);
      } else {
        return const Scaffold(
          body: Center(child: Text('Invalid or missing inventory data')),
        );
      }
    },
  };
}
