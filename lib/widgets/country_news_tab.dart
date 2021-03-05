import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:recollection_app/controller/news_controller.dart';
import 'package:recollection_app/controller/covid_controller.dart';
import 'package:recollection_app/model/country_model.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';

class CountryNewsTab extends StatefulWidget {
  @override
  _CountryNewsTabState createState() => _CountryNewsTabState();
}

class _CountryNewsTabState extends State<CountryNewsTab> {

  GlobalKey<AutoCompleteTextFieldState<CountryModel>> globalKey = new GlobalKey();

  AutoCompleteTextField searchTextField;

  TextEditingController controller;

  _CountryNewsTabState();
  
  var countryNameISO2Val = '';

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
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
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
                          searchTextField.textField.controller.text = item.id
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
                            Text(
                              item.id,
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
                      setState(() {
                        countryNameISO2Val = searchTextField.textField.controller.text.toString();
                        print(countryNameISO2Val);
                      });
                    },
                  )
                ]
            )
        )
    ),
          Center(
            // height : MediaQuery.of(context).size.height * 2,
            // margin: EdgeInsets.all(15),
            child: new FutureBuilder(
                future: NewsController.getCountryNews(countryNameISO2Val),
                builder: (context, AsyncSnapshot<List<Map<String, String>>> snapshot) {
                  // return createNewsListChildren(context, snapshot);
                  return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data == null ? 0 : 10,
                      itemBuilder: (BuildContext context, int index) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(
                            //replace this with a loading icon
                              child: new CircularProgressIndicator()
                          );
                        } else {
                          return Padding(
                              padding: EdgeInsets.all(10),
                              child: Center(
                                child: Card(
                                  elevation: 10.0,
                                  child: InkWell(
                                      splashColor: Colors.blue.withAlpha(30),
                                      onTap: () {
                                        FlutterWebBrowser.openWebPage(
                                          url: snapshot.data.elementAt(
                                              index)['url'],
                                          customTabsOptions: CustomTabsOptions(
                                            colorScheme: CustomTabsColorScheme.dark,
                                            toolbarColor: Colors.deepPurple,
                                            secondaryToolbarColor: Colors.green,
                                            navigationBarColor: Colors.amber,
                                            addDefaultShareMenuItem: true,
                                            instantAppsEnabled: true,
                                            showTitle: true,
                                            urlBarHidingEnabled: true,
                                          ),
                                        );
                                      },
                                      // child: Expanded(
                                      child: Column(
                                        children: <Widget>[
                                          Image(
                                            image: NetworkImage(
                                                snapshot.data[index]['urlToImage']),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(20),
                                            child: Text(
                                              // snapshot.data[index]['title'],
                                              snapshot.data[index]['title'],
                                              textAlign: TextAlign.left,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Text(
                                              snapshot.data[index]['author'],
                                              textAlign: TextAlign.left,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceAround,
                                                children: <Widget>[
                                                  // IconButton(
                                                  //   icon: new Icon( bookmarkPressed ?
                                                  //       Icons.bookmark_border : Icons.bookmark,
                                                  //       size: 30.0,
                                                  //   ),
                                                  //   color: Colors.purple,
                                                  //   onPressed: (){
                                                  //     setState(() {
                                                  //       bookmarkPressed = !bookmarkPressed;
                                                  //     });
                                                  //   },
                                                  // ),
                                                  InkWell(
                                                    splashColor: Colors.purple
                                                        .withAlpha(30),
                                                    child: new Text(
                                                        'See More',
                                                        style: TextStyle(
                                                            color: Colors.purple,
                                                            fontWeight: FontWeight
                                                                .bold,
                                                            fontSize: 17.0
                                                        )
                                                    ),
                                                    onTap: () {
                                                      FlutterWebBrowser.openWebPage(
                                                        url: snapshot.data
                                                            .elementAt(
                                                            index)['url'],
                                                        customTabsOptions: CustomTabsOptions(
                                                          colorScheme: CustomTabsColorScheme
                                                              .dark,
                                                          toolbarColor: Colors
                                                              .deepPurple,
                                                          secondaryToolbarColor: Colors
                                                              .green,
                                                          navigationBarColor: Colors
                                                              .amber,
                                                          addDefaultShareMenuItem: true,
                                                          instantAppsEnabled: true,
                                                          showTitle: true,
                                                          urlBarHidingEnabled: true,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ],
                                              )
                                          ),

                                        ],
                                      )
                                  ),
                                ),
                              )
                          );
                        }
                      }
                  );
                }
            ),
          ),
        ],
      )

    );
  }
}
