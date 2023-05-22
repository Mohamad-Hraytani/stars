import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stars/Screens/AuthScreen.dart';
import 'package:stars/Screens/Explanepages.dart';
import 'package:stars/Screens/ProductScreen.dart';

import 'Providers/ProviderProduct.dart';
import 'Providers/ProviderAuth.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';


import 'package:flutter_stripe/flutter_stripe.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pr1 = await SharedPreferences.getInstance();

  var se = pr1.getBool('se');
  Widget begin;
  if (se == null || se == false) {
    begin = ExplanPages();
  } else {
    begin = MyApp();
  }

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Stripe.publishableKey =
      'pk_test_51Lue1FCGRVDJvz8akcSQPGcVMVKfJ6XFKVyQMuNi3vE8hyHSKhsjKIxzGAj0uHbTN0LiDuQ5bKzDeWwlh096pwDt00luIpEaLT';

  await Stripe.instance.applySettings();

  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      debugShowMaterialGrid: false,
      home: begin));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: product()),
        ChangeNotifierProvider.value(value: ProviderAuth()),
        ChangeNotifierProxyProvider<ProviderAuth, ProviderProduct>(
            create: (_) => ProviderProduct(),
            update: (context, value, object) => object
              ..getdata(value.t, value.usId, object.items == null ? [] : object.items)),
      ],
      child: Consumer<ProviderAuth>(
        builder: (ctx, value, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          debugShowMaterialGrid: false,
          home: value.Auth
              ? ProductScreen()
              : FutureBuilder(
                  future: value.tryautlogin(),
                  builder: (ctx, snapshot) {
                    return snapshot.connectionState == ConnectionState.waiting
                        ? SplashScreen()
                        : AuthScreen();
                  }),
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
