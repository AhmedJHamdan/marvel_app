import 'package:flutter/material.dart';
import 'package:marvel_app/Screens/DetailScreen.dart';
import 'package:marvel_app/providers/DetailsProvider.dart';
import 'package:marvel_app/providers/SeriesProvider.dart';
import 'package:provider/provider.dart';

import 'Screens/HomeScreen.dart';

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
        },
        theme: ThemeData(
          backgroundColor: Colors.black,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
        ),
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        home:  HomeScreen());
  }
}
