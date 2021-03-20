
import 'package:ana_hna/data/apis/HomeApi.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:m7utils/m7utils.dart';

class HomeR {

  HomeApi _homeApi;
  HomeR(M7Client _m7client):
        _homeApi = HomeApi(_m7client);

  Future<Map> getPlacers(LatLng location)async
  => await _homeApi.getPlacers(location);

  Future<Map> getPosts(LatLng location)async
  => await _homeApi.getPosts(location);

  Future<Map> getPlacerPosts(String id)async
  => await _homeApi.getPlacerPosts(id);

  Future<Map> getCategories()async
  => await _homeApi.getCategories();
}