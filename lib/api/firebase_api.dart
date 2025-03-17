import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:pertemuan_firebase/main.dart';

class FirebaseApi {
  // create an instance of Firebase Messaging
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  //function to initialize notification
  Future<void> initializeNotification() async {
    //request permission for user (will prompt user)
    await _firebaseMessaging.requestPermission();

    //fetch FCM token for this device
    final FCMtoken = await _firebaseMessaging.getToken();

    print('FCM Token: $FCMtoken');

    //initialize further settings for push notifications
    initializeBackground();
  }

  //function to handle receveived messages
  void handleMessages(RemoteMessage? message) {
    //if the message is null, do nothing
    if (message == null) {
      return;
    }

    //navigate to new screen when message is received and user taps notification
    navigatorKey.currentState?.pushNamed(
      '/notification_screen',
      arguments: message,
    );
  }

  //funtion to initialize background setting
  Future<void> initializeBackground() async {
    //handle notification if the app was terminated and now opened
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      handleMessages(message);
    });

    //attach event listeners for when a notification is opens the app
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      handleMessages(message);
    });
  }
}
