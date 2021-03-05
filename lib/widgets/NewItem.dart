import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:image_picker/image_picker.dart';

class NewItem extends StatefulWidget {

  Function addItm ;

  NewItem(this.addItm);
  @override
  _NewItemState createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  final nameController = TextEditingController();
  final amountController = TextEditingController();

  DateTime selectedDate;
  Future<Directory> _externalDocumentsDirectory;
  File _storedImage;

  void _requestExternalStorageDirectory() {
    setState(() {
      _externalDocumentsDirectory= getExternalStorageDirectory();
    });
  }

  void _submitData(){
  if(amountController.text.isEmpty){
    return;
  }

  final enteredName = nameController.text;
  final enteredAmount =  double.parse(amountController.text);
  final enteredImage = _storedImage;

  if(enteredName.isEmpty || enteredAmount <= 0 || selectedDate == null || _storedImage == null){
    return;
  }

  widget.addItm(enteredName, selectedDate, enteredAmount, enteredImage);

  Navigator.of(context).pop();
  }


  void _presentDatePicker(){
  showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2019), lastDate: DateTime.now(),
  ).then((pickedDate){
    if(pickedDate == null){
      return;
    }

    setState(() {
      selectedDate = pickedDate;
    });
  });
  }

  Future<void> _takePicture() async {
    final imageFile = await ImagePicker().getImage(source: ImageSource.gallery, maxWidth: 600);
    if (imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = File(imageFile.path);
    });
    // final appDir = await getApplicationDocumentsDirectory();
    // final fileName = Path.basename(imageFile.path);
    // final savedImage = await imageFile.copy('${appDir.path}/$fileName');
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child : Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top : 10,
            left : 10,
            right : 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10, //triggers rebuild of the screen
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[

              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: nameController,
                keyboardType: TextInputType.text,
                onSubmitted: (_) => _submitData(),
                // onChanged: (val) {
                //   titleInput = val;
                // },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitData(),
                // onChanged: (val) => amountInput = val,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: RaisedButton(
                      child: const Text('Set Picture'),
                      // onPressed: _requestExternalStorageDirectory,
                      onPressed: _takePicture,
                    ),
                  ),
                  _storedImage != null ?
                  new Flexible(
                      child: CircleAvatar(
                        radius: 30,
                        child : Padding(
                          padding: EdgeInsets.all(6),
                          child: ConstrainedBox(
                              constraints: BoxConstraints(minWidth: 1, minHeight: 1),
                              child : Image(
                                image : FileImage(File(_storedImage.path)) ,
                            )
                          ),
                        )
                      )
                  ) :
                  new Flexible(
                      child: CircleAvatar(
                          radius: 30,
                          child : Padding(
                            padding: EdgeInsets.all(6),
                            child: ConstrainedBox(
                                constraints: BoxConstraints(minWidth: 1, minHeight: 1),
                                child : Icon(
                                  Icons.image,
                                  color: Colors.white,
                                  size: 30.0,
                                )
                            ),
                          )
                      )
                  )
                ],
              ),
              Container(
                height: 70,
                child: Row(children: <Widget>[ // Rows and columns do not have height and width properties, they need to be wrapped within Card ot Container widgets to set the same property
                  Expanded(child: Text(selectedDate == null ? "No Date Chosen" : "Picked Date : ${DateFormat.yMd().format(selectedDate)}")),
                  Platform.isIOS ? CupertinoButton(
                    child: Text("Choose Date",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: _presentDatePicker,
                  )
                      : FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text("Choose Date",style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: _presentDatePicker,)
                ],
                ),
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                child: Text('Add Transaction'),
                textColor: Theme.of(context).textTheme.button.color,
                onPressed: () {
                  _submitData();
                },
              ),
            ],
          ),
        ),
      )
    );
  }
}
