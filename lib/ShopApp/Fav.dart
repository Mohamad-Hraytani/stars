import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stars/ShopApp/ProviderAuth.dart';
import 'package:stars/ShopApp/ProviderProduct.dart';

import 'ProductScreen.dart';

class Fav extends StatefulWidget {
  Function getMyCard;
  Fav(this.getMyCard);
  @override
  State<Fav> createState() => _FavState();
}

class _FavState extends State<Fav> {
  @override
  Widget build(BuildContext context) {
    final item = Provider.of<ProviderProduct>(context).items;
    final List<product> itemfav =
        item.where((element) => element.isfav == true).toList();
    var Auh = Provider.of<ProviderAuth>(context, listen: false);
    return Scaffold(
      /*  floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.shopping_cart,
            color: Colors.red,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          }), */
      body: ListView.builder(
          itemCount: itemfav.length,
          itemBuilder: (ctx, i) => ChangeNotifierProvider<product>.value(
              value: itemfav[i],
              child: Consumer<product>(
                builder: (ctx, currentproduct, _) => LayoutBuilder(
                  builder: (ctx, constraints) => Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                                width: 3,
                                color: Colors.purple,
                                style: BorderStyle.solid)),
                        width: constraints.maxWidth * 0.3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          child: FadeInImage(
                            alignment: Alignment.topCenter,
                            height: 110,
                            placeholder: AssetImage('lib/img/ballon.png'),
                            image: NetworkImage(
                              currentproduct.image,
                              scale: 1,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        width: constraints.maxWidth * 0.5,
                        child: Dismissible(
                          key: Key(currentproduct.id),
                          onDismissed: (DismissDirection inm) {
                            currentproduct.updatefav(Auh.t, Auh.usId);
                            setState(() {
                              itemfav.remove(currentproduct);
                            });
                            Scaffold.of(context).showSnackBar(SnackBar(
                              action: SnackBarAction(
                                label: 'Undo delete',
                                onPressed: () async {
                                  await currentproduct.updatefav(
                                      Auh.t, Auh.usId);
                                  setState(() {
                                    itemfav.insert(i, currentproduct);
                                  });
                                },
                              ),
                              content: Text(
                                'Are you sure you want to remove this item from your favourites ?',
                                style: TextStyle(color: Colors.white),
                              ),
                            ));
                          },
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerLeft,
                            child: Icon(Icons.delete),
                          ),
                          child: ListTile(
                            title: Text('${currentproduct.title}'),
                            subtitle: Text('${currentproduct.price}'),
                            leading: IconButton(
                              icon: Icon(
                                Icons.highlight_remove_rounded,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                currentproduct.updatefav(Auh.t, Auh.usId);
                                setState(() {
                                  itemfav.remove(currentproduct);
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: constraints.maxWidth * 0.2,
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                              spreadRadius: 0,
                              blurRadius: 50, // نصف قطر الظل
                              color: Colors.purple.withOpacity(0.4),
                              offset: Offset(1, 2)),
                        ]),
                        child: IconButton(
                          iconSize: 50,
                          icon: Icon(Icons.shopping_cart),
                          color: currentproduct.getincard == null
                              ? Colors.white
                              : currentproduct.getincard == true
                                  ? Colors.yellow
                                  : Colors.white,
                          onPressed: () {
                            print(currentproduct.getincard);
                            currentproduct.updatecard(Auh.t, Auh.usId);

                            widget.getMyCard();
                          },
                        ),
                      )
                    ],
                  ),
                ),

//trailing: ,
              ))),
    );
  }
}
