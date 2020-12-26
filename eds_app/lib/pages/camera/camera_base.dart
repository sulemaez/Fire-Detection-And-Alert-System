import 'package:edsapp/config/size_config.dart';
import 'package:edsapp/pages/camera/video_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'map_page.dart';


class CameraBasePage extends StatefulWidget{
  var coordinates;
  var name;


  CameraBasePage({this.coordinates, this.name});

  @override
  CameraBasePageState createState() => CameraBasePageState();
}

class CameraBasePageState extends State<CameraBasePage>{

  int _currentIndex = 0;

  MapPage _mapPage;
  MapPageState mapPageState;
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _videoPage = null;
    _mapPage = null;
  }

  void setPages(){
     _mapPage = MapPage(latLong: widget.coordinates, setPageState : (state){
         mapPageState = state;
      });

     _videoPage = VideoPage(name: widget.name,setPageState: (state){
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
                  _mapPage , _videoPage
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
];

class Destination {
  Destination(this.title,{this.icon,this.image});
  final String title;
  final IconData icon;
  String image;
}