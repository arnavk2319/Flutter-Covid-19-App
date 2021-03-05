import 'package:flutter/foundation.dart';
import 'package:recollection_app/model/country_model.dart';
import 'package:recollection_app/model/covid_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:core';

class CovidController{

  static var countries = {'US', 'IN', 'BR', 'UK', 'RU', 'FR', 'ES', 'IT', 'TR', 'DE'};

  static Map<String,double> summaryPieData;
  static Map<String,int> topCountriesTableData;
  static Map<String,double> selectedCountryData;
  static Map<String,String> countryDetail;


  static var topCountriesDataSet = Set<Map<String, int>>();
  static var allCountryNames = Set<Map<String,String>>();
  static var allCountryDetails = Set<CountryModel>();

  static Map<String, String> requestHeaders = {
    'X-Access-Token': '5cf9dfd5-3449-485e-b5ae-70a60e997864',
  };

  static Future<Map<String,double>> getWorldData() async {
    var response = await http.get('https://api.covid19api.com/summary',  headers: requestHeaders);
    if(response.statusCode == 200){
      var jsonResponse = convert.jsonDecode((response.body));
      double newConfirmed = jsonResponse['Global']['NewConfirmed'].toDouble();
      double totalConfirmed = jsonResponse['Global']['TotalConfirmed'].toDouble();
      double newDeaths = jsonResponse['Global']['NewDeaths'].toDouble();
      // double totalDeaths = jsonResponse['Global']['"TotalDeaths'].toDouble();
      double newRecovered = jsonResponse['Global']['NewRecovered'].toDouble();
      double totalRecovered = jsonResponse['Global']['TotalRecovered'].toDouble();
      summaryPieData = {
        "New Confirmed" : newConfirmed,
        "Total Confirmed" : totalConfirmed,
        "New Deaths" : newDeaths,
        // "Total Deaths" : totalDeaths,
        "New Recovered" : newRecovered,
        "Total Recovered" : totalRecovered,
      };
      return summaryPieData;
    }
    else{
      print("Could not get response for chart" + " " + response.statusCode.toString());
    }
  }

  static Future<List<Map<String, int>>> getTopCountriesData() async {
    var response = await http.get('https://api.covid19api.com/summary',  headers: requestHeaders);
    if(response.statusCode == 200){
      var jsonResponse = convert.jsonDecode((response.body));
      var countriesLength = jsonResponse['Countries'].length;

      for(int i=0;i<countries.length;i++){
        for(int j=0;j<countriesLength;j++){
          if(jsonResponse['Countries'][j]['CountryCode'] == countries.elementAt(i) && countries.elementAt(i) == 'US'){
            topCountriesTableData = {
              "USA" : jsonResponse['Countries'][j]['TotalConfirmed'],
            };
            if(topCountriesDataSet.length < 9){
              topCountriesDataSet.add(topCountriesTableData);
            }
            break;
          }
          else if(jsonResponse['Countries'][j]['CountryCode'] == countries.elementAt(i)){
            topCountriesTableData = {
              jsonResponse['Countries'][j]['Country'] : jsonResponse['Countries'][j]['TotalConfirmed'],
            };
            if(topCountriesDataSet.length < 9){
              topCountriesDataSet.add(topCountriesTableData);
            }
            break;
          }
        }
      }
      // print(topCountriesDataSet);
      return topCountriesDataSet.toList();
    }
    else{
      print("Could not get response for top country dataset" + " " + response.statusCode.toString());
    }
  }


  static Future<Map<String, double>> getCountryWiseData(String countryName) async {
    var response = await http.get('https://api.covid19api.com/summary',  headers: requestHeaders);
    if(response.statusCode == 200){
      var jsonResponse = convert.jsonDecode(response.body);
      var countriesLength = jsonResponse['Countries'].length;

        for(int j=0;j<countriesLength;j++){
          if(jsonResponse['Countries'][j]['Country'] == countryName){
            selectedCountryData = {
              // "Total Confirmed": jsonResponse['Countries'][j]['NewConfirmed'].toDouble(),
              "New Confirmed" : jsonResponse['Countries'][j]['NewConfirmed'].toDouble(),
              "Total Confirmed" : jsonResponse['Countries'][j]['TotalConfirmed'].toDouble(),
              // "New Deaths" : jsonResponse['Countries'][j]['New Deaths'].toDouble(),
              "Total Deaths" : jsonResponse['Countries'][j]['TotalDeaths'].toDouble(),
              "New Recovered" : jsonResponse['Countries'][j]['NewRecovered'].toDouble(),
              "Total Recovered" : jsonResponse['Countries'][j]['TotalRecovered'].toDouble(),
            };
          }
        }
      // print(selectedCountryData);
      return selectedCountryData;
    }
    else{
      print("Could not get response for country wise data" + " " + response.statusCode.toString()) ;
    }
  }

  static Future getAllCountryNames() async {
    var response = await http.get('https://api.covid19api.com/countries', headers: requestHeaders);
    if(response.statusCode == 200){
      var jsonResponse = convert.jsonDecode((response.body));

      for(int i=0;i<jsonResponse.length;i++){
        countryDetail = {
          "Country" : jsonResponse[i]['Country'].toString(),
          "ISO2" : jsonResponse[i]['ISO2'].toString().toLowerCase()
        };
        allCountryNames.add(countryDetail);
      }

      for(int j=0;j<allCountryNames.length;j++){
        allCountryDetails.add(CountryModel.fromJson(allCountryNames.elementAt(j)));
      }

      // print(allCountryDetails);
      // return allCountryNames.toList();
    }
    else{
      print("Could not get response for all country list" + " " + response.statusCode.toString()) ;
    }
  }


  int getNewConfirmed() {
    return CovidModel().getNewConfirmed;
  }

  int getTotalConfirmed() {
    return CovidModel().getTotalConfirmed;
  }

  int getNewDeaths() {
    return CovidModel().getNewDeaths;
  }

  int getTotalDeaths() {
    return CovidModel().getTotalDeaths;
  }

  int getNewRecovered() {
    return CovidModel().getNewRecovered;
  }

  int getTotalRecovered() {
    return CovidModel().getTotalRecovered;
  }

}