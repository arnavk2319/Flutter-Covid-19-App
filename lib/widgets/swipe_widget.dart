import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'size_change_notifier.dart';

class ActionItems extends Object{
  ActionItems ({@required this.icon, @required this.onPress, this.backgroundColor:Colors.grey}){
    assert(icon != null);
    assert(onPress != null);
  }

  final Widget icon;
  final VoidCallback onPress;
  final Color backgroundColor;
}

class OnSlide extends StatefulWidget {
  OnSlide({Key key, @required this.items, @required this.child, this.backgroundColor:Colors.white}):super(key:key){
    assert(items.length <= 6);
  }

  final List<ActionItems> items;
  final Widget child;
  final Color backgroundColor;

  @override
  _OnSlideState createState() {
    return new _OnSlideState();
  }
}

class _OnSlideState extends State<OnSlide> {
  ScrollController scrollController = new ScrollController();
  bool isOpen  = false;

  Size childSize;

  @override
  void initState() {
    super.initState();
  }

  bool _handleScrollNotification(dynamic notification) {
    if(notification is ScrollEndNotification) {
      if((notification.metrics.pixels >= widget.items.length * 0.70/2) && notification.metrics.pixels < widget.items.length * 0.70){
        scheduleMicrotask(() {
          scrollController.animateTo(widget.items.length * 0.60, duration: new Duration(milliseconds: 600), curve: Curves.decelerate);
        });
    } else if(notification.metrics.pixels > 0.0 && notification.metrics.pixels < (widget.items.length * 0.70)/2) {
        scheduleMicrotask(() {
          scrollController.animateTo(0.0, duration: new Duration(milliseconds: 600), curve: Curves.decelerate);
        });
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    if(childSize == null){
    return new NotificationListener(
        child: LayoutSizeChangeNotifier(
          child : widget.child
        ),
      onNotification: (LayoutSizeChangeNotification notification){
          childSize = notification.newSize;
          print(notification.newSize);
          scheduleMicrotask((){
            setState(() {});
          });
      },
    );
    }

    List<Widget> above = <Widget>[new Container(
      width: childSize.width,
      height: childSize.height,
      color : widget.backgroundColor,
      child: widget.child,
    )];

    List<Widget> under = <Widget>[];

    for(ActionItems item in widget.items){
      under.add(
        new Container(
          alignment: Alignment.center,
          color: item.backgroundColor,
          width: 60.0,
          height: childSize.height,
          child: item.icon
        )
      );

      above.add(
        new InkWell(
          child : new Container(
            alignment: Alignment.center,
            width: 60.0,
            height: childSize.height,
          ),
          onTap: (){
            // scrollController.jumpTo(2.0);
            item.onPress();
          },
        )
      );
    }

    Widget items = new Container(
      width: childSize.width,
      height: childSize.height,
      color: widget.backgroundColor,
      child : new Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: under,
      )
    );

    Widget scrollview = new NotificationListener(
        child: ListView(
          controller: scrollController,
          scrollDirection: Axis.horizontal,
          children: above,
        ),
      onNotification: _handleScrollNotification,
    );

    return new Stack(
      children: <Widget>[
        items,
        new Positioned(child: scrollview, left: 0.0, right: 0.0, bottom: 0.0, top: 0.0)
      ],
    );

  }
}


