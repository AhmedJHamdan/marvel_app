import 'package:fancy_drawer/fancy_drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marvel_app/app_localizations.dart';

class SupportScreen extends StatefulWidget {
  @override
  _SupportScreenState createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> with SingleTickerProviderStateMixin{
  FancyDrawerController _controller;

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
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      child: FancyDrawerWrapper(
          backgroundColor: Colors.black, // Drawer background
          controller: _controller, // Drawer controller
          drawerItems: <Widget>[
            GestureDetector(
                onTap:(){
                  Navigator.of(context).pushNamed("/home");
                },
                child: Text(AppLocalizations.of(context).translate("home"), style: GoogleFonts.montserrat(),)),
            GestureDetector(
                onTap:(){
                  Navigator.of(context).pushNamed("/configuration",);
                },
                child: Text(AppLocalizations.of(context).translate("settings"),style: GoogleFonts.montserrat(),)),
            GestureDetector(
                onTap: (){
                  Navigator.of(context).pushNamed("/support");
                },
                child: Text(AppLocalizations.of(context).translate("support"),style: GoogleFonts.montserrat(),)),
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
      )
      )
      ,
      )
      ,
        body: Center(
          child: Text(
            AppLocalizations.of(context).translate("support"), style: GoogleFonts.montserrat(),

          ),
        ),
      )),
    );
  }
}
