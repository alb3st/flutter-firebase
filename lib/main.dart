import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pertemuan_firebase/api/firebase_api.dart';
// import 'package:pertemuan_firebase/login_page.dart';
import 'package:pertemuan_firebase/auth/main_page.dart';
import 'package:pertemuan_firebase/firebase_options.dart';
import 'package:pertemuan_firebase/pages/notification_page.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final firebaseApi = FirebaseApi();
  await firebaseApi.initializeNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flirebase Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainPage(),
      navigatorKey: navigatorKey,
      routes: {
        '/notification_screen': (context) => const NotificationPage(),
      },
    );
  }
}
