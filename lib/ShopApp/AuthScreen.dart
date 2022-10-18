import 'dart:convert';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stars/ShopApp/ProviderAuth.dart';
import 'package:http/http.dart' as http;

class AuthScreen extends StatefulWidget {
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var islood = true;
  final GlobalKey<FormState> ke = GlobalKey();
  final price = FocusNode();
  final confprice = FocusNode();
  var emailco = '';
  var passco = '';
  var conpassco = '';
  var islog = true;
  double b = -5.0;
  double n = 0.0;
  @override
  Widget build(BuildContext context) {
    print('object');
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              emailco = 'm.mhr@gmail.com';
              passco = '123456789';
              conpassco = '123456789';
            });
          },
        ),
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [Colors.purple.withOpacity(0.4), Colors.white],
            )),
            child: Center(
              child: AnimatedContainer(
                onEnd: () {
                  setState(() {
                    b = 0.0;
                    n = 0.0;
                  });
                },
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 1, // نصف قطر الظل
                        color: Colors.white,
                        offset:
                            Offset(1, n == 0 ? 0 : 50) // نقل الظل يمين او يسار
                        )
                  ],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                ),
                // انميشن نفس الكونتينر ولكن اي شي يتغير داخله يتم خلال مدة زمنية
                duration: Duration(seconds: 1.5.toInt()),
                curve: Curves.linear,
                height: islog ? 275 : 250,
                width: 320,
                alignment: islog ? Alignment(n, n) : Alignment(-b, b),
                child: Container(
                  padding: EdgeInsets.only(top: 10),
                  //    height: islog ? 275 : 250,
                  width: 300,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 1, // نصف قطر الظل
                            color: Colors.purple.withOpacity(0.4),
                            offset: Offset(1, 5) // نقل الظل يمين او يسار
                            )
                      ],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  child: Form(
                      key: ke,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextFormField(
                                //    key: ValueKey(emailco.text),
                                //    controller: emailco,
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(),
                                decoration: InputDecoration(
                                  suffixText: "@gmail.com",
                                  prefixIcon: Icon(Icons.alternate_email_sharp),
                                  contentPadding: EdgeInsets.all(5),
                                  labelText: 'Enter Your Email ',
                                ),
                                validator: (value) {
                                  if (value.isEmpty ||
                                      //    !value.contains('@') ||
                                      value.length < 5)
                                    return 'Please Enter a correct value';
                                  else
                                    return null;
                                },
                                onSaved: (b) async {
                                  emailco = b.toString();
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setString('email', b);
                                },

                                // initialValue: '',
                                textInputAction: TextInputAction
                                    .next, // اشارة الانتر بلكيبورد
                                onFieldSubmitted: (_) {
                                  //الحقل الذي سينتقل اليه عند الضغط على الانتر
                                  FocusScope.of(context)
                                      .requestFocus(price); // هو البرايس
                                }),
                            TextFormField(
                                //    key: ValueKey(passco.text),
                                //   controller: passco,
                                style: TextStyle(),
                                obscureText: true,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.security),
                                  contentPadding: EdgeInsets.all(5),
                                  labelText: 'Enter Your password',
                                ),
                                validator: (value) {
                                  if (value.isEmpty || value.length < 8)
                                    return 'Please Enter a correct value';
                                  else
                                    return null;
                                },
                                onSaved: (b) {
                                  passco = b.toString();
                                },
                                focusNode: price,
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(confprice);
                                }),
                            islog
                                ? TextFormField(
                                    //   key: ValueKey(conpassco.text + '2'),
                                    enabled: islog ? true : false,
                                    //    controller: conpassco,
                                    style: TextStyle(),
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.spellcheck_sharp),
                                      contentPadding: EdgeInsets.all(5),
                                      labelText: 'Enter Your same Password',
                                    ),
                                    validator: (value) {
                                      if (value != passco) {
                                        return 'your password is not corecct';
                                      }
                                      if (value.isEmpty || value.length < 8)
                                        return 'Please Enter a correct value';
                                      else
                                        return null;
                                    },
                                    focusNode: confprice,
                                  )
                                : Container(),

                            /* border: OutlineInputBorder(
                         borderSide: BorderSide(color: Colors.transparent)// لون الايطار تبع الفورم
                         borderRadius: BorderRadius.all(Radius.circular(50))), // لضيع اطار للشكل
                         enabledBorder: OutlineInputBorder(
                           borderRadius:BorderRadius.all(Radius.circular(50))),
                         focusedBorder: OutlineInputBorder(
                           borderRadius:BorderRadius.all(Radius.circular(50))),
                         disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                         focusColor: Colors.white,
                         fillColor: Colors.red,
                         filled: true ),*/
                            RaisedButton(
                              onPressed: () {
                                setState(() {
                                  islood = false;
                                });
                                ke.currentState.validate();
                                ke.currentState.save();
                                if (ke.currentState.validate()) {
                                  islog
                                      ? Provider.of<ProviderAuth>(context,
                                              listen: false)
                                          .signIn(emailco, passco, context)
                                          .then((value) => setState(() {
                                                islood = true;
                                              }))
                                      : Provider.of<ProviderAuth>(context,
                                              listen: false)
                                          .signUp(emailco, passco, context)
                                          .then((value) => setState(() {
                                                islood = true;
                                              }));
                                }
                              },
                              child: islog ? Text('SingIn') : Text('Regester'),
                            ),
                            islood
                                ? FlatButton(
                                    onPressed: () {
                                      setState(() {
                                        islog = !islog;
                                        n = -5.0;
                                        b = -5.0;
                                      });
                                    },
                                    child: islog
                                        ? Text('Create account')
                                        : Text('SingIn'),
                                  )
                                : CircularProgressIndicator()
                          ],
                        ),
                      )),
                ),
              ),
            )));
  }
}
