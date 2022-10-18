/* import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../firebase_options.dart';
import 'AUTHPRO.dart';
import 'AUTHSCR.dart';
import 'package:provider/provider.dart';
import 'mocky.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  void x() {}
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AUTHPRO()),
      ],
      child: Consumer<AUTHPRO>(
        builder: (ctx, value, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          debugShowMaterialGrid: false,
          home: value.Auth1 ? mocky() : AuthScreenTask(),
        ),
      ),
    );
  }
}
 */