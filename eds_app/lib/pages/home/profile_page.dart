
import 'package:edsapp/config/size_config.dart';
import 'package:flutter/cupertino.dart';

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
      child: Center(
        child: Text("Profile"),
      ),
    );
  }
}