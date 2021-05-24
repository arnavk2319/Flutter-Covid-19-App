import 'package:flutter/material.dart';
import 'package:recollection_app/controller/vaccine_controller.dart';
import 'package:intl/intl.dart';

class DosesByCountryTab extends StatefulWidget {
  @override
  _DosesByCountryTabState createState() => _DosesByCountryTabState();
}

class _DosesByCountryTabState extends State<DosesByCountryTab> {

  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formattedCurrentDate = formatter.format(now);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Center(
        child: FutureBuilder(
          future: VaccineController.getDosesByCountry(),
          builder: (context, AsyncSnapshot<List<Map<String, String>>> snapshot){
            if (snapshot.connectionState == ConnectionState.waiting){
              return Center(
                //replace this with a loading icon
                  child: new CircularProgressIndicator()
              );
            }
            else{
              return GridView.count(
                shrinkWrap: true,
                primary: false,
                padding: const EdgeInsets.all(14),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                crossAxisCount: 2,
                children: List.generate(snapshot.data.length, (index) =>
                    Container(
                        height: 70,
                        width: 70,
                        child: Card(
                          color: Colors.purple,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0)
                          ),
                          elevation: 10.0,
                          child: InkWell(
                            splashColor: Colors.blue.withAlpha(30),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.fromLTRB(14.0, 20.0, 14.0, 14.0),
                                  child: Text(
                                    snapshot.data.elementAt(index)['country'].toString(),
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsets.fromLTRB(14.0, 10.0, 14.0, 5.0),
                                  child: Text(
                                    "Doses administered as of " + formattedCurrentDate + ": ",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsets.fromLTRB(14.0, 30.0, 14.0, 14.0),
                                  child: Text(
                                    snapshot.data.elementAt(index)['lastDoseCount'].toString(),
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                    ),
                  // )
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
