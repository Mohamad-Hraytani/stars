import 'dart:convert';
import 'dart:io';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stars/ShopApp/Add.dart';
import 'package:stars/ShopApp/Card.dart';
import 'package:stars/ShopApp/ProviderAuth.dart';
import 'package:stars/ShopApp/ProviderProduct.dart';
import 'package:stars/ShopApp/decreption.dart';
import 'Fav.dart';
import 'package:page_transition/page_transition.dart';

import 'cusfav.dart';

class ProductScreen extends StatefulWidget {
  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen>
    with SingleTickerProviderStateMixin {
  bool islood = false;
  var memoryemail;
  TabController tc;
  int _page = 2;
  var email_variabel;
  @override
  void initState() {
    super.initState();
    saveemail();
    Provider.of<ProviderProduct>(context, listen: false)
        .fetchdata(true)
        .then((value) => Future.delayed(Duration(milliseconds: 500), () {
              setState(() {
                islood = true;
              });
              getMyCard();
              saveemail();
            }));
    tc = TabController(initialIndex: _page, length: 5, vsync: this);
  }

  @override
  void dispose() async {
    super.dispose();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    islood = null;
  }

  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    List<product> itemlist1 = Provider.of<ProviderProduct>(context).items;

    return Consumer<ProviderAuth>(
      builder: (context, vu1, _) => Scaffold(
        appBar: AppBar(
          title: email_variabel == 'm.mhr@gmail.com'
              ? Text('Hello Maneger')
              : Text('Welcome'),
          backgroundColor: Colors.purple.withOpacity(0.4),
          leading: IconButton(
              icon: Icon(
                Icons.exit_to_app,
              ),
              onPressed: () {
                vu1.longout().then((_) => print(vu1.Auth));
              }),
          actions: [
            /*   PopupMenuButton<pop>(onSelected: (pop po) {
              if (po == pop.additem) {
                Provider.of<ProviderProduct>(context, listen: false)
                    .addautoitem()
                    .then((value) {
                  setState(() {
                    islood = false;
                  });
                  Provider.of<ProviderProduct>(context, listen: false)
                      .fetchdata(true)
                      .then((value) => setState(() {
                            islood = true;
                          }));
                });
              } else if (po == pop.Logout) {
                vu1.longout().then((_) => print(vu1.Auth));
              } else
                Navigator.push(
                    context,
                    PageTransition(
                      ctx: context,
                      duration: Duration(seconds: 2),
                      child: custemfav(),
                      type: PageTransitionType.theme,
                      childCurrent: ProductScreen(),
                      reverseDuration: Duration(seconds: 2),
                    ));
            }, itemBuilder: (_) {
              return [
                PopupMenuItem<pop>(
                    value: pop.additem, child: Text(memoryemail)),
                PopupMenuItem<pop>(value: pop.Logout, child: Text('Logout')),
                PopupMenuItem<pop>(
                    value: pop.Painting, child: Text('Painting')),
              ];
            }) */
          ],
        ),
        floatingActionButton: email_variabel == 'm.mhr@gmail.com'
            ? FloatingActionButton(
                backgroundColor: Colors.purple.withOpacity(0.4),
                onPressed: () {
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
                },
                child: Icon(Icons.add_outlined),
              )
            : null,
        bottomNavigationBar: bottombar(),
        body: TabBarView(
          controller: tc,
          children: [
            custemfav(),
            Fav(getMyCard),
            refresh_and_showItem(itemlist1, true, vu1),
            Cardd(getMyCard),
            refresh_and_showItem(itemlist1, false, vu1)
          ],
        ),
      ),
    );
  }

  Future<void> saveemail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email_variabel = prefs.getString('email');
    setState(() {
      if (email_variabel == 'm.mhr@gmail.com') {
        memoryemail = 'addItem';
        email_variabel = email_variabel;
      } else {
        memoryemail = 'showItem';
        email_variabel = email_variabel;
      }
    });
  }

  bottombar() {
    return CurvedNavigationBar(
      index: _page,
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
                          //  heightFactor: 0,
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
        IndexChange(index);
        return true;
      },
      onTap: (index) {
        IndexChange(index);
      },
    );
  }

  void IndexChange(int index) {
    setState(() {
      _page = index;
      tc.index = index;
      if (index == 2) {
        Provider.of<ProviderProduct>(context, listen: false)
            .fetchdata(true)
            .then((value) => Future.delayed(Duration(milliseconds: 500), () {
                  setState(() {
                    islood = true;
                  });
                }));
      }

      if (index == 4) {
        Provider.of<ProviderProduct>(context, listen: false)
            .fetchdata(false)
            .then((value) => Future.delayed(
                    // تنفيذ هذا الكود بعد فترة معينة
                    Duration(milliseconds: 500), () {
                  setState(() {
                    islood = true;
                  });
                }));
      }
    });
  }

  refresh_and_showItem(
      List<product> itemlist, bool state_filter, ProviderAuth vu) {
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
                                placeholder: AssetImage('lib/img/ballon.png'),
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
                                              vu.t, vu.usId);
                                          getMyCard();
                                        },
                                      ), // يسار

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
                                              vu.t, vu.usId);
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
                mainAxisExtent: 200, //ارتفاع كل عنصر
                maxCrossAxisExtent: 185, // عرض كل عنصر
                mainAxisSpacing: 15, //البعد بين العناصر بلطول
                crossAxisSpacing: 15, // البعد بين العناصر بالعضر
              ))
          : Center(child: CircularProgressIndicator()),
    );
  }

  void getMyCard() {
    List<product> itemlist0 =
        Provider.of<ProviderProduct>(context, listen: false).items;
    List<product> itemcard =
        itemlist0.where((element) => element.incard == true).toList();
    Provider.of<ProviderProduct>(context, listen: false)
        .setnumitem(itemcard.length);
  }
}

enum pop { additem, Logout, Painting }
