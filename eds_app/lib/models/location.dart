class Location{
 String id;
 String name;
 String countyId;
 static List list = [];

   Location({this.id,this.name,this.countyId});

   Location.fromJson(Map<String,dynamic> map):
         id = map["id"] ?? "",
         name = map["name"] ?? "",
         countyId = map["locationId"] ?? "";

   Map<String, dynamic>  toJson() =>{
     "id" : id, "name" : name, "countyId" : countyId
   };

 static getById(id){
   return list.where((i) => i.id == id).toList()[0];
 }

}