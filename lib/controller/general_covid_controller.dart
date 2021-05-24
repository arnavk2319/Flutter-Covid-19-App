import 'dart:convert' as convert;
import 'dart:core';

class GeneralCovidController {

  static Map generalCovidInfo = new Map();

  static Map getGeneralCovidInfo() {

    generalCovidInfo = {
    "overview" : "Coronavirus disease (COVID-19) is an infectious disease caused by a newly discovered coronavirus. Most people infected with the COVID-19 virus will experience mild to moderate respiratory illness and recover without requiring special treatment.  Older people, and those with underlying medical problems like cardiovascular disease, diabetes, chronic respiratory disease, and cancer are more likely to develop serious illness.The best way to prevent and slow down transmission is to be well informed about the COVID-19 virus, the disease it causes and how it spreads. Protect yourself and others from infection by washing your hands or using an alcohol based rub frequently and not touching your face.The COVID-19 virus spreads primarily through droplets of saliva or discharge from the nose when an infected person coughs or sneezes, so it’s important that you also practice respiratory etiquette (for example, by coughing into a flexed elbow).",
    "preventionGuideline" : "To prevent infection and to slow transmission of COVID-19, do the following:",
    "preventions" : [
      "Wash your hands regularly with soap and water, or clean them with alcohol-based hand rub.",
      "Maintain at least 1 metre distance between you and people coughing or sneezing.",
      "Avoid touching your face.",
      "Cover your mouth and nose when coughing or sneezing.",
      "Stay home if you feel unwell.",
      "Refrain from smoking and other activities that weaken the lungs.",
      "Practice physical distancing by avoiding unnecessary travel and staying away from large groups of people."
    ],
      "symptomsOverview" : "COVID-19 affects different people in different ways. Most infected people will develop mild to moderate illness and recover without hospitalization.",
      "mostCommonSymptoms" : [
        "fever",
        "dry cough",
        "tiredness"
      ],
      "lessCommonSymptoms" : [
        "aches and pains",
        "sore throat",
        "diarrhoea",
        "conjunctivitis",
        "headache",
        "loss of taste or smell",
        "a rash on skin, or discolouration of fingers or toes"
      ],
      "seriousSymptoms" : [
        "difficulty breathing or shortness of breath",
        "chest pain or pressure",
        "loss of speech or movement",
        "conjunctivitis",
        "headache",
        "loss of taste or smell",
        "a rash on skin, or discolouration of fingers or toes"
      ],
      "symptomsGuidelines" : "Seek immediate medical attention if you have serious symptoms.  Always call before visiting your doctor or health facility. People with mild symptoms who are otherwise healthy should manage their symptoms at home. On average it takes 5–6 days from when someone is infected with the virus for symptoms to show, however it can take up to 14 days.",
    };

    return generalCovidInfo;

  }
}