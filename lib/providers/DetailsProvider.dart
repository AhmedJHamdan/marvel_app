import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:marvel_app/models/DetailsDataModel.dart';
import 'package:marvel_app/models/DetailsResult.dart';

import '../models/SeriesDataModel.dart';

class DetailsProvider extends ChangeNotifier {
  int total;

  String _host = "http://gateway.marvel.com";
  String _getDetailsUrl = "/v1/public/series/";
  String creators = "/creators";
  String _privateKey = "7867c5346d5d62e8082c4895da3a142a4535b039";
  String _publicKey = "618ddfc4faac973d980d5d53ef3d6679";
  String timeStamp = "";
  String hash = "";
  DetailsDataModel detailsDataModel;
  List<DetailsResult> detailsList = new List<DetailsResult>();
  int offset = 0;
  int creatorsId=0;

  void setId(int creatorsId){
    this.creatorsId= creatorsId;
  }
  Future<List<DetailsResult>> getDetails() async {
    getTimeStamp();
    getHash();

    Map<String, dynamic> paras = {
      "apikey": _publicKey,
      "ts": timeStamp,
      "hash": hash,
      "offset": offset
    };

    Dio dio = Dio();
    final response = await dio.get(
      _host + _getDetailsUrl + "$creatorsId" + creators,
      queryParameters: paras,
    );
    print(response.statusCode);

    Map userMap = json.decode(response.toString());
    detailsDataModel = new DetailsDataModel.fromJson(userMap);

    if(detailsList.isEmpty)
    detailsList.addAll(detailsDataModel.data.results);
    print("The length is ${detailsList.length}");

    total = detailsDataModel.data.total;
    notifyListeners();
    return detailsList;

  }

  void clearList(){
    detailsList.clear();
  }
  void getHash() {
    var content =
        new Utf8Encoder().convert(timeStamp + _privateKey + _publicKey);
    var digest = md5.convert(content);
    hash = hex.encode(digest.bytes);
  }

  void getTimeStamp() {
    timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
  }
}
