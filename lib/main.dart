import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:stars/SQL/Sql1.dart';
//import 'package:stars/SQL/Sql1.dart';
import 'package:stars/SQL/mySqdb.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stars/ShopApp/Fav.dart';
import 'package:stars/go2.dart';
import 'package:stars/MyProvider.dart';

import 'package:stars/payment.dart';
import 'package:stars/test.dart';

//import 'SQL/Sql1.dart';
import 'FireBase.dart/FireStore.dart';
import 'Mlang.dart';
import 'SQL/Sqltest.dart';
import 'ShopApp/Add.dart';
import 'ShopApp/AuthScreen.dart';
import 'ShopApp/Painting.dart';
import 'ShopApp/ProviderProduct.dart';
import 'ShopApp/ProviderAuth.dart';

import 'ShopApp/cusfav.dart';
import 'ShopApp/decreption.dart';
import 'TASK/AUTHPRO.dart';
import 'TASK/AUTHSCR.dart';
import 'TASK/mocky.dart';
import 'go.dart';
import 'go3.dart';
import 'go4.dart';
import 'googleMaps/GoMatest.dart';
import 'sh.dart';
import 'test2.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb;
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'ShopApp/ProductScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // mySqdb mydb = mySqdb();
/*   mydb.dogdata();
  await mydb.insert(dog(0, 'mmh0', 10));
  await mydb.insert(dog(1, 'mmh1', 11));
  await mydb.insert(dog(2, 'mmh2', 12));
  await mydb.insert(dog(3, 'mmh3', 13));
  sh sh1 = sh(); */
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  sh sh1 = sh();
  //MyApp(this.sh1);
  // This widget is the root of your application.
  void x() {}
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: product()),
        ChangeNotifierProvider.value(value: ProviderAuth()),
        ChangeNotifierProxyProvider<ProviderAuth, ProviderProduct>(
            create: (_) => ProviderProduct(),
            update: (context, value, pp) => pp
              ..getdata(value.t, value.usId, pp.items == null ? [] : pp.items)),
      ],
      child: Consumer<ProviderAuth>(
        builder: (ctx, value, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          debugShowMaterialGrid: false,
          home: HomeScreen()
          /*   value.Auth
              ? ProductScreen()
              : FutureBuilder(
                  future: value.tryautlogin(),
                  builder: (ctx, snapshot) {
                    return snapshot.connectionState == ConnectionState.waiting
                        ? SplashScreen()
                        : AuthScreen();
                  }) */
          ,
        ),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}




  







//gradle-6.5-all.zip






/* 
 themeMode: ThemeMode.system,
      darkTheme: ThemeData(primaryColor: Colors.black),
      theme: ThemeData(
        primarySwatch: Colors.grey, //اللو ن الاساسي
      ),

      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''),
        Locale('ar', ''),
      ],
      // locale: Locale('en', ''),
      // locale: sh1.enar == 0 ? Locale('en', '') : Locale('ar', ''),

      localeResolutionCallback: (currentLocale, supportedLocales) {
        if (currentLocale != null) {
          for (Locale locale in supportedLocales) {
            if (currentLocale.languageCode == locale.languageCode) {
              if (currentLocale.languageCode == 'en') {
                sh1.enar = 0;
                return currentLocale;
              } else {
                sh1.enar = 1;
                return currentLocale;
              }
            }
          }
        }

        return supportedLocales.first;
      }, */