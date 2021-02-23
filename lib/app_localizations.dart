import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations{
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of (BuildContext context){
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }
  static const LocalizationsDelegate<AppLocalizations> delegate= _AppLocalizationDeleagte();

  Map<String, String> _localizedStrings;

  Future<bool> load() async{
    String jsonString= await rootBundle.loadString("lang/${locale.languageCode}.json");
    Map<String,dynamic> jsonMap= json.decode(jsonString);
    _localizedStrings= jsonMap.map((key, value){
      return MapEntry(key, value.toString());
    });
    return true;
  }

  String translate(String key){
    return _localizedStrings[key];
  }

}

class _AppLocalizationDeleagte extends LocalizationsDelegate<AppLocalizations>{
  const _AppLocalizationDeleagte();

  @override
  bool isSupported(Locale locale) {
    // TODO: implement isSupported
    return ['en', 'es'].contains(locale.languageCode);
  }
  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations= new AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }
  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old)=> false;

}
