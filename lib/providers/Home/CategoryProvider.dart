import 'package:ana_hna/data/HomeRepo.dart';
import 'package:ana_hna/data/db/models/Category.dart';
import 'package:flutter/material.dart';

class CategoryP extends ChangeNotifier{

  Set<Category> categories;

  CategoryP(HomeR homeR){
    _getCategories(homeR);
  }

  void _getCategories(HomeR homeR)async {
    Map res = await homeR.getCategories();
    categories = (res['categories'] as List).map((e) => Category.fromMap(e)).toSet();
    notifyListeners();
  }

}