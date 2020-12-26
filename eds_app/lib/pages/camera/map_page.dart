
import 'dart:async';
import 'package:edsapp/config/size_config.dart';
import 'package:edsapp/services/gmaps_service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  Function setPageState;
  var latLong;

  MapPage({this.setPageState , this.latLong});

  @override
  MapPageState createState(){
     MapPageState state = MapPageState();
     setPageState(state);
     return state;
  }
}

class MapPageState extends State<MapPage>{


  bool loading = true;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polyLines = {};
  GoogleMapsServices _googleMapsServices = GoogleMapsServices();
  Set<Polyline> get polyLines => _polyLines;
  Completer<GoogleMapController> _controller = Completer();
  static LatLng latLng ;
  LocationData currentLocation;


  @override
  void initState() {
    super.initState();

     if(mounted){
       setState(() {
         getLocation();
       });
       loading = false;
     }
  }

  @override
  void dispose(){
    super.dispose();
  }

  getLocation() async {

   try{
     Location location = new Location();
     location.onLocationChanged.listen((  currentLocation) {

       setState(() {
         latLng =  LatLng(currentLocation.latitude, currentLocation.longitude);
       });

       _onAddMarkerButtonPressed();
       loading = false;
     });
   }catch(e){}

  }



  void _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId("111"),
        position: latLng,
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }


  void onCameraMove(CameraPosition position) {
    latLng = position.target;
  }

  List<LatLng> _convertToLatLng(List points) {
    List<LatLng> result = <LatLng>[];
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(points[i - 1], points[i]));
      }
    }
    return result;
  }

  void sendRequest() async {
    LatLng destination = LatLng(double.parse(widget.latLong.split(",")[0]),double.parse(widget.latLong.split(",")[1]));
    String route = await _googleMapsServices.getRouteCoordinates(
        latLng, destination);
    createRoute(route);
    _addMarker(destination,"KTHM Collage");
  }

  void createRoute(String encondedPoly) {
    _polyLines.add(Polyline(
        polylineId: PolylineId(latLng.toString()),
        width: 4,
        points: _convertToLatLng(_decodePoly(encondedPoly)),
        color: Colors.red));
  }

  void _addMarker(LatLng location, String address) {
    _markers.add(Marker(
        markerId: MarkerId("112"),
        position: location,
        infoWindow: InfoWindow(title: address, snippet: "go here"),
        icon: BitmapDescriptor.defaultMarker));
  }

  List _decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = new List();
    int index = 0;
    int len = poly.length;
    int c = 0;
    do {
      var shift = 0;
      int result = 0;

      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);
      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);

    for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];

    print(lList.toString());

    return lList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: latLng == null ? Container() : GoogleMap(
         polylines: polyLines,
         markers: _markers,
         mapType: MapType.normal,
         initialCameraPosition: CameraPosition(
           target: latLng,
           zoom: 14.4746,
         ),
         onCameraMove:  onCameraMove,
         onMapCreated: (GoogleMapController controller) {
           _controller.complete(controller);
         },
       ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 35),
        child:FloatingActionButton.extended(

          onPressed: (){
            sendRequest();
          },
          label: Text('Route'),
          icon: Icon(Icons.directions_boat),
        ),
      )
    );
  }
}
