import 'package:ana_hna/providers/AppProvider.dart';
import 'package:ana_hna/providers/Home/MapProvider.dart';
import 'package:ana_hna/providers/HomeProvider.dart';
import 'package:ana_hna/ui/screens/Feeds/Categories.dart';
import 'package:ana_hna/ui/screens/Feeds/Map.dart';
import 'package:ana_hna/ui/screens/Feeds/NearBy.dart';
import 'package:ana_hna/ui/screens/Feeds/Posts.dart' as ui;
import 'package:ana_hna/ui/screens/Profile/Profile.dart';
import 'package:ana_hna/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:m7utils/m7utils.dart';
class Feed extends StatelessWidget {

  final PersistentTabController _controller = PersistentTabController(initialIndex: 2);



  @override
  Widget build(BuildContext context) {
    HomeP homeP = context.watch<HomeP>();
    bool isDark = context.watch<AppP>().primary == AppColors.primary ? true : false;
    return Material(
      color: context.watch<AppP>().second,


      child: PersistentTabView(
        decoration: NavBarDecoration(),
        resizeToAvoidBottomInset: true,
        navBarHeight: context.height *.1,
        padding: NavBarPadding.all(2),
        backgroundColor: context.provider<AppP>().primary,
        onItemSelected: (index)=>_onBottomClicked(context,index),
        controller: _controller,
        navBarStyle:  NavBarStyle.style5,
        screens: [
          ChangeNotifierProvider<MapProvider>(create: (context)=>MapProvider(homeP.nearByPlacers),child: AppMap()),
          Categories(),
          ui.Posts(),
          NearBy(),
          Profile(onLogOut:()=> context.provider<AppP>().logout(context),),
        ],
        items: [
          _navBar(
            isDark,
            icon: Icon(Icons.location_on),
            title: "Trends",
          ),
          _navBar(
            isDark,
            icon: Icon(FontAwesomeIcons.searchLocation),
            title: "NearBy",
          ),

          _navBar(
            isDark,
            icon: Icon(FontAwesomeIcons.home),
            title: "Home",
          ),


          _navBar(
            isDark,
            icon: Icon(FontAwesomeIcons.eye),
            title: "Sorting",
          ),


          _navBar(
            isDark,
            icon: Icon(Icons.person),
            title: context.translate('Profile'),
          ),

        ],
      ),
    );
  }


  PersistentBottomNavBarItem _navBar(bool isDark,{Icon icon,String title})
  => PersistentBottomNavBarItem(
    icon: icon,
    title: title,
    activeColor: !isDark ? AppColors.primary : AppColors.second,
    inactiveColor: AppColors.third,
  );

  void _onBottomClicked(BuildContext context, int index) {
    if(index == 1 || index == 4){
      print("here 1");
    }
    if(index == 3){
    }
  }
}
