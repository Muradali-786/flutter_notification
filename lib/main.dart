import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notification/view/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: "AIzaSyBkZTq-bhgvJqYCAhaveH9SkhPrb4iT0KY",
              appId: "1:948361500075:android:777d35aec33ed5a6fc2eee",
              messagingSenderId: "948361500075",
              projectId: "flutter-notification-c8e63",
              storageBucket: "gs://flutter-notification-c8e63.appspot.com"),
        )
      : Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackHandler);

  runApp(const MyApp());
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Push Notifications',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.cyan),
      home: const HomePage(),
    );
  }
}
