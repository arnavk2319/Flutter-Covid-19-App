import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

class Accordion extends StatefulWidget {
  final String title;
  final String content;
  final String url;
  bool showContent;

  Accordion(this.title, this.content, this.url, this.showContent);
  @override
  _AccordionState createState() => _AccordionState();
}

class _AccordionState extends State<Accordion> {

  final paleLavender = const Color(0xffdcd0ff);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.deepPurple,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: EdgeInsets.all(20),
      child: Column(
            children: [
              ListTile(
                title: Text(
                  widget.title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(
                      widget.showContent ? Icons.arrow_drop_up : Icons.arrow_drop_down),
                  onPressed: () {
                    setState(() {
                      widget.showContent = !widget.showContent;
                    }
                    );
                  },
                ),
              ),
              widget.showContent
                  ? Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Column(
                  children: <Widget>[
                    Text(
                      widget.content,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            InkWell(
                              splashColor: Colors.purple.withAlpha(30),
                                child : Card(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(22.0),
                                    side: new BorderSide(color: paleLavender, width: 4.0),
                                  ),
                                  elevation: 10.0,
                                  child: Padding(
                                  padding: EdgeInsets.all(12),
                                      child: new Text(
                                          'See More',
                                          style: TextStyle(
                                            color: Colors.deepPurple,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.0,
                                          )
                                      ),
                                  ),
                              ),
                              onTap: () {
                                FlutterWebBrowser.openWebPage(
                                  url: widget.url.toString(),
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
                            ),
                          ],
                        )
                    ),
                  ],
                )
              )
                  : Container()
            ]
        ),
      // )
    );
  }
}