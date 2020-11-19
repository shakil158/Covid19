import 'package:flutter/material.dart';

class CountryPanel extends StatelessWidget {

  final Map countryData;

  const CountryPanel({Key key, this.countryData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      child: GridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 2),
        children: <Widget>[
          StatusPanel(
            title: 'CONFIRMED',
            panelColor: Colors.grey,
            textColor: Colors.black,
            count: countryData['cases'].toString(),
            todaycount: '('+'+'+countryData['todayCases'].toString()+')',
          ),

          StatusPanel(
            title: 'ACTIVE',
            panelColor: Colors.orange[100],
            textColor: Colors.orange[800],
            count: countryData['active'].toString(),
            todaycount: '('+'+'+countryData['todayCases'].toString()+')',
          ),

          StatusPanel(
            title: 'RECOVERED',
            panelColor: Colors.green[100],
            textColor: Colors.green[900],
            count: countryData['recovered'].toString(),
            todaycount: '('+'+'+countryData['todayRecovered'].toString()+')',
          ),

          StatusPanel(
            title: 'DEATHS',
            panelColor: Colors.red[100],
            textColor: Colors.red[900],
            count: countryData['deaths'].toString(),
            todaycount: '('+'+'+countryData['todayDeaths'].toString()+')',
          ),

        ],
      ),
    );
  }
}

class StatusPanel extends StatelessWidget {

  final Color panelColor;
  final Color textColor;
  final String title;
  final String count;
  final String todaycount;

  const StatusPanel({Key key, this.panelColor, this.textColor, this.title, this.count,this.todaycount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.all(10),
      height: 80.0,
      width: width/2,
      color: panelColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: textColor,
            ),
          ),
          SizedBox(height: 4.0,),
          Text(count,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.6,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 4.0,),
          Text(todaycount,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.6,
              fontSize: 14,
            ),
          )

        ],
      ),
    );
  }
}

