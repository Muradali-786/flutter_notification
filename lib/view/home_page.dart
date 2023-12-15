import 'package:flutter/material.dart';
import 'package:flutter_notification/notificaitons/notification_services.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NotificationServices notificationServices=NotificationServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationServices.reqNotificationPermission();
    notificationServices.firebaseInit();
    notificationServices.getDeviceToken().then((value){
      print('device token');
      print(value);
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text('FLUTTER NOTIFICATIONS'),
      ),
    );
  }
}
