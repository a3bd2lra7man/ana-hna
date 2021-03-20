import 'package:ana_hna/providers/AppProvider.dart';
import 'package:ana_hna/providers/ChatProvider.dart';
import 'package:ana_hna/providers/HomeProvider.dart';
import 'package:ana_hna/ui/screens/Chat.dart';
import 'package:ana_hna/ui/screens/Feed.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:m7utils/m7utils.dart';
class Home extends StatelessWidget {

  static PageController _pageController = PageController(keepPage: true,initialPage: 1);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 2,
          actionsIconTheme: IconThemeData(color: context.provider<AppP>().primary),
          backgroundColor: context.provider<AppP>().primary,
          iconTheme: IconThemeData(color: context.provider<AppP>().second),
          centerTitle: true,
          title: Text("Ana hna",style: GoogleFonts.sacramento(color: context.provider<AppP>().second,fontSize: 40,fontWeight: FontWeight.bold),textAlign: TextAlign.center),
          leading: IconButton(icon: Icon(FontAwesomeIcons.comment,color: context.provider<AppP>().second,), onPressed: (){
            _pageController.jumpToPage(0);
          }),
          actions: [
            IconButton(icon: Icon(FontAwesomeIcons.newspaper,color: context.provider<AppP>().second,), onPressed: (){
              _pageController.jumpToPage(1);

            })
          ],
        ),

        body: PageView(
          pageSnapping: false,
          allowImplicitScrolling: true,
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: [
            ChangeNotifierProvider<ChatP>(create: (context)=>ChatP(context.provider<AppP>().user.remoteId),child: Chat(),),
            Feed(),
          ],
        ),
      ),
    );
  }
}
