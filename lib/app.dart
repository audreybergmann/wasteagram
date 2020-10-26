import 'package:flutter/material.dart';
import 'package:wasteagram/screens/list_screen.dart';
import 'package:wasteagram/screens/photo_screen.dart';
import 'package:wasteagram/screens/detail_screen.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    final routes = {
      DetailState.routeName: (context) => Detail(),
      ListScreenState.routeName: (context) => ListScreen(),
      PhotoState.routeName: (context) => Photo()
    };

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: routes,
      //home: ListScreen(),
    );
  }
}
