import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:core';

class CountryModel {
  String countryName;
  String id;

  CountryModel({this.countryName, this.id});

  factory CountryModel.fromJson(Map<String, String> parsedJson) {
    return CountryModel(
        countryName: parsedJson['Country'],
        id: parsedJson['ISO2']
    );
  }
}