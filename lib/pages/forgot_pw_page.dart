import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  // Membuat method terpisah untuk menampilkan dialog
  void _showDialog({
    required String title,
    required String message,
    VoidCallback? onPressed,
  }) {
    if (!mounted) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (onPressed != null) onPressed();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> passwordReset() async {
    if (!mounted) return;

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());

      if (!mounted) return;

      _showDialog(
        title: 'Success',
        message:
            'Jika email terdaftar, link reset password akan dikirim ke email Anda',
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      String errorMessage;
      switch (e.code) {
        case 'invalid-email':
          errorMessage = 'Format email tidak valid';
          break;
        case 'user-not-found':
          errorMessage = 'Email tidak terdaftar';
          break;
        case 'too-many-requests':
          errorMessage = 'Terlalu banyak permintaan. Silakan coba lagi nanti';
          break;
        default:
          errorMessage = e.message ?? 'Terjadi kesalahan';
      }

      _showDialog(
        title: 'Error',
        message: errorMessage,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
        backgroundColor: Colors.deepPurple[200],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              'Enter your email to reset password',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.deepPurple),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: "Email",
                fillColor: Colors.grey[200],
                filled: true,
              ),
            ),
          ),
          const SizedBox(height: 10),
          MaterialButton(
            onPressed: passwordReset,
            color: Colors.deepPurple[200],
            child: const Text('Send Reset Email'),
          ),
        ],
      ),
    );
  }
}
