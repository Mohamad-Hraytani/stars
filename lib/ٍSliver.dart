/* import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stars/Artic.dart';
import 'package:stars/test2.dart';

class Sl extends StatefulWidget {
  Artic b;
  Sl(this.b);
  @override
  _SlState createState() => _SlState(this.b);
}

class _SlState extends State<Sl> {
  Artic b;
  _SlState(this.b);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(b.description.length.floorToDouble());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('mmh',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white)),
        ),
        backgroundColor: Colors.black,
      ),
      body: CustomScrollView(
        //صورة قابلة للرفع لفوق وتحتا شغلات
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300.0, // طولا
            floating: true,
            pinned: true, // موجود apparبس نزلت لتحت ببقى ال
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(b.urlToImage),
                        fit: BoxFit.contain)),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        b.author,
                        style: TextStyle(
                          fontSize: 30,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                ),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate((context, position) {
/* if (position == 0) {
              return Container(
                height: 500,
                color: Colors.green,
              );
            } else {
              return Container(
                height: 250,
                color: Colors.yellow,
              ); 
            } */
            return Container(
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    height: 300,
                    child: Text(
                      b.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: (b.description.length.floorToDouble() * 2),
                    child: Text(
                      b.description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 300,
                    child: Text(
                      b.content,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 300,
                    child: Text(
                      b.url,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FlatButton(
                      onPressed: () => {
                            Navigator.of(context).pop(),
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        new test2()))
                          },
                      textColor: Colors.green,
                      color: Colors.yellow,
                      child: Text('bake')),
                ],
              ),
            );
          }, childCount: 1))
        ],
      ),
    );
  }
}
 */