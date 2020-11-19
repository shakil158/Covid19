import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class StateWise extends StatefulWidget {
  @override
  _StateWiseState createState() => _StateWiseState();
}


class _StateWiseState extends State<StateWise> {

  List stateData;
  Map data;
  fetchStateData() async {
    http.Response response = await http.get('https://api.covid19india.org/data.json');
    setState(() {
      data=json.decode(response.body);
      stateData=data['statewise'];
    });
}

  Future<void> updateData() async {
    fetchStateData();
  }

  @override
  void initState() {
    print('hello');
    super.initState();
    fetchStateData();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('STATE STATS',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: stateData==null? Center(child: CircularProgressIndicator()):RefreshIndicator(
        strokeWidth: 3.0,
        color: Colors.deepPurple,
        child: ListView.builder(
            itemCount: stateData==null ? 0 : stateData.length,
            itemBuilder: (context,index) {
              return Container(
               // width: width/2,
                height: 150,
                margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    boxShadow: [
                      BoxShadow(color: Colors.grey[500],blurRadius: 10,offset: Offset(0,10)),
                    ]
                ),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(stateData[index]['state'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                            //SizedBox(height: 13.0,),

                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text('CONFIRMED: ' + stateData[index]['confirmed'].toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 15.0,
                              ),
                            ),
                            SizedBox(height: 3),

                            Text('ACTIVE: ' + stateData[index]['active'].toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                                color: Colors.orange[800],
                              ),
                            ),
                            SizedBox(height: 3),


                            Text('RECOVERED: ' + stateData[index]['recovered'].toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                                color: Colors.green,
                              ),
                            ),
                            SizedBox(height: 3),


                            Text('DEATHS: ' + stateData[index]['deaths'].toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                                color: Colors.red,
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
        onRefresh: updateData,
      ),
    );
  }
}


