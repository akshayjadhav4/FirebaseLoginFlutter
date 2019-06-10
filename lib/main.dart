import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'SignUpPage.dart';
import 'SignInPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Login',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple
      ),
      home: HomePage(),
      routes: <String, WidgetBuilder>{
        "/SignInPage":(BuildContext context) =>SignInPage(),
        "/SignUpPage":(BuildContext context) =>SignUpPage()
      },
    );
  }
}