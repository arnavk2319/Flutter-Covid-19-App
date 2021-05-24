import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:recollection_app/controller/news_controller.dart';

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
            future: NewsController.getSearchNews("covid-19"),
            builder: (context, AsyncSnapshot<List<Map<String, String>>> snapshot) {
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
                  padding: const EdgeInsets.all(10),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 1,
                  children: List.generate(snapshot.data.length, (index) =>
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: Center(
                            child: Card(
                              elevation: 10.0,
                              child: InkWell(
                                  splashColor: Colors.blue.withAlpha(30),
                                  onTap: () {
                                    FlutterWebBrowser.openWebPage(
                                      url: snapshot.data.elementAt(index)['url'],
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
                                        padding: EdgeInsets.all(15),
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
                                          snapshot.data[index]['author'].toString(),
                                          textAlign: TextAlign.left,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: <Widget>[
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
                      )
                    // )
                  ),
                );
              }
              // return createNewsListChildren(context, snapshot);

            }
        ),
      ),
    );
  }
}
