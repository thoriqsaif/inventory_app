import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:inventory_app/controllers/auth_controller/auth_controller.dart';
import 'package:inventory_app/data/firebase_auth/firebase_auth_service.dart';
import 'package:inventory_app/navigations/navigations_routes.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController psswdController = TextEditingController();

  AuthController authController = Get.put(
    AuthController(Get.put(FirebaseAuthService())),
  );

  bool passwordVisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 400,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      'Masuk dah',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),
                SizedBox.square(dimension: 32),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Masukan Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                SizedBox.square(dimension: 16),
                TextField(
                  controller: psswdController,
                  obscureText: passwordVisible,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Masukan Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox.square(dimension: 16),
                ElevatedButton(
                  onPressed: () async {
                    _signInWithEmail();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text('Masuk'),
                    ),
                  ),
                ),
                SizedBox.square(dimension: 16),
                Text('Atau'),
                SizedBox.square(dimension: 16),
                ElevatedButton(
                  onPressed: () async {
                    _signInWithGoogle();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text('Masuk dengan Google'),
                    ),
                  ),
                ),
                SizedBox.square(dimension: 32),
                Row(
                  children: [
                    Text('Belum punya akun?'),
                    SizedBox.square(dimension: 4),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          NavigationsRoutes.register,
                        );
                      },
                      child: Text('Daftar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _signInWithEmail() async {
    try {
      final result = await authController.signIn(
        emailController.text,
        psswdController.text,
      );

      if (mounted) {
        _showSnackbar('Sukses masuk sebagai ${result.user?.email}');
        //Navigator.pushNamed(context, NavigationRoutes.movieList.name);
      }
    } on FirebaseAuthException catch (e) {
      _showSnackbar('Masuk gagal: ${e.message}');
    } catch (e) {
      _showSnackbar('Masuk gagal');
    }

    emailController.clear();
    psswdController.clear();
  }

  Future _signInWithGoogle() async {
    try {
      final result = await authController.signInWithGoogle();

      if (result != null) {
        if (mounted) {
          _showSnackbar('Sukses masuk sebagai ${result.user?.email}');
          //Navigator.pushNamed(context, NavigationRoutes.movieList.name);
        }
      }
    } on FirebaseAuthException catch (e) {
      _showSnackbar('Masuk gagal: ${e.message}');
    } on GoogleSignInException catch (e) {
      _showSnackbar('Masuk gagal: ${e.description}');
    } catch (e) {
      _showSnackbar('Masuk gagal: $e');
    }
  }

  _showSnackbar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  }
}
