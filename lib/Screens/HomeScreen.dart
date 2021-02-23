import 'dart:convert';
import 'dart:math';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:fancy_drawer/fancy_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:marvel_app/models/SeriesDataModel.dart';
import 'package:marvel_app/providers/SeriesProvider.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  ScrollController sc = ScrollController();
  Future<List<Results>> list;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  FancyDrawerController _controller;
  List<Results> nList;

  void onLoading() async {
    await Provider.of<SeriesProvider>(context, listen: false)
        .getMore(_refreshController);
    print("is loading");
  }

  void onRefresh() async {
    await Provider.of<SeriesProvider>(context, listen: false)
        .getFresh(_refreshController);
    print("is refreshing");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    list = Provider.of<SeriesProvider>(context, listen: false).getSeries();
    _controller = FancyDrawerController(
        vsync: this, duration: Duration(milliseconds: 250))
      ..addListener(() {
        setState(() {}); // Must call setState
      });
    getList();
  }

  void getList() async {
    nList = await list;
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return Material(
      child: FancyDrawerWrapper(
        backgroundColor: Colors.black, // Drawer background
        controller: _controller, // Drawer controller
        drawerItems: <Widget>[
          Text("Home"),
          Text("Settings"),
          Text("Support"),
        ],
        child: Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              centerTitle: true,
              leading: IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                onPressed: () {
                  _controller.toggle();
                },
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Container(
                  width: 110,
                  child: Image.asset(
                    "assets/marvellogo.png",
                  )),
            ),
            body: RefreshConfiguration(
              footerTriggerDistance: 15,
              dragSpeedRatio: 0.91,
              child: FutureBuilder<List<Results>>(
                future: list,
                builder: (BuildContext context,
                    AsyncSnapshot<List<Results>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/loading.gif"),
                          Text("Loading Your Marvel Heroes")
                        ],
                      ),
                    );
                  return Consumer<SeriesProvider>(
                    builder: (context, series, child) {
                      return SmartRefresher(
                          physics: BouncingScrollPhysics(),
                          controller: _refreshController,
                          enablePullDown: true,
                          enablePullUp: true,
                          header: WaterDropMaterialHeader(),
                          onLoading: onLoading,
                          onRefresh: onRefresh,
                          child: GridView.builder(
                              padding:
                                  EdgeInsets.only(top: 30, right: 5, left: 5),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 20,
                                      crossAxisSpacing: 5),
                              itemCount: series.seriesList.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pushNamed(
                                              "/details",
                                              arguments: nList[index]);
                                        },
                                        child: Image.network(
                                          series.seriesList[index].thumbnail
                                                  .path +
                                              "." +
                                              series.seriesList[index].thumbnail
                                                  .extension,
                                          fit: BoxFit.cover,
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
                                            if (loadingProgress == null)
                                              return child;
                                            return Container(
                                                width: 100,
                                                height: 100,
                                                child: Image.asset(
                                                    "assets/loading.gif"));
                                            // You can use LinearProgressIndicator or CircularProgressIndicator instead
                                          },
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                            margin: EdgeInsets.only(top: 5),
                                            child: Text(
                                              series.seriesList[index].title,
                                              textAlign: TextAlign.center,
                                            )))
                                  ],
                                );
                              }));
                    },
                  );
                },
              ),
            )),
      ),
    );
  }
}
