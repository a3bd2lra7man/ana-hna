import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:m7utils/m7utils.dart';

class HomeApi {
  M7Client _m7client;

  HomeApi(this._m7client);

  Future<Map> updateProfile(String id,{String name,String image})async =>
      await _m7client.request(
          requestType: RequestType.post,
          url: 'users/updateProfile',
          data: {"id":id, if(image != null)"image":image,if(name != null)"name":name}
      );

  Future<Map> getPlacers(LatLng location)async =>
      await _m7client.request(
        requestType: RequestType.post,
        url: 'placers/getByLocation',
        data: {'location':[location.longitude,location.latitude]}
      );

  Future<Map> getPosts(LatLng location)async =>
      await _m7client.request(
          requestType: RequestType.post,
          url: 'posts/getByLocation',
          data: {'location':[location.longitude,location.latitude]}
      );
  Future<Map> getPlacerPosts(String id)async =>
      await _m7client.request(
          requestType: RequestType.post,
          url: 'posts/getById',
          data: {"id":id}
      );


  Future<Map> getCategories()async =>
      await _m7client.request(
          requestType: RequestType.getT,
          url: 'categories/getAll',
      );

}

