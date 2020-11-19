import 'package:covid_app/datasource.dart';
import 'package:flutter/material.dart';

class FAQ extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('FAQ SECTION',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
        ),
      ),
      body: ListView.builder(
          itemCount: DataSource.questionAnswers.length,
          itemBuilder: (context,index) {
        return ExpansionTile(
          title: Text(DataSource.questionAnswers[index]['question'],
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
          color: Colors.blueAccent,
        ),
        ),children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(DataSource.questionAnswers[index]['answer'],
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          )
        ],);
      }),
    );
  }
}
