import 'package:m7db/m7db.dart';

class Placer extends M7Table{

  String id,email,name,token,image,categoryId,categoryArName,categoryEnName;
  double lat,lng;

  @override
  get primaryKey => 1;

  static const String tableName = 'Placer';
  static const String fields = 'id INTEGER PRIMARY KEY ,name TEXT,image TEXT,token TEXT,email TEXT,lat REAL,lng REAL,categoryId TEXT,categoryArName TEXT,categoryEnName TEXT';

  Placer({this.id,this.name,this.image,this.token,this.categoryArName,this.categoryEnName,this.categoryId,this.lat,this.lng}):super.create();

  Placer.fromMap(Map map):super.fromMap(map){
    id = map['_id'];
    name = map['name'];
    image = map['image'] ?? null;
    token = map['token'];
    email = map['email'];
    lat = map['lat'];
    lng = map['lng'];
    categoryId = map['categoryId'];
    categoryArName = map['categoryArName'];
    categoryEnName = map['categoryEnName'];
  }

  @override
  Map<String, dynamic> toMap() =>{
    "id":id,
    "name":name,
    "image":image,
    "token":token,
    "email":email,
    "lat":lat,
    "lng":lng,
    "categoryId" : categoryId,
    "categoryEnName":categoryEnName,
    "categoryArName":categoryArName
  };

  @override
  M7Table copyWith({String name,String image,String token,String categoryArName,String categoryEnName,String categoryId,double lat,double lng}) {
    return Placer(id: this.id,name: name ?? this.name,image: image ?? this.image,token: token ?? this.token,
        categoryArName: categoryArName ?? this.categoryArName,categoryEnName: categoryEnName ?? this.categoryEnName,categoryId:categoryId ?? this.categoryId,
        lat: lat ?? this.lat,lng: lng ?? this.lng
    );
  }

  @override
  bool operator ==(other) => this.id == other.senderId;

  @override
  int get hashCode => this.id.hashCode;

}
