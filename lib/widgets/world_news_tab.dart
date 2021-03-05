import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:recollection_app/controller/news_controller.dart';
import 'package:recollection_app/main.dart';
import 'package:recollection_app/screens/map_activity.dart';
import 'package:recollection_app/screens/country_news_activity.dart';
import 'package:recollection_app/screens/world_news_activity.dart';
import 'package:recollection_app/screens/news_activity.dart';
import 'package:recollection_app/screens/login.dart';
import 'package:recollection_app/screens/vaccine_new_activity.dart';
import 'package:recollection_app/widgets/GoogleAuth.dart';

class WorldNewsTab extends StatefulWidget {
  WorldNewsTab({Key key}) : super(key: key);
  @override
  _WorldNewsTabState createState() => _WorldNewsTabState();
}

class _WorldNewsTabState extends State<WorldNewsTab> {
  // var seeMorePressed = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Center(
        // height : MediaQuery.of(context).size.height * 2,
        // margin: EdgeInsets.all(15),
        child: FutureBuilder(
            future: NewsController.getWorldNews(),
            builder: (context,
                AsyncSnapshot<List<Map<String, String>>> snapshot) {
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
    );
  }
}
