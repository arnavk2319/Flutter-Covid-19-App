import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:recollection_app/controller/covid_controller.dart';
import 'package:recollection_app/main.dart';
import 'package:recollection_app/model/country_model.dart';
import 'package:recollection_app/screens/map_activity.dart';
import 'package:recollection_app/screens/world_news_activity.dart';
import 'package:recollection_app/screens/vaccine_new_activity.dart';
import 'package:recollection_app/screens/news_activity.dart';
import 'package:recollection_app/screens/login.dart';
import 'package:recollection_app/widgets/GoogleAuth.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:pie_chart/pie_chart.dart';

class CountryNewsActivity extends StatefulWidget {
  @override
  _CountryNewsActivityState createState() => _CountryNewsActivityState();
}

class _CountryNewsActivityState extends State<CountryNewsActivity> {

  GlobalKey<AutoCompleteTextFieldState<CountryModel>> globalKey = new GlobalKey();

  AutoCompleteTextField searchTextField;

  TextEditingController controller;

  var countryName = "";

  _CountryNewsActivityState();

  void _loadData() {
    CovidController.getAllCountryNames();
  }

  @override
  void initState() {
    _loadData();
    controller = new TextEditingController();
    // controller.clear();
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.initState();
  }

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

    final countryChart = new Container(
        margin: EdgeInsets.all(15),
        child: new FutureBuilder(
          future : CovidController.getCountryWiseData(countryName),
          builder: (context, AsyncSnapshot<Map<String,double>> snapshot){
            if (snapshot.connectionState == ConnectionState.waiting) {
              return new Center(
                //replace this with a loading icon
                  child: new CircularProgressIndicator()
              );
            }else if(snapshot.data == null){
              return Text('Please choose a country');
            } else {
              return new PieChart(
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
          title: Text("Country-wise COVID-19 News", style: TextStyle(fontFamily: 'QuickSand')),
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
        body : SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child : Column(
              children: <Widget>[
                Container(
                    // width: 50.0,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(5),
                    child : Center(
                        child : Column(
                              children: <Widget>[
                                searchTextField = AutoCompleteTextField<CountryModel>(
                                    style: new TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0
                                    ),
                                    controller: controller,
                                    decoration: new InputDecoration(
                                        suffixIcon: Container(
                                            width: 85.0,
                                            height: 60.0
                                        ),
                                        contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                                        filled: true,
                                        hintText: 'Search Country Name',
                                        hintStyle: TextStyle(
                                            color: Colors.black
                                        )
                                    ),
                                    itemSubmitted: (item) {
                                      setState(() => {
                                        searchTextField.textField.controller.text = item.countryName
                                      });
                                    },
                                    clearOnSubmit: false,
                                    key: globalKey,
                                    suggestions: CovidController.allCountryDetails.toList(),
                                    itemBuilder: (context, item) {
                                      return Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            item.countryName,
                                            style: TextStyle(
                                                fontSize: 16.0
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                    itemSorter: (before, after) {
                                      return before.countryName.compareTo(after.countryName);
                                    },
                                    itemFilter: (item, query){
                                      return item.countryName.toLowerCase().startsWith(query.toLowerCase());
                                    }
                                ),
                                ElevatedButton(
                                  // color: Theme.of(context).primaryColor,
                                  child : Text("Search"),
                                  // textColor: Colors.white,
                                  onPressed: () {
                                    // CovidController.getCountryWiseData("Afghanistan");
                                    // CovidController.getAllCountryNames();
                                    // _createNewsChildren();
                                    setState(() {
                                      countryName = searchTextField.textField.controller.text.toString();
                                    });
                                  },
                                )
                              ]
                            )
                        //   ],
                        // )
                    )
                ),
                countryChart == null ? Text('Please select a country') : countryChart,
            Table(
            // border: TableBorder.all(width: 0.0, color: Colors.black),
              children: [
                TableRow(
                    children: [
                      TableCell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(15),
                              child: Text(
                                'Countries',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 22
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      TableCell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(15),
                              child: Text(
                                'Confirmed Cases',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 22
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]
                ),
              ],
            ),
                Container(
                  margin: EdgeInsets.all(10),
                  child : FutureBuilder(
                    future: CovidController.getTopCountriesData(),
                    builder : (context, AsyncSnapshot<List<Map<String,int>>> snapshot){
                      return ListView.builder(
                          // physics: NeverScrollableScrollPhysics(),
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data == null ? 0 : snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            if (snapshot.connectionState == ConnectionState.waiting || snapshot.connectionState == ConnectionState.none) {
                              return Center(
                                //replace this with a loading icon
                                  child: new CircularProgressIndicator()
                              );
                            } else {
                              return Table(
                                // border: TableBorder.all(width: 0.0, color: Colors.black),
                                // defaultVerticalAlignment: TableCellVerticalAlignment.fill,
                                children: [
                                  TableRow(
                                      children: [
                                        TableCell(
                                          child : Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  snapshot.data.elementAt(index).keys.toList()[0],
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.normal,
                                                      fontStyle: FontStyle.normal,
                                                      fontSize: 16
                                                  ),
                                                ),
                                              ],
                                            ),
                                          // )
                                        ),
                                        TableCell(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Padding(
                                                  padding: EdgeInsets.all(5),
                                                  child : Container(
                                                    height: 20,
                                                    width: 80,
                                                    child: LiquidCircularProgressIndicator(
                                                      value: snapshot.data.elementAt(index)[snapshot.data.elementAt(index).keys.toList()[0]]/30000000, // Defaults to 0.5.
                                                      valueColor: AlwaysStoppedAnimation(Colors.pink),
                                                      backgroundColor: Colors.white,
                                                      borderColor: Colors.red,
                                                      borderWidth: 1.0,
                                                      direction: Axis.horizontal,
                                                      // center:Text(
                                                      //   percent.toString() +"%",
                                                      //   style: TextStyle(
                                                      //       fontSize:12.0,
                                                      //       fontWeight: FontWeight.w600,
                                                      //       color: Colors.black
                                                      //   ),
                                                      // ),
                                                    ),
                                                  )
                                              )
                                            ],
                                          ),
                                        ),
                                        TableCell(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                (snapshot.data.elementAt(index)[snapshot.data.elementAt(index).keys.toList()[0]]).toString().replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},'),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.normal,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 16
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]
                                  )
                                ],
                              );
                            }
                          }
                      );
                    }
                  )
                ),
              ],
            )
          ),
        )
    );
  }
}
