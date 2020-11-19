import 'package:covid_app/pages/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CountryPage extends StatefulWidget {
  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {

  List countryData;
  fetchData() async {
    http.Response response = await http.get('https://corona.lmao.ninja/v3/covid-19/countries');
    setState(() {
      countryData = json.decode(response.body);
    });
  }

  Future<void> updateData() async {
    fetchData();
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          countryData==null?Text(''):IconButton(icon: Icon(Icons.search), onPressed: () {
            showSearch(context: context ,delegate: SearchResults(countryData));
          },)
        ],
        centerTitle: true,
        title: Text('COUNTRY STATS',
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
        ),
      ),
      body: countryData==null? Center(child: CircularProgressIndicator()):RefreshIndicator(
        strokeWidth: 3.0,
        color: Colors.deepPurple,
        child: ListView.builder(
            itemCount: countryData==null ? 0 : countryData.length,
            itemBuilder: (context,index) {
          return Container(
            height: 150,
            margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              boxShadow: [
                BoxShadow(color: Colors.grey[500],blurRadius: 10,offset: Offset(0,10)),
              ]
            ),
            child: Row(
             // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                 Expanded(
                   child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                          Text(countryData[index]['country'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                          ),
                        SizedBox(height: 13.0,),
                        Image.network(countryData[index]['countryInfo']['flag'],
                        height: 65,
                        width: 65,
                        ),
                      ],
                    ),
                ),
                 ),
                Expanded(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('CONFIRMED: ' + countryData[index]['cases'].toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 15.0,
                        ),
                        ),
                        SizedBox(height: 3),

                        Text('ACTIVE: ' + countryData[index]['active'].toString(),
                          style: TextStyle(
                          fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            color: Colors.orange[800],
                        ),
                        ),
                        SizedBox(height: 3),


                        Text('RECOVERED: ' + countryData[index]['recovered'].toString(),
                          style: TextStyle(
                          fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            color: Colors.green,
                        ),
                        ),
                        SizedBox(height: 3),


                        Text('DEATHS: ' + countryData[index]['deaths'].toString(),
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
