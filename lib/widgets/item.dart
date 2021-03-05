import 'dart:io';

import 'package:flutter/material.dart';
import 'package:recollection_app/model/item_model.dart';
import 'package:intl/intl.dart';

class Item extends StatelessWidget {

  const Item ({
    Key key,
    @required this.itemModel,
    @required this.deleteItm
    }) : super(key: key);

  final ItemModel itemModel;
  final Function deleteItm;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8,horizontal: 5),
      child: ListTile(leading: CircleAvatar(
        radius: 30,
        child : Padding(
          padding: EdgeInsets.all(6),
          child: FittedBox(
              child: Image.file(itemModel.image)),
        ),
      ),
        title: Text(itemModel.name + "-" + itemModel.amount.toString(),
          style: Theme.of(context).textTheme.headline5,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(itemModel.dateTime),
        ),
        trailing: MediaQuery.of(context).size.width > 460 ?
        FlatButton.icon(
            icon : Icon(Icons.delete),
            label: Text("Delete"),
            textColor : Theme.of(context).errorColor,
            onPressed: () => deleteItm(itemModel.id))

            : IconButton(icon: Icon(Icons.delete),
            color : Theme.of(context).errorColor,
            onPressed: () => deleteItm(itemModel.id)),
      ),
    );
  }
}

