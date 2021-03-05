import 'dart:ffi';
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'dart:io';

class ItemModel {
  final String id;
  final String name;
  final DateTime dateTime;
  final double amount;
  final File image;

  ItemModel({
    @required this.id,
    @required this.name,
    @required this.dateTime,
    @required this.amount,
    @required this.image,
  });

}
