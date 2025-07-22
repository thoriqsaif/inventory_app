import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:inventory_app/controllers/auth_controller/auth_controller.dart';
import 'package:inventory_app/data/firebase_auth/firebase_auth_service.dart';
import 'package:inventory_app/data/models/inventory_item.dart';
import 'package:inventory_app/navigations/navigations_routes.dart';
import 'package:inventory_app/screen/home/inventory_list_screen.dart';
import 'package:inventory_app/screen/inventory_detail/inventory_detail_screen.dart';
import 'package:inventory_app/screen/register_screen/register_screen.dart';
import 'package:inventory_app/screen/signin_screen/signin_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase instance
  await Firebase.initializeApp();

  // enable firestore offline mode
  FirebaseFirestore.instance.settings = Settings(persistenceEnabled: true);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  var initialRoute = NavigationsRoutes.signin;
  final AuthController authController = Get.put(
    AuthController(Get.put(FirebaseAuthService())),
  );

  @override
  Widget build(BuildContext context) {
    final signInState = authController.checkUserSignInState();

    return StreamBuilder<User?>(
      stream: signInState,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          return MaterialApp(
            title: 'Stay tune the movie!',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
              useMaterial3: true,
            ),
            themeMode: ThemeMode.system,
            initialRoute: snapshot.data != null
                ? NavigationsRoutes.inventory
                : NavigationsRoutes.signin,
            routes: {
              NavigationsRoutes.signin: (_) => const SignInScreen(),
              NavigationsRoutes.register: (_) => const RegisterScreen(),
              NavigationsRoutes.inventory: (_) => const InventoryPage(),
              // addInventory: (_) => const  AddInventoryPage(Set<dynamic>(), inventoryId: 0),
              NavigationsRoutes.detailInventory: (context) {
                final args = ModalRoute.of(context)?.settings.arguments;
                if (args is InventoryItem) {
                  return DetailInventoryPage(item: args);
                } else {
                  return const Scaffold(
                    body: Center(
                      child: Text('Invalid or missing inventory data'),
                    ),
                  );
                }
              },
            },
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }

  // return MultiProvider(
  //   providers: [
  //     StreamProvider<User?>.value(
  //       value: FirebaseAuth.instance.authStateChanges(),
  //       initialData: FirebaseAuth.instance.currentUser,
  //     ),
  //   ],
  //   child: MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     title: 'Inventory Manager',
  //     theme: ThemeData(primarySwatch: Colors.indigo),
  //     initialRoute: NavigationsRoutes.signin,
  //     routes: NavigationsRoutes.map,
  //   ),
  // );
}
