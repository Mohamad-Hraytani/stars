/* import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as Path;
import 'package:stars/%D9%8DSliver.dart';
import 'package:stars/Api.dart';
import 'package:stars/Artic.dart';
import 'dart:async';

import 'package:stars/firebase_auth.dart';

class test2 extends StatefulWidget {
  @override
  _test2State createState() => _test2State();
}

class _test2State extends State<test2> {
  auc a1 = new auc();
  Api newapi = Api();
  List<Artic> aa = [];
  int page = 5;
  int cupage = 1;
  bool loding = true;
  ScrollController co = ScrollController();
  /*  Text n = Text(
    '..Clice to More',
    style: TextStyle(color: Colors.black),
  ); */
  @override
  void initState() {
    super.initState();

    newapi.fetch(cupage).then((snapshot) {
      aa.addAll(snapshot);
      setState(() {
        loding = false;
        if (cupage != page) cupage++;
      });
    });

    co.addListener(() {
      // حتى يرصدو لما بوصل ل اخر الصفحة
      if (co.position.pixels == co.position.maxScrollExtent) {
        newapi.fetch(cupage).then((snapshot) {
          // عم يرجع يكرر يلي فوق
          aa.addAll(snapshot);
          setState(() {
            loding = false;
            if (cupage != page) cupage++;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 1,
          title: Text(
            'New News',
            textAlign: TextAlign.center,
          ),
        ),
        body: Container(
          child: loding
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  controller: co,
                  itemCount: aa.length +
                      1, // ضفنا واحد مشان نحط دائرة انتظار عند اخر عنصر
                  itemBuilder: (BuildContext context, position) {
                    if (position == aa.length) {
                      // اذا وصل لقبل الاخير حط دائرة انتظار
                      return Center(child: CircularProgressIndicator());
                    }
                    return Container(
                        height: 400,
                        width: 400,
                        decoration: BoxDecoration(

                            /*  gradient: LinearGradient(
                                colors: [Colors.purple, Colors.white]), */
                            borderRadius: BorderRadius.circular(2)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.save,
                                    size: 25,
                                  ),
                                ),
                                Row(
                                  children: [
                                    m(position),
                                    Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.blue, width: 4),
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  aa[position].urlToImage),
                                              fit: BoxFit.cover)),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () => {},
                              child: Column(
                                children: [
                                  Text(
                                    aa[position].title,
                                    textAlign: TextAlign.left,
                                  ),
                                  // n
                                ],
                              ),
                            ),
                            if (aa[position].urlToImage != null)
                              InkWell(
                                onTap: () => {},
                                child: Container(
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                        Colors.yellow,
                                        Colors.green
                                      ]),
                                      borderRadius: BorderRadius.circular(2)),
                                  height: 200,
                                  width: 500,
                                  child: Image.network(
                                    aa[position].urlToImage,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            else
                              SizedBox(
                                height: 10,
                              ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    Text('Comment'),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.comment),
                                    ),
                                  ],
                                ),
                                IconButton(
                                    onPressed: () async {},
                                    icon: Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                      size: 35,
                                    )),
                              ],
                            ),
                            Container(
                              height: 2,
                              color: Colors.black,
                              child: Container(
                                color: Colors.black,
                              ),
                            )
                            /*  InkWell(
                              onTap: () {},
                              child: Container(
                                  height: 50,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(25),
                                        bottomRight: Radius.circular(25),
                                      ))),
                            ) */
                          ],
                        ));

                    /* return Card(
                    child: ListTile(
                      title: m(position),
                      leading: Image.network(aa[position].urlToImage),
                    ),
                  );

 */

/* CustomScrollView(//صورة قابلة للرفع لفوق وتحتا شغلات
                    slivers: <Widget>[
                    SliverAppBar(
                      expandedHeight: 300.0, // طولا
                      floating: true,
                      pinned: true, // موجود apparبس نزلت لتحت ببقى ال
                      flexibleSpace: FlexibleSpaceBar(
                        background: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(aa[0].urlToImage),
                                  fit: BoxFit.contain)),
                          child: m(0),
                        ),
                      ),
                    ),
                  ])
 */
                  },
                ),
        ));
  }

  Widget m(int a) {
    String his1;
    String his2;
    int o = 0;

    if (aa[a].author == null)
      return Text('data1');
    else {
      his1 = aa[a].publishedAt.substring(11, 13);
      print(his1);
      o = int.parse(his1);
      if (o > 12) {
        o = o - 12;
        his2 = 'PM';
      } else {
        his2 = 'AM';
      }
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            aa[a].author.length > 21
                ? aa[a].author.substring(0, 21) +
                    '\n' +
                    aa[a].author.substring(21, aa[a].author.length)
                : aa[a].author,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          Text(
            aa[a].publishedAt.substring(0, 9),
            style: TextStyle(
              fontSize: 15,
            ),
            textAlign: TextAlign.left,
          ),
          Text(
            '${o.toString()}' + aa[a].publishedAt.substring(13, 19) + his2,
            style: TextStyle(
              fontSize: 13,
            ),
            textAlign: TextAlign.left,
          ),
        ],
      );
    }
  }

  void go(int a) {
    Artic b = aa[a];

    Navigator.of(context).pop();
    Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext context) => new Sl(b)));
  }
}
 */