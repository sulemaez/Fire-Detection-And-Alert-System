
import 'package:edsapp/config/size_config.dart';
import 'package:edsapp/services/auth.dart';
import 'package:edsapp/widgets/btn_default.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  Function setPageState;

 ProfilePage({setPageState }):this.setPageState = setPageState ;

  @override
  ProfilePageState createState(){
     ProfilePageState state = ProfilePageState();
     setPageState(state);
     return state;
  }
}

class  ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: SizeConfig.blockSizeVertical * 7,),
          Align(
            alignment: Alignment.center,
            child:
            CircleAvatar(
              radius: SizeConfig.blockSizeHorizontal * 20,
            )
          ),
          SizedBox(height: SizeConfig.blockSizeVertical * 3,),
          Align(
              alignment: Alignment.center,
              child:Text(Auth.user.name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: SizeConfig.blockSizeHorizontal * 5))
          ),
          SizedBox(height: SizeConfig.blockSizeVertical * 30,),
          DefaultButton(text: "LOGOUT",callback: (){
            Auth.signOut(context);
          },)

        ],
      ),
    );
  }
}