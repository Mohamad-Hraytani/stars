import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stars/Providers/Product.dart';
import 'package:stars/Providers/ProviderProduct.dart';

class decreption extends StatefulWidget {
  product p;
  decreption(this.p);

  @override
  State<decreption> createState() => _decreptionState();
}

class _decreptionState extends State<decreption> {
  bool State_text_height = true;
  var numline = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
              backgroundColor: Colors.transparent,
              expandedHeight: 215.0,
              flexibleSpace: FlexibleSpaceBar(
                  background: FittedBox(
                fit: BoxFit.contain,
                child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 40,
                            color: Colors.pink,
                            offset: Offset(1, 50))
                      ],
                    ),
                    child: Image.network(
                      widget.p.image,
                      alignment: Alignment.center,
                      fit: BoxFit.contain,
                    )),
              ))),
          SliverList(
              delegate: SliverChildBuilderDelegate((context, position) {
            return Container(
              height: 600,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple.withOpacity(0.4), Colors.white],
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 200,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 30,
                              color: Colors.deepPurpleAccent.shade100,
                              offset: Offset(1, 10))
                        ],
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.pink.withOpacity(0.4),
                            Colors.white,
                          ],
                        ),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40))),
                    child: Text(
                      widget.p.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontSize: 40),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: State_text_height ? 130 : 400,
                    child: Text(
                      widget.p.decreption,
                      maxLines: numline,
                      style: TextStyle(
                        fontSize: 30,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  FlatButton(
                      onPressed: () => {
                            setState(() {
                              State_text_height = !State_text_height;
                              numline = 6;
                            })
                          },
                      textColor: Colors.blue,
                      child: Text(numline == 3 ? 'read more' : 'read less')),
                  Container(
                    width: 300,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 30,
                              color: Colors.deepPurpleAccent.shade100,
                              offset: Offset(1, 10))
                        ],
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.pink.withOpacity(0.4),
                            Colors.white,
                          ],
                        ),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))),
                    child: Text(
                      widget.p.price,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontSize: 40),
                    ),
                  ),
                ],
              ),
            );
          }, childCount: 1))
        ],
      ),
    );
  }

  bool useWhiteForeground(Color backgroundColor, {double bias = 0.0}) {
    int v = sqrt(pow(backgroundColor.red, 2) * 0.299 +
            pow(backgroundColor.green, 2) * 0.587 +
            pow(backgroundColor.blue, 2) * 0.114)
        .round();
    return v < 130 + bias ? true : false;
  }
}
