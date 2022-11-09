import 'dart:convert';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:flutter_stripe/flutter_stripe.dart' as prefix;
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
import 'package:http/http.dart' as http;

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
  int _page = 2;
  int _page1 = 1;
  var email_variabel;
  bool flo = false;
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

    tcmaneger = TabController(initialIndex: _page1, length: 3, vsync: this);
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
      builder: (context, vu1, _) => Scaffold(
        appBar: AppBar(
          title: email_variabel == 'm.mhr'
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
          actions: [],
        ),
        floatingActionButton: email_variabel == 'm.mhr'
            ? null
            : FloatingActionButton(
                backgroundColor: flo
                    ? Colors.green.shade100
                    : Colors.purple.withOpacity(0.4),
                onPressed: () async {
                  if (flo == true) {
                    await makePayment();
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
                child: flo
                    ? Icon(Icons.shopping_cart, size: 30)
                    : Icon(Icons.add_outlined),
              ),
        bottomNavigationBar: bottombar(),
        body: email_variabel == 'm.mhr'
            ? TabBarView(
                key: _bottomNavigationKey3,
                controller: tcmaneger,
                children: [
                  ADDItem(),
                  refresh_and_showItem(itemlist1, false, vu1),
                  custemfav(),
                ],
              )
            : TabBarView(
                controller: tc,
                key: _bottomNavigationKey4,
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
      if (email_variabel == 'm.mhr') {
        email_variabel = email_variabel;
      } else {
        email_variabel = email_variabel;
      }
    });
  }

  bottombar() {
    if (email_variabel == 'm.mhr') {
      return CurvedNavigationBar(
        index: _page1,
        animationDuration: Duration(seconds: 1),
        backgroundColor: Colors.purple.withOpacity(0.4),
        key: _bottomNavigationKey1,
        items: <Widget>[
          Icon(Icons.add_outlined),
          Icon(Icons.all_inclusive_outlined, size: 30),
          Icon(Icons.color_lens, size: 30),
        ],
        letIndexChange: (index) {
          IndexChange1(index);
          return true;
        },
        onTap: (index) {
          IndexChange1(index);
        },
      );
    } else {
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
  }

  void IndexChange1(int index) {
    setState(() {
      _page1 = index;
      tcmaneger.index = index;
    });
  }

  void IndexChange(int index) {
    setState(() {
      _page = index;
      tc.index = index;
      flo = false;

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
          flo = true;
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
                mainAxisExtent: 200,
                maxCrossAxisExtent: 185,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
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

  Future<void> makePayment() async {
    try {
      int price = Provider.of<ProviderProduct>(context, listen: false).getsum();
      paymentIntentData = await createPaymentIntent(price.toString(), 'USD');
      await prefix.Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: prefix.SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntentData['client_secret'],
                  applePay: true,
                  googlePay: true,
                  testEnv: true,
                  style: ThemeMode.dark,
                  merchantCountryCode: 'US',
                  merchantDisplayName: 'ANNIE'))
          .then((value) {});
      displayPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet() async {
    try {
      await prefix.Stripe.instance
          .presentPaymentSheet(
              parameters: prefix.PresentPaymentSheetParameters(
        clientSecret: paymentIntentData['client_secret'],
        confirmPayment: true,
      ))
          .then((newValue) {
        print('payment intent' + paymentIntentData['id'].toString());
        print('payment intent' + paymentIntentData['client_secret'].toString());
        print('payment intent' + paymentIntentData['amount'].toString());
        print('payment intent' + paymentIntentData.toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("paid successfully")));

        paymentIntentData = null;
      }).onError((error, stackTrace) {
        print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
      });
    } on prefix.StripeException catch (e) {
      print('Exception/DISPLAYPAYMENTSHEET==> $e');
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {
      print('$e');
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      print(body);
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51Lue1FCGRVDJvz8aQRgiV6Scjs2J4y9yGVmDBDQiGWXApYhgQ7S6RE0z1cAJPMk0yMCmnDEQuXPZWQrqF9QiM5HN00zoc3qKMi',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print('Create Intent reponse ===> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
}

enum pop { additem, Logout, Painting }
