import 'package:edsapp/config/size_config.dart';
import 'package:edsapp/models/camera.dart';
import 'package:edsapp/models/location.dart';
import 'package:edsapp/pages/camera/camera_base.dart';
import 'package:edsapp/services/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

CamerasPageState camerasPageStateMain;

class CamerasPage extends StatefulWidget {

  Function setPageState;

  CamerasPage({ setPageState }):this.setPageState = setPageState ;

  @override
  CamerasPageState createState(){
    CamerasPageState state = CamerasPageState();
    setPageState(state);
    camerasPageStateMain = state;
    return state;
  }


}

class CamerasPageState extends State<CamerasPage> {
  List camerasList = [];
  List cameraEmergencies = [];


  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    checkData();
    cameraEmergencies = Camera.listEmergencies;
  }

  save(Camera camera){
    if(Camera.listEmergencies.contains(camera))return;
    Camera.listEmergencies.add(camera);
    setState(() {
      cameraEmergencies = [];
      cameraEmergencies = Camera.listEmergencies;
      cameraEmergencies.length;
    });
  }

  void checkData()async{
    await Repository.getAll();
    setState(() {
      camerasList = Camera.list;
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    setState(() {
      camerasList = Camera.list;
    });

    setState(() {
       cameraEmergencies = Camera.listEmergencies;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical * 2,horizontal: SizeConfig.blockSizeHorizontal * 4,),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: SizeConfig.blockSizeVertical * 5,),
              Text("Alerts",style: TextStyle(fontWeight: FontWeight.bold,fontSize: SizeConfig.blockSizeHorizontal * 5,color: Theme.of(context).accentColor),),
              ListView(
                shrinkWrap: true,
                children: setupCamerasEmergencies(),
              ),
              SizedBox(height: SizeConfig.blockSizeVertical * 5,),
              Text("Other Cameras",style: TextStyle(fontWeight: FontWeight.bold,fontSize: SizeConfig.blockSizeHorizontal * 5,color: Theme.of(context).accentColor),),
              ListView(
                shrinkWrap: true,
                children: setupCameras(),
              )
            ],
          ),
        ),
      ),
    );
  }

List<Widget> setupCameras(){
   List<Widget> list = [];

   camerasList.forEach((cam){

     list.add( Padding(
       padding: EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical-2,horizontal:SizeConfig.blockSizeHorizontal * 3),
       child: GestureDetector(
         child: Container(
           width: SizeConfig.blockSizeHorizontal * 100,
           child: Card(
             child: Container(
               padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3),
               child: Row(
                 children: <Widget>[

                   Container(
                     child: VerticalDivider(color:Colors.grey.withOpacity(0.5), width:0.2,),
                     height: SizeConfig.blockSizeVertical * 8,
                   ),
                   SizedBox(width: SizeConfig.blockSizeHorizontal * 5,),
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: <Widget>[
                       Container(
                         child: Text(cam.name,style: TextStyle(color: Color.fromARGB(255, 85, 85, 85),fontSize: SizeConfig.blockSizeHorizontal * 4.5),),
                         width: SizeConfig.blockSizeHorizontal * 60,
                       ),
                       SizedBox(height: SizeConfig.blockSizeVertical * 0.7,),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.start,
                         children: <Widget>[
                           Text("${Location.getById(cam.locationId).name}",style: TextStyle(color: Colors.black54,fontWeight: FontWeight.w800),)
                         ],),
                       SizedBox(height: SizeConfig.blockSizeVertical * 0.7,),

                     ],
                   )
                 ],
               ),
               decoration: BoxDecoration(
                   border: Border(
                       left: BorderSide(
                           color:Color.fromARGB(255, 246, 144, 33),
                           width: 4
                       )
                   )
               ),
             ),
           ),
         ),
         onTap: (){
           Navigator.of(context).push(MaterialPageRoute(builder: (context) => CameraBasePage( name : cam.name , coordinates : cam.coordinates)));
         },
       ),
       ),
     );
   });

   return list;
 }

 List<Widget> setupCamerasEmergencies() {
   List<Widget> list = [];

   cameraEmergencies.forEach((cam){

     list.add( Padding(
       padding: EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical-2,horizontal:SizeConfig.blockSizeHorizontal * 3),
       child: GestureDetector(
         child: Container(
           width: SizeConfig.blockSizeHorizontal * 100,
           child: Row(
             children: [
                 Flexible(
                   flex: 8,
                   child:
                     Card(
                       child: Container(
                         padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3),
                         child: Row(
                           children: <Widget>[

                             Container(
                               child: VerticalDivider(color:Colors.grey.withOpacity(0.5), width:0.2,),
                               height: SizeConfig.blockSizeVertical * 8,
                             ),
                             SizedBox(width: SizeConfig.blockSizeHorizontal * 5,),
                             Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: <Widget>[
                                 Container(
                                   child: Text(cam.name,style: TextStyle(color: Color.fromARGB(255, 85, 85, 85),fontSize: SizeConfig.blockSizeHorizontal * 4.5),),
                                   width: SizeConfig.blockSizeHorizontal * 60,
                                 ),
                                 SizedBox(height: SizeConfig.blockSizeVertical * 0.7,),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.start,
                                   children: <Widget>[
                                     Text("${Location.getById(cam.locationId).name}",style: TextStyle(color: Colors.black54,fontWeight: FontWeight.w800),)
                                   ],),
                                 SizedBox(height: SizeConfig.blockSizeVertical * 0.7,),

                               ],
                             )
                           ],
                         ),
                         decoration: BoxDecoration(
                             border: Border(
                                 left: BorderSide(
                                     color:Color.fromARGB(255, 246, 144, 33),
                                     width: 4
                                 )
                             )
                         ),
                       ),
                     ),
                 ),
                Flexible(
                  child : IconButton(
                    onPressed: (){
                       setState(() {
                         Camera.listEmergencies.remove(cam);
                         cameraEmergencies.remove(cam);
                       });
                    },
                    icon: Icon(Icons.close,color: Colors.red,),
                  ) ,
                  flex: 1,
                )
             ],
           ),
         ),
         onTap: (){
           Navigator.of(context).push(MaterialPageRoute(builder: (context) => CameraBasePage( name : cam.name , coordinates : cam.coordinates)));
         },
       ),
     ),
     );
   });

   return list;
 }

}
