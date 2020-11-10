import 'package:edsapp/config/size_config.dart';
import 'package:edsapp/pages/home/map_page.dart';
import 'package:edsapp/pages/home/profile_page.dart';
import 'package:edsapp/pages/home/video_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class HomeBase extends StatefulWidget{

  final bool newGroup;

  HomeBase({this.newGroup});

  @override
  HomeBaseState createState() => HomeBaseState();
}

class HomeBaseState extends State<HomeBase>{

  int _currentIndex = 0;

  MapPage _mapPage;
  MapPageState mapPageState;
  ProfilePage _profilePage;
  ProfilePageState profilePageState;
  VideoPage _videoPage;
  VideoPageState videoPageState;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    //initialize chat
    setPages();
  }

  void setPages(){
     _mapPage = MapPage( setPageState : (state){
         mapPageState = state;
      });
     _profilePage = ProfilePage(setPageState: (state) {
        profilePageState = state;
     },);
     _videoPage = VideoPage(setPageState: (state){
         videoPageState = state;
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
                  _mapPage , _videoPage , _profilePage
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
            _handlePageActivities(index);
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


  //refreshes the page
  void _handlePageActivities(int index)async{
    if(index == 1){
      SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    }else{

      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }
    refreshPages();
  }

  refreshPages(){

  }


  void setIndex(int index) {
    setState(() {
      this._currentIndex = index;
    });
  }

}


List<Destination> allDestinations = <Destination>[
  Destination("Map",icon: Icons.map),
  Destination("CCTV",icon: Icons.camera),
  Destination("Profile",icon: Icons.person),

];

class Destination {
  Destination(this.title,{this.icon,this.image});
  final String title;
  final IconData icon;
  String image;
}