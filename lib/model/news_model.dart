import 'package:flutter/cupertino.dart';

class NewsModel {
  static String author;
  static String title;
  static String description;
  static String url;
  static String urlToImage;

  // CovidModel({
  // this.newConfirmed,
  // this.totalConfirmed,
  // this.newDeaths,
  // this.totalDeaths,
  // this.newRecovered,
  // this.totalRecovered,
  // });

  String get getAuthor => author;

  String get getTitle => title;

  String get getDescription => description;

  String get getUrl => url;

  String get getUrlToImage => urlToImage;

}