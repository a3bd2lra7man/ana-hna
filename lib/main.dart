import 'package:ana_hna/providers/AppProvider.dart';
import 'package:ana_hna/ui/screens/Splash.dart';
import 'package:ana_hna/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:m7utils/m7utils.dart' show AppLocalizations,M7Extensions;
import 'package:provider/provider.dart';


main() => runApp(ChangeNotifierProvider<AppP>(
    create: (context) => AppP(), child: MyApp()));

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: context.watch<AppP>().primary,statusBarIconBrightness: context.watch<AppP>().primary == AppColors.primary ? Brightness.light : Brightness.dark));
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: Locale(context.watch<AppP>().localeName),
      supportedLocales: [
        Locale('ar'),
        Locale('en'),
      ],
      theme: _themeData(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        AppLocalizations.delegate
      ],
      title: 'Ana hna',
      home: ChangeNotifierProvider.value(value: context.provider<AppP>(),child: Splash()),

    );
  }

  ThemeData _themeData() => ThemeData(
        // brightness: Brightness.light,
        // backgroundColor: Colors.white,
        // primaryColorLight: Colors.white,
        // primaryColorBrightness: Brightness.light,

        textTheme: TextTheme(
            headline1: TextStyle(
              color: AppColors.second,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            headline2: TextStyle(
              color: AppColors.third[900],
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
            headline3: TextStyle(
              color: AppColors.third[900],
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            headline4: TextStyle(
              color: AppColors.third[900],
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
            headline5: TextStyle(color: AppColors.third[900], fontSize: 12),
            headline6: TextStyle(color: AppColors.third[900], fontSize: 9)),

        appBarTheme: AppBarTheme(color: AppColors.primary, elevation: 10),

        primarySwatch: AppColors.primary,
      );
}
