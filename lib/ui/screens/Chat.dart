import 'package:ana_hna/providers/AppProvider.dart';
import 'package:ana_hna/ui/screens/Chats/AllPlacers.dart';
import 'package:ana_hna/ui/screens/Chats/OldChat.dart';
import 'package:ana_hna/ui/widgets/Chat/ChatAppBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';




class Chat extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: context.watch<AppP>().primary,
        appBar: chatAppBar(60),
        body: TabBarView(
          children: <Widget>[
            OldChat(),
            EntryChat(),
          ],
        )


      ),
    );
  }
}
