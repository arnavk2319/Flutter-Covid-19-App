import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:recollection_app/main.dart';
import 'package:recollection_app/screens/map_activity.dart';
import 'package:recollection_app/screens/country_news_activity.dart';
import 'package:recollection_app/screens/news_activity.dart';
import 'package:recollection_app/screens/login.dart';
import 'package:recollection_app/controller/covid_controller.dart';
import 'package:recollection_app/screens/vaccine_new_activity.dart';
import 'package:recollection_app/widgets/GoogleAuth.dart';

class WorldNewsActivity extends StatefulWidget {
  @override
  _WorldNewsActivityState createState() => _WorldNewsActivityState();
}

class _WorldNewsActivityState extends State<WorldNewsActivity> {
  @override
  Widget build(BuildContext context) {
    List<Color> colorList = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.yellow,
      Colors.deepOrange
    ];

    ChartType _chartType = ChartType.disc;
    bool _showCenterText = false;
    double _ringStrokeWidth = 32;
    double _chartLegendSpacing = 48;

    bool _showLegendsInRow = false;
    bool _showLegends = true;

    bool _showChartValueBackground = true;
    bool _showChartValues = true;
    bool _showChartValuesInPercentage = true;
    bool _showChartValuesOutside = true;

    LegendPosition _legendPosition = LegendPosition.right;
    int key = 0;

    final worldChart = Container(
        margin: EdgeInsets.all(15),
        child: FutureBuilder(
          future : CovidController.getWorldData(),
          builder: (context, AsyncSnapshot<Map<String,double>> snapshot){
            if (snapshot.connectionState == ConnectionState.waiting || snapshot.data == null) {
              return Center(
                //replace this with a loading icon
                  child: new CircularProgressIndicator()
              );
            } else {
              return PieChart(
                key: ValueKey(key),
                dataMap: snapshot.data,
                animationDuration: Duration(milliseconds: 800),
                chartLegendSpacing: _chartLegendSpacing,
                chartRadius: MediaQuery.of(context).size.width / 2.0 > 300
                    ? 300
                    : MediaQuery.of(context).size.width / 2.0,
                colorList: colorList,
                initialAngleInDegree: 0,
                chartType: _chartType,
                // centerText: _showCenterText ? "HYBRID" : null,
                legendOptions: LegendOptions(
                  showLegendsInRow: _showLegendsInRow,
                  legendPosition: _legendPosition,
                  showLegends: _showLegends,
                  // legendShape: _legendShape == LegendShape.Circle
                  //     ? BoxShape.circle
                  //     : BoxShape.rectangle,
                  legendTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                chartValuesOptions: ChartValuesOptions(
                  showChartValueBackground: _showChartValueBackground,
                  showChartValues: _showChartValues,
                  showChartValuesInPercentage: _showChartValuesInPercentage,
                  showChartValuesOutside: _showChartValuesOutside,
                ),
                ringStrokeWidth: _ringStrokeWidth,
              );
            }
          },
        )
    );

    return Scaffold(
      // resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text("World COVID-19 News", style: TextStyle(fontFamily: 'QuickSand')),
        ),
        drawer: Drawer(
            child : ListView(
                padding : EdgeInsets.zero,
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    accountName: name != null ? Text(name) : Text("Name"),
                    accountEmail: email != null ? Text(email) : Text("Email"),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: photoUrl != null ? NetworkImage(photoUrl) : AssetImage("assets/images/google.jpg"),
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.all(6),
                    leading: CircleAvatar(
                      radius: 30,
                      child : Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                            child: Text("M")
                        ),
                      ),
                    ),
                    title : Text("Map Activity"),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext ctx) => MapActivity()));
                    },
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.all(6),
                    leading: CircleAvatar(
                      radius: 30,
                      child : Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                            child: Text("M")
                        ),
                      ),
                    ),
                    title : Text("World COVID-19 News"),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext ctx) => WorldNewsActivity()));
                    },
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.all(6),
                    leading: CircleAvatar(
                      radius: 30,
                      child : Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                            child: Text("M")
                        ),
                      ),
                    ),
                    title : Text("Vaccine Tracker"),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext ctx) => VaccineNewsActivity()));
                    },
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.all(6),
                    leading: CircleAvatar(
                      radius: 30,
                      child : Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                            child: Text("M")
                        ),
                      ),
                    ),
                    title : Text("Country-wise COVID-19 News"),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext ctx) => CountryNewsActivity()));
                    },
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.all(6),
                    leading: CircleAvatar(
                      radius: 30,
                      child : Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                            child: Text("M")
                        ),
                      ),
                    ),
                    title : Text("COVID-19 News"),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext ctx) => NewsActivity()));
                    },
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.all(6),
                    leading: CircleAvatar(
                      radius: 30,
                      child : Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                            child: Text("M")
                        ),
                      ),
                    ),
                    title : Text("Home"),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext ctx) => MyHomePage()));
                    },
                  ),
                  email != null ?
                  ListTile(
                      contentPadding: EdgeInsets.all(6),
                      leading: CircleAvatar(
                        radius: 30,
                        child : Padding(
                          padding: EdgeInsets.all(6),
                          child: FittedBox(
                              child: Text("L")
                          ),
                        ),
                      ),
                      title : Text("Logout"),
                      onTap: () {
                        signOutGoogle();
                        Navigator.pop(context);
                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext ctx) => Login()));
                      }
                  )
                      :
                  ListTile(
                      contentPadding: EdgeInsets.all(6),
                      leading: CircleAvatar(
                        radius: 30,
                        child : Padding(
                          padding: EdgeInsets.all(6),
                          child: FittedBox(
                              child: Text("L")
                          ),
                        ),
                      ),
                      title : Text("Login/Sign Up"),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext ctx) => Login()));
                      }
                  ),
                ]
            )
        ),
        body :  SingleChildScrollView(
            // scrollDirection: Axis.vertical,
            child: Container(
              // child : Expanded(
                child : Column(
                  children: <Widget>[
                    worldChart == null ? Text('No Pie Chart') : worldChart,
                    // Container(
                    //     margin: EdgeInsets.all(15),
                    //     child: FutureBuilder(
                    //       future : CovidController.getWorldData(),
                    //       builder: (context, AsyncSnapshot<Map<String,double>> snapshot){
                    //         if (snapshot.connectionState == ConnectionState.waiting || snapshot.data == null) {
                    //           return Center(
                    //             //replace this with a loading icon
                    //               child: new CircularProgressIndicator()
                    //           );
                    //         } else {
                    //           return Column(
                    //               mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //               children: snapshot.data.entries.map((entry){
                    //                 var w = Text(
                    //                   entry.key + " " + ":" + " " +  entry.value.toString().replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},'),
                    //                   textAlign: TextAlign.center,
                    //                   overflow: TextOverflow.ellipsis,
                    //                   style: TextStyle(
                    //                     fontWeight: FontWeight.bold,
                    //                     fontSize: 20,
                    //                   ),
                    //                 );
                    //                 return w;
                    //               }).toList()
                    //           );
                    //         }
                    //       },
                    //     )
                    // ),
                  ],
                )
              // )
            )
        )
    );
  }
}
