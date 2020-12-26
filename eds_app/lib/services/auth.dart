import 'dart:async';
import 'package:dio/dio.dart';
import 'package:edsapp/models/camera.dart';
import 'package:edsapp/models/location.dart';
import 'package:edsapp/models/county.dart';
import 'package:edsapp/models/user.dart';
import 'package:edsapp/pages/auth/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'http.dart';


class Auth{

  static User user;

  static Future<bool> signIn(String username, String password) async {
    if(!await checkNet())return null;
    Response response = await Http.doPost(data : { "email" : username , "password" : password},url: "${Http.baseUrl}authenticate/user");

    if (response.statusCode == 200){
      user = User();
      user.username = response.data["user"]["username"];
      user.name = response.data["user"]["name"];
      user.uid = response.data["user"]["id"];
      user.token = response.data["token"];

      print(user.token);
      return true;
    }else{
      print(response.statusCode);

      return false;
    }
  }


  static Future<User> getCurrentUser() async {
    return user;
  }

  static Future<void> signOut(BuildContext context) async {
     Auth.user = user;
     SharedPreferences pref = await SharedPreferences.getInstance();
     pref.remove("user");
     Camera.list = [];
     Location.list = [];
     County.list = [];
     Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
  }


}