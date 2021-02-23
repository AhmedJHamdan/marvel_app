import 'package:flutter/material.dart';
import 'package:marvel_app/Screens/ConfigurationScreen.dart';
import 'package:marvel_app/Screens/DetailScreen.dart';
import 'package:marvel_app/Screens/SupportScreen.dart';
import 'package:marvel_app/providers/DetailsProvider.dart';
import 'package:marvel_app/providers/SeriesProvider.dart';
import 'package:marvel_app/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'Screens/HomeScreen.dart';
import 'app_localizations.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(
      MultiProvider(providers: [
        ChangeNotifierProvider<SeriesProvider>(
            create: (BuildContext context) => SeriesProvider()),
        ChangeNotifierProvider<DetailsProvider>(
            create: (BuildContext context) => DetailsProvider())
      ],
      child:MyApp() )
      );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        routes: <String, WidgetBuilder>{
          '/home': (BuildContext context) => new HomeScreen(),
          '/details': (BuildContext context) => new DetailScreen(),
          '/configuration': (BuildContext context) => new ConfigurationScreen(),
          '/support': (BuildContext context) => new SupportScreen(),



        },
        theme: ThemeData(
          backgroundColor: Colors.black,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
        ),
        supportedLocales: [
          Locale("en", "US"),
          Locale("es", "ES")
        ],
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales){
          for(var supportedLocale in supportedLocales){
            if(supportedLocale.languageCode==locale.languageCode &&
            supportedLocale.countryCode == locale.countryCode
            ){
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        home:  Splash_widget());
  }
}
