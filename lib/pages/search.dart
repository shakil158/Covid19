import 'package:flutter/material.dart';

class SearchResults extends SearchDelegate{
  
  final List countries;

  SearchResults(this.countries);
  @override
  List<Widget> buildActions(BuildContext context) {
     return [
       IconButton(icon: Icon(Icons.clear), onPressed: () {
         query='';
       },)
     ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () {
      Navigator.pop(context);
    },);
  }

  @override
  Widget buildResults(BuildContext context) {
    final suggestions = query.isEmpty ? countries : countries.where((element) => element['country'].toString().toLowerCase().startsWith(query)).toList();
    return suggestions.length==0? Center(child: Text('No results found',style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    ),)):ListView.builder(
        itemCount: suggestions.length,
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
                        Text(suggestions[index]['country'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                        SizedBox(height: 13.0,),
                        Image.network(suggestions[index]['countryInfo']['flag'],
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
                        Text('CONFIRMED: ' + suggestions[index]['cases'].toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 15.0,
                          ),
                        ),
                        SizedBox(height: 3),

                        Text('ACTIVE: ' + suggestions[index]['active'].toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            color: Colors.orange[800],
                          ),
                        ),
                        SizedBox(height: 3),


                        Text('RECOVERED: ' + suggestions[index]['recovered'].toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            color: Colors.green,
                          ),
                        ),
                        SizedBox(height: 3),


                        Text('DEATHS: ' + suggestions[index]['deaths'].toString(),
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
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    
    final suggestions = query.isEmpty ? countries : countries.where((element) => element['country'].toString().toLowerCase().startsWith(query)).toList();
    return suggestions.length==0?Center(child: Text('No results found',style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    ),)):ListView.builder(
        itemCount: suggestions.length,
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
                    Text(suggestions[index]['country'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(height: 13.0,),
                    Image.network(suggestions[index]['countryInfo']['flag'],
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
                    Text('CONFIRMED: ' + suggestions[index]['cases'].toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 15.0,
                      ),
                    ),
                    SizedBox(height: 3),

                    Text('ACTIVE: ' + suggestions[index]['active'].toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                        color: Colors.orange[800],
                      ),
                    ),
                    SizedBox(height: 3),


                    Text('RECOVERED: ' + suggestions[index]['recovered'].toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(height: 3),


                    Text('DEATHS: ' + suggestions[index]['deaths'].toString(),
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
    });
  }

}