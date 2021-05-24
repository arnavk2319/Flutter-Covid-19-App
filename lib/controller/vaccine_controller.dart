import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:core';

class VaccineController{

  static Map<String,String> vaccineMap = new Map<String,String>();
  static Map<String,String> dosesMap = new Map<String,String>();

  static Set<Map<String,String>> vaccineSet = new Set<Map<String,String>>();
  static Set<Map<String,String>> dosesSet = new Set<Map<String,String>>();

  static var sponsorNames = "";
  static var institutionNames = "";

  static Future<List<Map<String, String>>> getVaccineCandidates() async {
    var response = await http.get('https://disease.sh/v3/covid-19/vaccine');
    if(response.statusCode == 200){
      var jsonResponse = convert.jsonDecode(response.body);
      var vaccineListLength = jsonResponse['data'].length;

        for(int j=0;j<vaccineListLength;j++){
          for(int i=0;i<jsonResponse['data'][j]['sponsors'].length;i++) {
            sponsorNames = jsonResponse['data'][j]['sponsors'][i] + '&' + sponsorNames;
          }

          for(int k=0;k<jsonResponse['data'][j]['institutions'].length;k++) {
            institutionNames = jsonResponse['data'][j]['institutions'][k] + '&' + institutionNames;
          }

            vaccineMap = {
              "candidate" : jsonResponse['data'][j]['candidate'],
              "mechanism" : jsonResponse['data'][j]['mechanism'],
              "sponsors" : sponsorNames,
              "details" : jsonResponse['data'][j]['details'],
              "trialPhase" : jsonResponse['data'][j]['trialPhase'],
              "institutions" : institutionNames
            };
            vaccineSet.add(vaccineMap);
        }

      return vaccineSet.toList();
    }
  }


  static Map<String, String> dosesByCountryHeaders = {
    'lastdays': '30',
  };

  static Future<List<Map<String, String>>> getDosesByCountry() async{
    var response = await http.get("https://disease.sh/v3/covid-19/vaccine/coverage/countries?lastdays=30", headers: dosesByCountryHeaders);

    if(response.statusCode == 200){
      var jsonResponse = convert.jsonDecode(response.body);

      for(int j=0;j<jsonResponse.length;j++){

        dosesMap = {
          "country" : jsonResponse[j]['country'],
          "lastDoseCount" : jsonResponse[j]['timeline'].values.toList()[jsonResponse[j]['timeline'].length - 1].toString(),    //getting the no. of doses for the most recent date
        };
        dosesSet.add(dosesMap);
      }
      return dosesSet.toList();
    }
  }


}