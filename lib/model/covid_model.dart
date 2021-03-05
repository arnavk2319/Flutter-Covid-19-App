import 'package:flutter/cupertino.dart';

class CovidModel {
  static int newConfirmed;
  static int totalConfirmed;
  static int newDeaths;
  static int totalDeaths;
  static int newRecovered;
  static int totalRecovered;

  // CovidModel({
  // this.newConfirmed,
  // this.totalConfirmed,
  // this.newDeaths,
  // this.totalDeaths,
  // this.newRecovered,
  // this.totalRecovered,
  // });

  int get getNewConfirmed => newConfirmed;

  int get getTotalConfirmed => totalConfirmed;

  int get getNewDeaths => newDeaths;

  int get getTotalDeaths => totalDeaths;

  int get getNewRecovered => newRecovered;

  int get getTotalRecovered => totalRecovered;

}