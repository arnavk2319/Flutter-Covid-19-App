import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recollection_app/widgets/vaccine_detail_arguments.dart';

class VaccineDetailScreen extends StatefulWidget {
  static const routeName = '/extractArguments';
  @override
  _VaccineDetailScreenState createState() => _VaccineDetailScreenState();
}

class _VaccineDetailScreenState extends State<VaccineDetailScreen> {
  @override
  Widget build(BuildContext context) {

    final VaccineDetailArguments args = ModalRoute.of(context).settings.arguments as VaccineDetailArguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.candidate, style: TextStyle(fontFamily: 'QuickSand')),
      ),
      body: Container(
          constraints: BoxConstraints.tight(Size.square(1000.0)),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/vaccine.jpg"),
                  fit: BoxFit.cover
              )
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(50.0, 80.0, 50.0, 80.0),
            child: Card(
              elevation: 10.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.0)
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(22.0)
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ClipRRect(
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.white,
                                      width: 5
                                  ),
                                  borderRadius: BorderRadius.circular(300)
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Image(
                                    image: AssetImage("assets/images/vaccineVial.jpg"),
                                    height: 80,
                                    width: 80
                                ),
                              ),
                            ),
                          )
                        ]
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      args.candidate,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22
                      ),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  "Candidate:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  args.candidate,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16
                                  ),
                                ),
                              )
                            ]
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  "Mechanism:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                    args.mechanism,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 5,
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16
                                    ),
                                  ),
                                ),
                              )
                            ]
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  "Sponsors:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16
                                  ),
                                ),
                              ),
                              Flexible(
                                    child: Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Text(
                                          args.sponsors,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16
                                          ),
                                        ),
                                      ),
                              )
                            ]
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  "Trial Phase:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  args.trialPhase,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16
                                  ),
                                ),
                              )
                            ]
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  "Institutions:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                    args.institutions,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 5,
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16
                                    ),
                                  ),
                                ),
                              )

                            ]
                        ),
                      )
                    ],
                  )

                ],
              ),
            ),
          )
          )
      );
  }
}
