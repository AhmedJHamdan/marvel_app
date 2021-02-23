import 'dart:io';

import 'package:fancy_drawer/fancy_drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marvel_app/models/DetailsResult.dart';
import 'package:marvel_app/models/SeriesDataModel.dart';
import 'package:marvel_app/providers/DetailsProvider.dart';

import 'package:provider/provider.dart';
import 'package:scaled_list/scaled_list.dart';

class DetailScreen extends StatefulWidget {
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  Results list;
  FancyDrawerController _controller;
  Future<List<DetailsResult>> listResult;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = FancyDrawerController(
        vsync: this, duration: Duration(milliseconds: 250))
      ..addListener(() {
        setState(() {}); // Must call setState
      });
  }
  @override
  void deactivate() {
    Provider.of<DetailsProvider>(context, listen: false).clearList();
    // TODO: implement deactivate
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    list = ModalRoute.of(context).settings.arguments;
    Provider.of<DetailsProvider>(context).setId(list.id);

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
              body: Consumer<DetailsProvider>(
                builder: (context ,details, child){
                  return ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Image.network(
                          list.thumbnail.path + "." + list.thumbnail.extension,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                                width: 100,
                                height: 100,
                                child: Image.asset("assets/loading.gif"));
                            // You can use LinearProgressIndicator or CircularProgressIndicator instead
                          },
                        ),
                      ),
                      SizedBox(height: 30),
                      Container(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          list.title,
                          style: GoogleFonts.montserrat(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(16),
                                child: Text(
                                  "Start Year:",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 16, fontWeight: FontWeight.w600),
                                ),
                              ),
                              Container(
                                child: Text(
                                  list.startYear.toString(),
                                  style: GoogleFonts.montserrat(
                                      fontSize: 16, fontWeight: FontWeight.w300),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(16),
                                child: Text(
                                  "End Year:",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 16, fontWeight: FontWeight.w600),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(16),
                                child: Text(
                                  list.endYear.toString(),
                                  style: GoogleFonts.montserrat(
                                      fontSize: 16, fontWeight: FontWeight.w300),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            "Creators",
                            style: GoogleFonts.montserrat(
                                fontSize: 32, fontWeight: FontWeight.w600),
                          )),

                    FutureBuilder<List<DetailsResult>>(
                      future: details.getDetails(),
                        builder:(BuildContext context, AsyncSnapshot<List<DetailsResult>> snapshot){
                      return ScaledList(itemBuilder: (index, selectedIndex){
                        final category = details.detailsList[index];
                        return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            Container(
                            height: selectedIndex == index ? 250 : 120,
                            child: Image.network(category.thumbnail.path+"."+ category.thumbnail.extension),
                        ),
                        SizedBox(height: 15),
                        Text(
                        category.fullName,
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                            fontSize: selectedIndex == index ? 25 : 20
                        ),
                        )
                        ]);
                      },


                          itemCount: details.detailsList.length, itemColor:(index){return Color(0xFFED1D24);});
                    })

                    ],
                  );
                },

              ),
            )));
  }
}
