import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:edsapp/models/camera.dart';
import 'package:edsapp/pages/camera/camera_base.dart';
import 'package:edsapp/pages/home_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';


class Notifications{

  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static int notificationCount = 1;
  static Camera cam;
  static  AudioCache player = AudioCache();

  static setup() async{

    var initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: null
    );
    var initializationSettings = InitializationSettings( android :initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize( initializationSettings, onSelectNotification: selectNotification);


  }


  static Future selectNotification(String payload) async {
    print("MOVE $payload");
    if(notificationCount > 1)notificationCount--;

      Get.off(HomeBase());

  }

  static showNotification(data,Camera camera) async {
    player.play("horn.mp3");
    cam = camera;
    print("ALERTING");

    await flutterLocalNotificationsPlugin.show(
        notificationCount++, 'FIRE EMERGENCY', '${ data["camera"]}  - ${data['location']}', getPlatform(),
        payload: 'notification'
    );
  }


  static getPlatform(){
    var android =  AndroidNotificationDetails(
        'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
        priority: Priority.high,importance: Importance.max,
        groupKey: 'noti'
    );
    var iOS =  IOSNotificationDetails();
    return NotificationDetails( android: android,iOS: iOS);
  }



}