import 'package:flutter/foundation.dart';
import 'package:recollection_app/model/news_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:core';

class NewsController{

  static Map<String,String> newsData;
  static Map<String,String> countryNewsData;
  static Map<String,String> searchNewsData;

  static var newsSet = new Set<Map<String, String>>();
  static var countryNewsSet = new Set<Map<String, String>>();
  // static Set<Map<String, String>> newsSet = {};

  // static var newsSources = ['cbc-news', 'bbc-news', 'cnn'];

  static Map<String, String> worldRequestHeaders = {
    'q': 'covid-19',
    'sortBy': 'relevant',
    'apiKey': '964cf810e34d40d495ea2cd07b0689e0',
  };

  static Future<List<Map<String, String>>> getWorldNews() async {
      var response = await http.get('http://newsapi.org/v2/everything?sortBy=${worldRequestHeaders['sortBy']}&apiKey=${worldRequestHeaders['apiKey']}&q=${worldRequestHeaders['q']}',  headers: worldRequestHeaders);
      var jsonResponse = convert.jsonDecode(response.body);
      if(response.statusCode == 200){
        for(int j=0;j<10;j++){
          newsData = {
            "author" : jsonResponse['articles'][j]['author'],
            "title" : jsonResponse['articles'][j]['title'],
            "description" : jsonResponse['articles'][j]['description'],
            "url" : jsonResponse['articles'][j]['url'],
            "urlToImage" : jsonResponse['articles'][j]['urlToImage'],
            "publishedAt" : jsonResponse['articles'][j]['publishedAt']
            };
            newsSet.add(newsData);
        }
        print(newsSet);
        return newsSet.toList();
      }
      else{
        print("Could not get response" + " " + response.statusCode.toString() + " " + jsonResponse['status'] + " " + jsonResponse['message']);
      }

  }


  static Map<String, String> countryRequestHeaders = {
    'country' : '',
    'apiKey': '964cf810e34d40d495ea2cd07b0689e0',
    'q': 'covid-19',
  };


  static Future<List<Map<String, String>>> getCountryNews(String countryISOVal) async {
    countryNewsSet.clear();
    var response = await http.get('https://newsapi.org/v2/top-headlines?country=${countryISOVal}&apiKey=${countryRequestHeaders['apiKey']}&q=${countryRequestHeaders['q']}',  headers: countryRequestHeaders);
    var jsonResponse = convert.jsonDecode(response.body);
    if(response.statusCode == 200){
      for(int j=0;j<jsonResponse['totalResults'];j++){
        countryNewsData = {
          "author" : jsonResponse['articles'][j]['author'],
          "title" : jsonResponse['articles'][j]['title'],
          "description" : jsonResponse['articles'][j]['description'],
          "url" : jsonResponse['articles'][j]['url'],
          "urlToImage" : jsonResponse['articles'][j]['urlToImage'],
          "publishedAt" : jsonResponse['articles'][j]['publishedAt']
        };
        countryNewsSet.add(countryNewsData);
      }
      print(countryNewsSet);
      return countryNewsSet.toList();
    }
    else{
      print("Could not get response for country news" + " " + response.statusCode.toString() + " " + jsonResponse['status'] + " " + jsonResponse['message']);
    }

  }

  static Map<String, String> searchRequestHeaders = {
    'apiKey': '964cf810e34d40d495ea2cd07b0689e0',
    'q': '',
  };


  static Future<List<Map<String, String>>> getSearchNews(String query) async {
    countryNewsSet.clear();
    var response = await http.get('https://newsapi.org/v2/top-headlines?apiKey=${countryRequestHeaders['apiKey']}&q=${query}',  headers: searchRequestHeaders);
    var jsonResponse = convert.jsonDecode(response.body);
    if(response.statusCode == 200){
      for(int j=0;j<jsonResponse['totalResults'];j++){
        countryNewsData = {
          "author" : jsonResponse['articles'][j]['author'],
          "title" : jsonResponse['articles'][j]['title'],
          "description" : jsonResponse['articles'][j]['description'],
          "url" : jsonResponse['articles'][j]['url'],
          "urlToImage" : jsonResponse['articles'][j]['urlToImage'],
          "publishedAt" : jsonResponse['articles'][j]['publishedAt']
        };
        countryNewsSet.add(countryNewsData);
      }
      print(countryNewsSet);
      return countryNewsSet.toList();
    }
    else{
      print("Could not get response for country news" + " " + response.statusCode.toString() + " " + jsonResponse['status'] + " " + jsonResponse['message']);
    }

  }


  String getAuthor() {
    return NewsModel().getAuthor;
  }

  String getTitle() {
    return NewsModel().getTitle;
  }

  String getDescription() {
    return NewsModel().getDescription;
  }

  String getUrl() {
    return NewsModel().getUrl;
  }

  String getUrlToImage() {
    return NewsModel().getUrlToImage;
  }

}