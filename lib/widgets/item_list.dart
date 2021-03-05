import 'package:flutter/material.dart';
import 'package:recollection_app/widgets/item.dart';
import 'swipe_widget.dart';
import 'package:recollection_app/model/item_model.dart';

class ItemList extends StatelessWidget {
  final List<ItemModel> userItems;
  final Function deleteItem;

  ItemList(this.userItems, this.deleteItem);

  @override
  Widget build(BuildContext context) {
    return userItems.isEmpty ? 
      LayoutBuilder(builder: (ctx, constraints) {
        return Column(
          children: <Widget>[
            Text(
              "No items added yet!",
              style: Theme.of(context).textTheme.headline6,
            )
          ],
        );
      }
      )
        :
        ListView.builder(itemBuilder: (ctx, index) {
          return new OnSlide(
              items: <ActionItems>[
                new ActionItems(icon: new IconButton(icon: new Icon(Icons.edit), onPressed : () {}, color: Colors.green ), onPress: () {}, backgroundColor: Colors.white),
                new ActionItems(icon: new IconButton(icon: new Icon(Icons.delete), onPressed: () {}, color: Colors.red ), onPress: () {}, backgroundColor: Colors.white)
              ],
              child: new Container(
                padding: const EdgeInsets.only(top:10.0),
                width: 200.0,
                height: 150.0,
                child : Item(itemModel: userItems[index], deleteItm: deleteItem,)
              ));
        },
        itemCount: userItems.length,);
  }
}

