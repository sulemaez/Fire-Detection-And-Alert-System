

import 'package:edsapp/pages/auth/login.dart';
import 'package:edsapp/pages/home_base.dart';
import 'package:edsapp/services/notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Notifications.setup();

    return GetMaterialApp(
      title: 'EDS',
      theme: ThemeData(
        fontFamily:'Proxima Nova',
        primarySwatch: Colors.blue,
        primaryColor: Color.fromARGB(255, 67, 37,111),
        secondaryHeaderColor:Color(0xffa580b9),
        backgroundColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
            errorMaxLines: 2
        ),
      ),
      home: LoginPage(),
      routes:{
        '/home': (context) => HomeBase()
      } ,
    );
  }
}
