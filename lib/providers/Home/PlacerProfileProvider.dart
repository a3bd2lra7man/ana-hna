import 'package:ana_hna/data/HomeRepo.dart';
import 'package:ana_hna/data/db/models/Post.dart';
import 'package:flutter/material.dart';

class PlacerProfileP extends ChangeNotifier{

  Set<Post> posts;
  PlacerProfileP(HomeR homeR,String id){
    _getPosts(homeR,id);
  }

  void _getPosts(HomeR homeR,String id)async{
    Map res = await homeR.getPlacerPosts(id);
    posts = (res['posts'] as List).map((e) => Post.fromMap(e)).toSet();
    notifyListeners();
  }
}