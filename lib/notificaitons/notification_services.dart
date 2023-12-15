import 'dart:io';
import 'dart:math';
import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class NotificationServices{
  FirebaseMessaging messaging= FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();
  void reqNotificationPermission()async {
    NotificationSettings settings= await messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true
    );
    if(settings.authorizationStatus == AuthorizationStatus.authorized){
      if (kDebugMode) {
        print('user granted permission');
      }
    }else if(settings.authorizationStatus == AuthorizationStatus.provisional){
      if (kDebugMode) {
        print('user granted Provisional permission');
      }
    }else{
      AppSettings.openAppSettings();
      if (kDebugMode) {
        print("user denied permission");
      }
    }
  }

  //local Notification

  void initLocalNotification( RemoteMessage message)async{
    var androidInitializationSettings= const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializationSettings= const DarwinInitializationSettings();
    var initializationSetting= InitializationSettings(
        android: androidInitializationSettings,
        iOS: iosInitializationSettings
    );
    await _flutterLocalNotificationsPlugin.initialize(
        initializationSetting,
        onDidReceiveNotificationResponse: (payload){

        });
  }



  void firebaseInit(){
    FirebaseMessaging.onMessage.listen((message) {
      if(kDebugMode) {
        print(message.notification!.title.toString());
        print(message.notification!.body.toString());
      }
      if(Platform.isAndroid){
        initLocalNotification(message);
        showNotification(message);
      }

    });
  }

  //fire show Notification

  Future<void> showNotification(RemoteMessage message) async{

    AndroidNotificationChannel channel= AndroidNotificationChannel(
        Random.secure().nextInt(100000).toString(),
        'High Importance Notification',
        importance: Importance.max
    );
    AndroidNotificationDetails androidNotificationDetails=AndroidNotificationDetails(
        channel.id.toString(),
        channel.name.toString(),
        channelDescription:' My Channel Description',
        importance: Importance.high,
        ticker: 'ticker',
        priority: Priority.high

    );
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails
    );
    Future.delayed(Duration.zero, (){
      _flutterLocalNotificationsPlugin.show(
          0,
          message.notification!.title.toString(),
          message.notification!.body.toString(),
          notificationDetails
      );
    });
  }


// getting and refresh device token

  Future<String?> getDeviceToken() async{
    String? token = await messaging.getToken();
    return token;
  }
  void isTokenRefresh()async{
    messaging.onTokenRefresh.listen((event) {
      event.toString();
    });
  }


}