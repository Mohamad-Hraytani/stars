import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ShopApp/AuthScreen.dart';
import 'ShopApp/Explanepages.dart';
import 'ShopApp/ProviderProduct.dart';
import 'ShopApp/ProviderAuth.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'ShopApp/ProductScreen.dart';

import 'package:flutter_stripe/flutter_stripe.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pr1 = await SharedPreferences.getInstance();

  var se = pr1.getBool('se');
  Widget scre;
  if (se == null || se == false) {
    scre = ExplanPage();
  } else {
    scre = MyApp();
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
      home: scre));
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
            update: (context, value, pp) => pp
              ..getdata(value.t, value.usId, pp.items == null ? [] : pp.items)),
      ],
      child: Consumer<ProviderAuth>(
        builder: (ctx, value, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
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
