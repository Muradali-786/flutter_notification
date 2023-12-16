import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_notification/notificaitons/notification_services.dart';
import 'package:http/http.dart' as http;


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
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessageScreen(context);
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
      body: Center(
        child: TextButton(onPressed: (){
          notificationServices.getDeviceToken().then((value) async{
            var data={
              'to':value.toString(),
              'priority':'high',
              'notification':{
                'title':'murad',
                'body':'khan is khan'
              },
              'data':{
                'id':'1234',
                'type':'msg'
              },


            };
            await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
            body: jsonEncode(data),

            headers: {
              'Content-Type':'application/json; charset=UTF-8',
              'Authorization':'key=keyvalue'
            }
            );

          });




        }, child: Text('click')),
      ),
    );
  }
}
