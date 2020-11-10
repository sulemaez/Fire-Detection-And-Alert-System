import 'dart:async';

import 'package:dio/dio.dart';
import 'package:edsapp/models/user.dart';
import 'package:flutter/cupertino.dart';

import 'http.dart';
//import 'package:shared_preferences/shared_preferences.dart';


class Auth{

  static User user;

  static Future<bool> signIn(String username, String password) async {
    if(!await checkNet())return null;
    print({ "username" : username , "password" : password});
    Response response = await Http.doPost(data : { "username" : username , "password" : password},url: "${Http.baseUrl}authenticate");
    if (response.statusCode == 200){
      user = User();
      user.username = username;
      user.token = response.data["token"];

      print(user.token);
      return true;
    }else{
      return false;
    }
  }


  static Future<User> getCurrentUser() async {
    return user;
  }

  static Future<void> signOut(BuildContext context) async {

  }


}