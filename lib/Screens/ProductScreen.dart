import 'dart:convert';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:stars/Providers/ProviderAuth.dart';
import 'package:stars/Providers/ProviderProduct.dart';
import 'package:stars/Screens/Card.dart';
import 'package:stars/Screens/decreption.dart';

import 'package:stars/services/payment.dart';

import 'Add.dart';
import 'Fav.dart';
import 'package:page_transition/page_transition.dart';

import 'Customfav.dart';


class ProductScreen extends StatefulWidget {
  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen>
    with TickerProviderStateMixin {
  Map<String, dynamic> paymentIntentData;
  bool islood = false;

  TabController tc;
  TabController tcmaneger;
  int indexPages = 2;
  int indexPagesManeger = 1;
  String Currently_Email;
  bool state_floatingActionButton = false;
  @override
  void initState() {
    super.initState();
   saveEmail().then((value) => 
    Provider.of<ProviderProduct>(context, listen: false)
        .fetchdata(value == 'm.mhr'? false  :true)
        .then((value) => Future.delayed(Duration(milliseconds: 1000), () {

              setState(() {
                islood = true;

                
              });


              Provider.of<ProviderProduct>(context, listen: false).getNumberOfItemsInMyCard();
          
            }))
   );
    tc = TabController(initialIndex: indexPages, length: 5, vsync: this);

    tcmaneger = TabController(initialIndex: indexPagesManeger, length: 3, vsync: this);
  }

  @override
  void dispose() async {
    super.dispose();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    islood = null;
  }

  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey1 = GlobalKey();
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey3 = GlobalKey();
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey4 = GlobalKey();
  @override
  Widget build(BuildContext context) {
    List<product> itemlist1 = Provider.of<ProviderProduct>(context).items;

    return Consumer<ProviderAuth>(
      builder: (context, ob_Auth, _) => Scaffold(
        appBar: AppBar(
          title: Currently_Email == 'm.mhr'
              ? Text('Hello Maneger')
              : Text('Welcome'),
          backgroundColor: Colors.purple.withOpacity(0.4),
          leading: IconButton(
              icon: Icon(
                Icons.exit_to_app,
              ),
              onPressed: () {
                ob_Auth.longout().then((_) => print(ob_Auth.Auth));
              }),
        ),
        floatingActionButton:
            Currently_Email == 'm.mhr' || tc.index == 0 
                ? null
                : FloatingActionButton(
                    backgroundColor: state_floatingActionButton
                        ? Colors.green.shade100
                        : Colors.purple.withOpacity(0.4),
                    onPressed: () async {
                      if (state_floatingActionButton == true) {
                        payment pay  = payment();
                         await pay.makePayment(context);
                   
                      } else {
                        Navigator.push(
                            context,
                            PageTransition(
                              ctx: context,
                              duration: Duration(seconds: 2),
                              child: ADDItem(),
                              type: PageTransitionType.theme,
                              childCurrent: ProductScreen(),
                              reverseDuration: Duration(seconds: 2),
                            ));
                      }
                    },
                    child: state_floatingActionButton
                        ? Icon(Icons.shopping_cart, size: 30)
                        : Icon(Icons.add_outlined),
                  ),
        bottomNavigationBar: bottombar(),
        body: Currently_Email == 'm.mhr'
            ? TabBarView(
                key: _bottomNavigationKey3,
                controller: tcmaneger,
                children: [
                  customfav(),
              refresh_and_showItem(itemlist1, false, ob_Auth),
                  ADDItem(),
                ],
              )
            : TabBarView(
                controller: tc,
                key: _bottomNavigationKey4,
                children: [
                  customfav(),
                  Fav(),
                  refresh_and_showItem(itemlist1, true, ob_Auth),
                  Cardd(),
                  refresh_and_showItem(itemlist1, false, ob_Auth)
                ],
              ),
      ),
    );
  }

  Future<String> saveEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  
    setState(() {
 Currently_Email = prefs.getString('email');
    });
    return Currently_Email;
  }

  bottombar() {
    if (Currently_Email == 'm.mhr') {
      return CurvedNavigationBar(
        index: indexPagesManeger,
        animationDuration: Duration(seconds: 1),
        backgroundColor: Colors.purple.withOpacity(0.4),
        key: _bottomNavigationKey1,
        items: <Widget>[
          Icon(Icons.color_lens, size: 30),
          Icon(Icons.all_inclusive_outlined, size: 30),
          Icon(Icons.add_outlined),
        ],
        letIndexChange: (index) {
          ChangeIndexmaneger(index);
          return true;
        },
        onTap: (index) {
          ChangeIndexmaneger(index);
        },
      );
    } else {
      return CurvedNavigationBar(
        index: indexPages,
        animationDuration: Duration(seconds: 1),
        backgroundColor: Colors.purple.withOpacity(0.4),
        key: _bottomNavigationKey,
        items: <Widget>[
          Icon(Icons.color_lens, size: 30),
          Icon(Icons.favorite, size: 30),
          Icon(Icons.home, size: 30),
          Consumer<ProviderProduct>(
            builder: (ctx, value, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  value.numitem > 0
                      ? Stack(alignment: Alignment.center, children: [
                          Align(
                            alignment: Alignment(0.5, 0),
                            child: Icon(
                              Icons.circle,
                              color: Colors.purple.withOpacity(0.4),
                              size: 30,
                            ),
                          ),
                          Align(
                            alignment: Alignment(0.399, -0.5),
                            child: Text(
                              '${value.numitem}',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ])
                      : Container(),
                  Icon(Icons.shopping_cart, size: 30),
                ],
              );
            },
          ),
          Icon(Icons.all_inclusive_outlined, size: 30),
        ],
        letIndexChange: (index) {
          ChangeIndex(index);
          return true;
        },
        onTap: (index) {
          ChangeIndex(index);
        },
      );
    }
  }

  void ChangeIndexmaneger(int index) {
    setState(() {
      indexPagesManeger = index;
      tcmaneger.index = index;
    });
  }

  void ChangeIndex(int index) {
    setState(() {
      indexPages = index;
      tc.index = index;
      state_floatingActionButton = false;

      if (index == 2) {
        Provider.of<ProviderProduct>(context, listen: false)
            .fetchdata(true)
            .then((value) => Future.delayed(Duration(milliseconds: 500), () {
                  setState(() {
                    islood = true;
                  });
                }));
      }
      if (index == 3) {
        setState(() {
          state_floatingActionButton = true;
        });
      }
      if (index == 4) {
        Provider.of<ProviderProduct>(context, listen: false)
            .fetchdata(false)
            .then((value) => Future.delayed(Duration(milliseconds: 500), () {
                  setState(() {
                    islood = true;
                  });
                }));
      }
    });
  }

  refresh_and_showItem(
      List<product> itemlist, bool state_filter, ProviderAuth ob_Auth) {
    return RefreshIndicator(
      backgroundColor: Colors.transparent,
      color: Colors.transparent,
      onRefresh: () async {
        setState(() {
          islood = false;
        });
        await Provider.of<ProviderProduct>(context, listen: false)
            .fetchdata(state_filter)
            .then((value) => setState(() {
                  islood = true;
                }));
      },
      child: islood
          ? GridView.builder(
              itemCount: itemlist.length,
              itemBuilder: (ctx, i) => ChangeNotifierProvider<product>.value(
                    value: itemlist[i],
                    child: Consumer<product>(builder: (ctx, currentproduct, _) {
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20))),
                        shadowColor: Colors.purple.withOpacity(0.4),
                        elevation: 20,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                  ctx: context,
                                  duration: Duration(seconds: 2),
                                  child: decreption(currentproduct),
                                  type: PageTransitionType.theme,
                                  childCurrent: ProductScreen(),
                                  reverseDuration: Duration(seconds: 2),
                                ));
                          },
                          child: Stack(
                            children: [
                              FadeInImage(
                                alignment: Alignment.topCenter,
                                height: 110,
                                width: double.infinity,
                                placeholder: AssetImage('lib/img/white.png'),
                                image: NetworkImage(currentproduct.image,
                                    scale: 1),
                                fit: BoxFit.cover,
                              ),
                              GridTile(
                                  child: Align(
                                      alignment: Alignment(0, 0.3),
                                      child: Text(currentproduct.title,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20))),
                                  footer: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20)),
                                    child: GridTileBar(
                                      backgroundColor:
                                          Colors.purple.withOpacity(0.4),
                                      leading: IconButton(
                                        icon: Icon(Icons.shopping_cart),
                                        color: currentproduct.getincard == null
                                            ? Colors.white
                                            : currentproduct.getincard == true
                                                ? Colors.yellow
                                                : Colors.white,
                                        onPressed: () {
                                          if (state_filter == false) {
                                            Provider.of<ProviderProduct>(
                                                    context,
                                                    listen: false)
                                                .updateuserID(
                                                    currentproduct.id);
                                          }
                                          print(currentproduct.getincard);
                                          currentproduct.updatecard(
                                              ob_Auth.t, ob_Auth.usId);
                                               Provider.of<ProviderProduct>(context, listen: false).getNumberOfItemsInMyCard();
                                  
                                        },
                                      ), 

                                      title: Text('${currentproduct.price}'),
                                      trailing: IconButton(
                                        icon: Icon(Icons.favorite),
                                        color: currentproduct.getisfav == null
                                            ? Colors.white
                                            : currentproduct.getisfav == true
                                                ? Colors.redAccent
                                                : Colors.white,
                                        onPressed: () {
                                          if (state_filter == false) {
                                            Provider.of<ProviderProduct>(
                                                    context,
                                                    listen: false)
                                                .updateuserID(
                                                    currentproduct.id);
                                          }

                                          print(currentproduct.getisfav);
                                          currentproduct.updatefav(
                                              ob_Auth.t, ob_Auth.usId);
                                        },
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
              scrollDirection: Axis.vertical,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                mainAxisExtent: 200,
                maxCrossAxisExtent: 185,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
              ))
          : Center(child: CircularProgressIndicator()),
    );
  }
}

