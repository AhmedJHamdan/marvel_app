import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marvel_app/Screens/HomeScreen.dart';
import 'package:marvel_app/app_localizations.dart';
import 'package:splashscreen/splashscreen.dart';

class Splash_widget extends StatefulWidget {
  @override
  _Splash_widgetState createState() => _Splash_widgetState();
}

class _Splash_widgetState extends State<Splash_widget> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 3,
      navigateAfterSeconds: new HomeScreen(),
      loadingText: new Text(
      AppLocalizations.of(context).translate("splash_screen"),
        style:GoogleFonts.montserrat(),
      ),
      image: new Image.asset(
          'assets/marvel-logo-4.png',fit: BoxFit.cover,),
      photoSize: 120,


      backgroundColor: Colors.black,
      loaderColor: Color(0xFFED1D24),
    );
  }
  }


