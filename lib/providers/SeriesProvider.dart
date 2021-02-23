import 'dart:convert';
import 'dart:math';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../models/SeriesDataModel.dart';

class SeriesProvider extends ChangeNotifier {
  int total;
  String _host = "http://gateway.marvel.com";
  String _getCharactersUrl = "/v1/public/series";
  String _privateKey = "ef0396921b5d865d32c0879ee8d871aa87d77858";
  String _publicKey = "f8b9eb38a7e5467135610868cb849404";
  String timeStamp = "";
  String hash = "";
  SeriesDataModel seriesDataModel;
  List<Results> seriesList = new List<Results>();
  int offset = 0;

  Future<List<Results>> getSeries() async {
    getTimeStamp();
    getHash();

    Map<String, dynamic> paras = {
      "apikey": _publicKey,
      "ts": timeStamp,
      "hash": hash,
      "offset": offset,
      "limit": 20
    };

    Dio dio = Dio();
    final response = await dio.get(
      _host + _getCharactersUrl,
      queryParameters: paras,
    );
    print(response.statusCode);

    Map userMap = json.decode(response.toString());
    seriesDataModel = new SeriesDataModel.fromJson(userMap);

    seriesList.addAll(seriesDataModel.data.results);
    print("The length is ${seriesList.length}");
    offset = offset + seriesDataModel.data.count;

    total = seriesDataModel.data.total;
    return seriesList;
  }

  Future<void> getMore(RefreshController refreshController) async {
    getTimeStamp();
    getHash();

    Map<String, dynamic> paras = {
      "apikey": _publicKey,
      "ts": timeStamp,
      "hash": hash,
      "offset": offset,
      "limit": 20
    };

    Dio dio = Dio();
    final response = await dio.get(
      _host + _getCharactersUrl,
      queryParameters: paras,
    );
    print(response.statusCode);

    Map userMap = json.decode(response.toString());
    seriesDataModel = new SeriesDataModel.fromJson(userMap);

    seriesList.addAll(seriesDataModel.data.results);
    print("The length is ${seriesList.length}");
    offset = offset + seriesDataModel.data.count;
    total = seriesDataModel.data.total;
    refreshController.loadComplete();
    notifyListeners();
  }

  Future<void> getFresh(RefreshController refreshController) async {
    getTimeStamp();
    getHash();
    offset = Random().nextInt(7500);

    Map<String, dynamic> paras = {
      "apikey": _publicKey,
      "ts": timeStamp,
      "hash": hash,
      "offset": offset,
      "limit": 20
    };

    Dio dio = Dio();
    final response = await dio.get(
      _host + _getCharactersUrl,
      queryParameters: paras,
    );
    print(response.statusCode);

    Map userMap = json.decode(response.toString());
    seriesDataModel = new SeriesDataModel.fromJson(userMap);
    seriesList.clear();
    seriesList.addAll(seriesDataModel.data.results);
    print("The length is ${seriesList.length}");

    total = seriesDataModel.data.total;
    offset = offset + seriesDataModel.data.count;
    refreshController.refreshCompleted(resetFooterState: true);
    notifyListeners();
    return seriesList;
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
