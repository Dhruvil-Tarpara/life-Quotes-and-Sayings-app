import 'package:flutter/material.dart';
import 'package:quotes/screens/details_page.dart';
import 'package:quotes/screens/list_page.dart';
import 'package:quotes/screens/quotes_page.dart';
import 'package:quotes/screens/splash_page.dart';
import 'package:quotes/screens/home_page.dart';


void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      initialRoute: "/",
      routes: {
        "Splash" : (context) => const SplashPage(),
        "/": (context) => const HomePage(),
        "list_page" : (context) => const ListPage(),
        "quotes_page": (context) => const QuotesPage(),
        "details_page" : (context) => const DetailsPage(),
      },
    ),
  );
}
