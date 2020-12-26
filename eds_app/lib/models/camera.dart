class Camera{
  String id;
  String name;
  String locationId;
  String coordinates;
  static List list = [];
  static List listEmergencies = [];

  Camera({this.id,this.name,this.locationId,this.coordinates});

  Camera.fromJson(Map<String,dynamic> map):
        id = map["id"] ?? "",
        name = map["name"] ?? "",
        locationId = map["locationId"] ?? "",
        coordinates = map["coordinates"] ?? "";

  Map<String, dynamic>  toJson() =>{
    "id" : id, "name" : name, "locationId" : locationId, "coordinates" : coordinates
  };

  static getById(id){
    list.firstWhere((element) => element.id == id);
  }

}