import 'dart:convert';
import 'package:covid_app/pages/faq.dart';
import 'package:covid_app/panels/countrypage.dart';
import 'package:covid_app/panels/countrypanel.dart';
import 'package:covid_app/panels/statewise.dart';
import 'package:covid_app/panels/worldwidepanel.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:covid_app/datasource.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:date_time_format/date_time_format.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  Map worldData,countryData;
  String timing;


   fetchData() async {

    http.Response response = await http.get('https://corona.lmao.ninja/v3/covid-19/all');
    http.Response response1 = await http.get('https://corona.lmao.ninja/v3/covid-19/countries/india');
    final datetime = DateTime.now();
    setState(() {
      timing = DateTimeFormat.format(datetime,format: DateTimeFormats.american);
      worldData = json.decode(response.body);
      countryData = json.decode(response1.body);

    });
  }

  Future<void> updateData() async {
     fetchData();
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    //print(DateTime.now());
    return Scaffold(
      drawer: Drawer(
        child : Container(
          color: primaryBlack,
          child: ListView(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: ListTile(
                  title: Text('Home',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward,
                    color: Colors.white,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>FAQ()));
                },
                child: ListTile(
                  title: Text('FAQ',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward,
                    color: Colors.white,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  launch('https://www.who.int/emergencies/diseases/novel-coronavirus-2019/donate');
                },
                child: ListTile(
                  title: Text('Donate',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward,
                    color: Colors.white,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  launch('https://www.who.int/emergencies/diseases/novel-coronavirus-2019/advice-for-public/myth-busters');
                },
                child: ListTile(
                  title: Text('Myth Busters',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        )
        ),
      appBar: AppBar(
        title: Text('COVID-19 TRACKER'),
        centerTitle: true,
      ),
      body: worldData == null || countryData==null || timing==null ? Center(child: CircularProgressIndicator()):DoubleBackToCloseApp(
        snackBar: const SnackBar(content: Text('Press back again to exit'),duration: Duration(milliseconds: 900),),
        child: RefreshIndicator(
          strokeWidth: 3.0,
          color: Colors.deepPurple,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('WORLDWIDE',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CountryPage()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: primaryBlack,
                            borderRadius: BorderRadius.circular(10.0)
                          ),
                          padding: EdgeInsets.all(10.0),
                          child: Text('Country Wise Stats',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                WorldWidePanel(worldData : worldData),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('INDIA',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => StateWise()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: primaryBlack,
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                          padding: EdgeInsets.all(10.0),
                          child: Text('State Wise Stats',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
               countryData == null ? Container():CountryPanel(countryData: countryData,),
                Container(
                  child: Center(child: Text('Pull to update',
                    style: TextStyle(
                      //fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                  )),
                ),
                SizedBox(height: 11.0,),

                Container(
                 child: Center(child: Text('Last Updated : ' + timing,
                 style: TextStyle(
                   fontWeight: FontWeight.bold,
                   fontSize: 15.0,
                 ),
                 )),
               ),


              ],
            ),
          ),
          onRefresh: updateData,
        ),
      ),
    );
  }
}
