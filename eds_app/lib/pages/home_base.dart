import 'package:edsapp/config/size_config.dart';
import 'package:edsapp/models/camera.dart';
import 'package:edsapp/models/county.dart';
import 'package:edsapp/models/location.dart';
import 'package:edsapp/pages/cameras.dart';
import 'package:edsapp/pages/profile_page.dart';
import 'package:edsapp/services/location.dart';
import 'package:edsapp/services/video_stream.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeBase extends StatefulWidget {
  @override
  _HomeBaseState createState() => _HomeBaseState();
}

class _HomeBaseState extends State<HomeBase> {

  CamerasPage _camerasPage;
  ProfilePage _profilePage;
  ProfilePageState _profilePageState;
  CamerasPageState _camerasPageState;

  var _currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Camera.list = [];
    Location.list = [];
    County.list = [];
    checkData();
    //initialize chat
    setPages();

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    checkData();
    //initialize chat
    setPages();
  }

  void setPages(){
     _camerasPage = CamerasPage(setPageState: (state){
       _camerasPageState = state;
     },);

     _profilePage = ProfilePage(setPageState: (state){
       _profilePageState = state;
     },);

  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // TODO: implement build
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body:SafeArea(
          top: false,
          child: IndexedStack(
              index: _currentIndex,
              children:[
                _camerasPage , _profilePage
              ]
          ),
        ),

        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xf5f8ffff),
          showUnselectedLabels: true,
          iconSize:25,
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });

          }
          ,unselectedItemColor: Colors.grey,
          selectedItemColor: Theme.of(context).primaryColor,
          elevation: 0,
          items: allDestinations.map((Destination destination) {
            return BottomNavigationBarItem(
              backgroundColor: Color(0xf5f8ffff),
              icon:  Icon(destination.icon,size: 20,),
              title: Text(destination.title,style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 2.7),),
            );
          }).toList(),

        )
    );
  }

  void setIndex(int index) {
    setState(() {
      this._currentIndex = index;
    });
  }

  void checkData() async{
    LocationService.sendLocation();

    if(VideoStream.socket == null || ! await VideoStream.socket.isConnected()){
       VideoStream.initialize();
    }


  }

}

List<Destination> allDestinations = <Destination>[
  Destination("Cameras",icon: Icons.camera),
  Destination("Profile",icon: Icons.person),
];

class Destination {
  Destination(this.title,{this.icon,this.image});
  final String title;
  final IconData icon;
  String image;
}
