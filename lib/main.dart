import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:inventory_app/data/models/inventory_item.dart';
import 'package:inventory_app/firebase_options.dart';
import 'package:inventory_app/navigations/navigations_routes.dart';
import 'package:inventory_app/screen/add_inventory/add_inventory_screen.dart';
import 'package:inventory_app/screen/home/inventory_list_screen.dart';
import 'package:inventory_app/screen/inventory_detail/inventory_detail_screen.dart';
import 'package:inventory_app/screen/register_screen/register_screen.dart';
import 'package:inventory_app/screen/signin_screen/signin_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  FirebaseFirestore.instance.settings = Settings(persistenceEnabled: true);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Best Inventory Apps',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: NavigationRoutes.detailInventory.name,
      routes: {
        NavigationRoutes.signin.name: (context) => SignInScreen(),
        NavigationRoutes.register.name: (context) => RegisterScreen(),
        NavigationRoutes.inventoryPage.name: (context) => InventoryPage(),
        NavigationRoutes.detailInventory.name: (context) => DetailInventoryPage(
          item: ModalRoute.of(context)?.settings.arguments as InventoryItem,
        ),
        NavigationRoutes.addInventory.name: (context) => AddInventoryPage(
          inventoryId: ModalRoute.of(context)?.settings.arguments as int,
        ),
      },
    );
  }
}
