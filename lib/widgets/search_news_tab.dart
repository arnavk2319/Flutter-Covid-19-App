import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:recollection_app/controller/news_controller.dart';


class SearchNewsTab extends StatefulWidget {
  @override
  _SearchNewsTabState createState() => _SearchNewsTabState();
}

class _SearchNewsTabState extends State<SearchNewsTab> {

  TextField searchTextField;

  TextEditingController _searchController = new TextEditingController();

  var searchQuery = '';

  @override
  Widget build(BuildContext context) {

    final centerText = Center(
      child: Text(
        "Search for latest News and Articles related to COVID-19",
        textAlign: TextAlign.center,
      ),
    );

    final searchNewsList = Center(
      // height : MediaQuery.of(context).size.height * 2,
      // margin: EdgeInsets.all(15),
      child: new FutureBuilder(
          future: NewsController.getSearchNews(searchQuery),
          builder: (context, AsyncSnapshot<List<Map<String, String>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting){
              return Center(
                //replace this with a loading icon
                  child: new CircularProgressIndicator()
              );
            }
            else {
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
                            url: snapshot.data.elementAt(index)['url'].toString(),
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
                                  snapshot.data[index]['urlToImage'].toString()
                              ),
                              fit: BoxFit.contain,
                            ),
                            Padding(
                              padding: EdgeInsets.all(15),
                              child: Text(
                                // snapshot.data[index]['title'],
                                snapshot.data[index]['title'].toString(),
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: Text(
                                "Date Published: " + snapshot.data[index]['publishedAt'].toString(),
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceAround,
                                  children: <Widget>[
                                    InkWell(
                                      splashColor: Colors.purple.withAlpha(30),
                                      child: new Text(
                                          'See More',
                                          style: TextStyle(
                                              color: Colors.purple,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17.0
                                          )
                                      ),
                                      onTap: () {
                                        FlutterWebBrowser.openWebPage(
                                          url: snapshot.data.elementAt(index)['url'].toString(),
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
            )
              );
            }

          }
      ),
    );

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
                          searchTextField = TextField(
                            controller: _searchController,
                            decoration: const InputDecoration(labelText: 'Search news related to COVID-19'),
                          ),
                              ElevatedButton(
                            // color: Theme.of(context).primaryColor,
                            child : Text("Search"),
                            // textColor: Colors.white,
                            onPressed: () {
                              setState(() {
                                searchQuery = searchTextField.controller.text.toString();
                                print(searchQuery);
                              });
                            },
                          ),
                          searchNewsList == null ? centerText : searchNewsList,
                    ]
                )
            ),
            )
          ],
        )
    );
  }
}
