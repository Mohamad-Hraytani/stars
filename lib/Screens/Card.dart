import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stars/Providers/Product.dart';
import 'package:stars/Providers/ProviderAuth.dart';
import 'package:stars/Providers/ProviderProduct.dart';

class Cardd extends StatefulWidget {

  Cardd();
  @override
  State<Cardd> createState() => _CarddState();
}

class _CarddState extends State<Cardd> {
  var total = 0;
  @override
  Widget build(BuildContext context) {
    final item = Provider.of<ProviderProduct>(context).items;
    final List<product> itemcard =
        item.where((element) => element.incard == true).toList();

    var Auh = Provider.of<ProviderAuth>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.withOpacity(0.6),
        centerTitle: true,
        title: Text(
            '\$${Provider.of<ProviderProduct>(context, listen: false).getsum()}'),
      ),
      body: ListView.builder(
          itemCount: itemcard.length,
          itemBuilder: (ctx, i) => ChangeNotifierProvider<product>.value(
              value: itemcard[i],
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
                            placeholder: AssetImage('lib/img/white.png'),
                            image: NetworkImage(
                              currentproduct.image,
                              scale: 1,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        width: constraints.maxWidth * 0.7,
                        child: Dismissible(
                          key: Key(currentproduct.id),
                          onDismissed: (DismissDirection inm) {
                            currentproduct.updatecard(Auh.t, Auh.usId);
                            setState(() {
                              itemcard.remove(currentproduct);
                            });
                            Provider.of<ProviderProduct>(context, listen: false).getNumberOfItemsInMyCard();
          

                             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              action: SnackBarAction(
                                label: 'Undo delete',
                                onPressed: () async {
                                  await currentproduct.updatecard(
                                      Auh.t, Auh.usId);
                                  setState(() {
                                    itemcard.insert(i, currentproduct);
                                  });
 Provider.of<ProviderProduct>(context, listen: false).getNumberOfItemsInMyCard();
 
                        
                                },
                              ),
                              content: Text(
                                'Are you sure you want to remove this item from your Card ?',
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
                                currentproduct.updatecard(Auh.t, Auh.usId);
                                setState(() {
                                  itemcard.remove(currentproduct);
                                });
          Provider.of<ProviderProduct>(context, listen: false).getNumberOfItemsInMyCard();

                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ))),
    );
  }
}
