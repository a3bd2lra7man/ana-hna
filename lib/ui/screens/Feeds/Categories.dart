import 'dart:convert';

import 'package:ana_hna/data/db/models/Category.dart';
import 'package:ana_hna/providers/AppProvider.dart';
import 'package:ana_hna/providers/Home/CategoryProvider.dart';
import 'package:ana_hna/providers/HomeProvider.dart';
import 'package:ana_hna/ui/screens/Feeds/NearBy.dart';
import 'package:ana_hna/ui/widgets/InternetAble.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:m7utils/m7utils.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.watch<AppP>().primary[200],
      child: ChangeNotifierProvider<CategoryP>(child: CategoryCards(),create: (context)=>CategoryP(context.provider<HomeP>().homeR),),
    );
  }

}

class CategoryCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CategoryP provider = context.watch<CategoryP>();
    return InternetAble(
      internetDataState: _getInternetState(provider.categories),
      onPressed: (context){},
      onData: provider.categories == null
          ? Text("No data")
          : GridView.builder(
        itemCount: provider.categories.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder:(context,index)
        => GestureDetector(
          child: Card(
            elevation: 10,
            child: Container(
              height: context.height * .2,
              width: context.width *.4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(provider.categories.elementAt(index).enName),
                  if(provider.categories.elementAt(index).image != null)
                    CircleImage(image: MemoryImage(base64Decode(provider.categories.elementAt(index).image)),size: 50,)
                ],
              ),
            ),
          ),
          onTap: (){
            context.navigateTo(NearBy(id: provider.categories.elementAt(index).id,name: provider.categories.elementAt(index).enName,),);
          },
        ),
      ),
    );
  }

  InternetDataState _getInternetState(Set<Category> categories) {
    if(categories == null) return InternetDataState.Loading;
    else return InternetDataState.Data;
  }
}
