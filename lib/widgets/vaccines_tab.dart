import 'package:flutter/material.dart';
import 'package:recollection_app/controller/vaccine_controller.dart';
import 'package:recollection_app/screens/vaccine_detail_screen.dart';
import 'package:recollection_app/widgets/vaccine_detail_arguments.dart';


class VaccinesTab extends StatefulWidget {
  @override
  _VaccinesTabState createState() => _VaccinesTabState();
}

class _VaccinesTabState extends State<VaccinesTab> {

  @override
  Widget build(BuildContext context) {

    const paleLavender = const Color(0xffdcd0ff);

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Center(
        child: FutureBuilder(
          future: VaccineController.getVaccineCandidates(),
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
                          color: paleLavender,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              side: new BorderSide(color: Colors.purple, width: 2.0),
                          ),
                          elevation: 10.0,
                          child: InkWell(
                            splashColor: Colors.blue.withAlpha(30),
                            onTap: () {
                              Navigator.pushNamed(context, VaccineDetailScreen.routeName, arguments: VaccineDetailArguments(
                                snapshot.data.elementAt(index)['candidate'].toString(),
                                snapshot.data.elementAt(index)['mechanism'].toString(),
                                snapshot.data.elementAt(index)['sponsors'].toString(),
                                snapshot.data.elementAt(index)['details'].toString(),
                                snapshot.data.elementAt(index)['trialPhase'].toString(),
                                snapshot.data.elementAt(index)['institutions'].toString(),
                              ));
                            },
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.fromLTRB(14.0, 75.0, 14.0, 14.0),
                                  child: Text(
                                    snapshot.data.elementAt(index)['candidate'].toString(),
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black
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
