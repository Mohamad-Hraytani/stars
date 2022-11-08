import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stars/ShopApp/ProviderAuth.dart';
import 'package:stars/ShopApp/ProviderProduct.dart';
import 'package:image_picker/image_picker.dart';

class ADDItem extends StatefulWidget {
  @override
  State<ADDItem> createState() => _ADDItemState();
}

class _ADDItemState extends State<ADDItem> {
  var t1 = TextEditingController();
  var t2 = TextEditingController();
  var t3 = TextEditingController();
  var t4 = TextEditingController();
  var t5 = TextEditingController();

  void initState() {
    super.initState();
    t5.text = 'text.t4';
  }

  final one = FocusNode();
  final two = FocusNode();
  final three = FocusNode();

  final GlobalKey<FormState> ke1 = GlobalKey();

  File f;
  var pic = ImagePicker();

  Future GetImagee(ImageSource type) async {
    final t = await pic.getImage(
        source: type,
        imageQuality: 100,
        maxWidth: double.infinity,
        maxHeight: double.infinity);
    setState(() {
      if (t != null) {
        f = File(t.path);
      } else
        print('object');
    });
  }

  var iscomplet = false;
  var isshow = false;
  @override
  Widget build(BuildContext context) {
    var Auh = Provider.of<ProviderAuth>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple.withOpacity(0.4),
          centerTitle: true,
          title: Text(
            'Just manegars can add items',
            style: TextStyle(fontSize: 15),
          ),
        ),
        body: Center(
          child: AnimatedContainer(
            duration: Duration(seconds: 1.5.toInt()),
            curve: Curves.linear,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.purple.withOpacity(0.4), Colors.white],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: [0, 0.8]),
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 5,
                      color: Colors.purple.withOpacity(0.4),
                      offset: Offset(1, iscomplet ? 50 : 0)),
                  BoxShadow(
                      blurRadius: 5,
                      color: Colors.purple.withOpacity(0.4),
                      offset: Offset(1, iscomplet ? 100 : 0)),
                ]),
            child: Form(
                key: ke1,
                child: SingleChildScrollView(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      isshow
                          ? iscomplet
                              ? CircularProgressIndicator(
                                  color: Colors.purple.withOpacity(0.4),
                                )
                              : Icon(
                                  Icons.check_circle_outlined,
                                  size: 50,
                                  color: Colors.green.shade200,
                                )
                          : Container(),
                      TextFormField(
                          controller: t1,
                          keyboardType: TextInputType.text,
                          style: TextStyle(),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.alternate_email_sharp),
                            contentPadding: EdgeInsets.all(5),
                            labelText: 'Titel',
                          ),
                          validator: (value) {
                            if (value.isEmpty || value.length < 3)
                              return 'Please Enter a correct value';
                            else
                              return null;
                          },
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(one);
                          }),
                      TextFormField(
                          controller: t2,
                          style: TextStyle(),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.security),
                            contentPadding: EdgeInsets.all(5),
                            labelText: 'Enter Your decreption',
                          ),
                          validator: (value) {
                            if (value.isEmpty || value.length < 10)
                              return 'Please Enter a correct value';
                            else
                              return null;
                          },
                          focusNode: one,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(two);
                          }),
                      TextFormField(
                          controller: t3,
                          keyboardType: TextInputType.text,
                          style: TextStyle(),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.security),
                            contentPadding: EdgeInsets.all(5),
                            labelText: 'Enter Your price',
                          ),
                          validator: (value) {
                            if (value.isEmpty || value.length < 2)
                              return 'Please Enter a correct value';
                            else if (!value.startsWith('\$'))
                              return 'Please Enter a price with \$';
                            else
                              return null;
                          },
                          focusNode: two,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(three);
                          }),
                      TextFormField(
                        //  initialValue: "t4.text",
                        controller: t4,
                        enabled: f == null ? true : false,
                        keyboardType: TextInputType.text,
                        style: TextStyle(),
                        decoration: InputDecoration(
                            suffixIcon: Container(
                              width: 96,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        GetImagee(ImageSource.camera);
                                      },
                                      icon: Icon(
                                        Icons.camera,
                                      )),
                                  IconButton(
                                    onPressed: () {
                                      GetImagee(ImageSource.gallery);
                                    },
                                    icon: Icon(Icons.photo),
                                  )
                                ],
                              ),
                            ),
                            prefixIcon: Icon(Icons.security),
                            contentPadding: EdgeInsets.all(5),
                            labelText: 'Enter your URL or Choose Image',
                            labelStyle: TextStyle(fontSize: 13)),
                        onSaved: (b) {
                          setState(() {
                            t4.text = b;
                          });
                        },
                        validator: (value) {
                          if (value.isEmpty)
                            return 'Please Enter a Right Url';
                          else
                            return null;
                        },
                        focusNode: three,
                        textInputAction: TextInputAction.next,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10),
                                bottomLeft: Radius.circular(30),
                                topRight: Radius.circular(30))),
                        child: FlatButton(
                            child: Text('Add Item'),
                            onPressed: () async {
                              setState(() {
                                iscomplet = true;
                                isshow = true;
                              });

                              ke1.currentState.save();
                              final ref = FirebaseStorage.instance
                                  .ref()
                                  .child('Item_image')
                                  .child(f.toString() + '.jpg');

                              await ref.putFile(
                                f,
                              );

                              var url1 = await ref.getDownloadURL();
                              print(url1);
                              setState(() {
                                f == null ? t4.text = t4.text : t4.text = url1;
                              });

                              print(t4.text);
                              if (ke1.currentState.validate())
                                Provider.of<ProviderProduct>(context,
                                        listen: false)
                                    .addT(product(
                                        title: t1.text,
                                        decreption: t2.text,
                                        price: t3.text,
                                        image: t4.text))
                                    .then((value) => setState(() {
                                          iscomplet = false;
                                        }));
                            }),
                      )
                    ]))),
          ),
        ));
  }
}
