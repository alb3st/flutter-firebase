import 'package:flutter/material.dart';
import 'package:pertemuan_firebase/pages/login_page.dart';
import 'package:pertemuan_firebase/pages/register_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showLoginPage = true;

  void toggleScreens() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(showRegister: toggleScreens);
    } else {
      return RegisterPage(showLogin: toggleScreens);
    }
  }
}
