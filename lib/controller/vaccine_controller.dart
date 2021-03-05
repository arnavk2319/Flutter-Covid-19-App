import 'package:flutter/foundation.dart';
import 'package:recollection_app/model/news_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:core';

class VaccineController{

  var topVaccineCountries = {'US', 'China', 'UK', 'India', 'Turkey', 'Brazil', 'Israel', 'Germany', 'UAE', 'France'};

  static Map<String, String> requestHeaders = {

  };

  static Future getVaccineNews() async {

  }

}