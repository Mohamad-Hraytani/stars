/* import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'AUTHPRO.dart';

class mocky extends StatefulWidget {
  @override
  State<mocky> createState() => _mockyState();
}

class _mockyState extends State<mocky> {
  List<Map> Listte = [];

  Future<void> fetch() async {
    final n = Uri.parse(
        "https://run.mocky.io/v3/d8bd4178-c18b-4087-ab11-9e2ce85aaf29");

    var res0 = await http.get(n);
    var res = jsonDecode(res0.body);
    /* // للتاكد فقط
     var res = {
      "problems": [
        {
          "Diabetes": [
            {
              "medications": [
                {
                  "medicationsClasses": [
                    {
                      "className": [
                        {
                          "associatedDrug": [
                            {
                              "name": "asprin",
                              "dose": "dose1",
                              "strength": "500 mg"
                            }
                          ],
                          "associatedDrug#2": [
                            {
                              "name": "somethingElse",
                              "dose": "dose2",
                              "strength": "500 mg"
                            }
                          ]
                        }
                      ],
                      "className2": [
                        {
                          "associatedDrug": [
                            {
                              "name": "asprin",
                              "dose": "dose3",
                              "strength": "500 mg"
                            }
                          ],
                          "associatedDrug#2": [
                            {
                              "name": "somethingElse",
                              "dose": "dose4",
                              "strength": "500 mg"
                            }
                          ]
                        }
                      ]
                    }
                  ]
                }
              ],
              "labs": [
                {"missing_field": "missing_value"}
              ]
            }
          ],
          "Asthma": [{}]
        }
      ]
    }; */

    var name0 = res["problems"][0]["Diabetes"][0]["medications"][0]
        ["medicationsClasses"][0];

    var name1 =
        name0["className"][0]["associatedDrug"][0] as Map<String, dynamic>;

    var name2 =
        name0["className"][0]["associatedDrug#2"][0] as Map<String, dynamic>;

    var name3 =
        name0["className2"][0]["associatedDrug"][0] as Map<String, dynamic>;

    var name4 =
        name0["className2"][0]["associatedDrug#2"][0] as Map<String, dynamic>;

    List<Map> L = [name1, name2, name3, name4];
    setState(() {
      Listte = L;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<AUTHPRO>(context, listen: false).longout();
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.shopping_cart,
            color: Colors.red,
          ),
          onPressed: () async => await fetch()),
      body: Stack(
        children: [
          ListView(
              children: Listte == null
                  ? []
                  : Listte.map((e) => ListTile(
                        title: Text('${e['name']}'),
                        subtitle: Text('${e['dose']} \t&& ${e["strength"]}  '),
                      )).toList()),
          Align(
            alignment: Alignment(-0.5, 0.85),
            child: Row(
              children: [
                Text(
                  'Clice to show medications',
                  style: TextStyle(fontSize: 20),
                ),
                Icon(Icons.subdirectory_arrow_right_outlined)
              ],
            ),
          )
        ],
      ),
    );
  }
}
 */