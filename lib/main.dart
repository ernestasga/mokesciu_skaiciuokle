import 'package:atlyginimuskaiciuokle/page1Orientations.dart';
import 'package:atlyginimuskaiciuokle/page2Orientations.dart';
import 'package:atlyginimuskaiciuokle/page3Orientations.dart';
import 'package:flutter/material.dart';
import './page1.dart';
import './page2.dart';
import './page3.dart';
import './ads.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_admob/firebase_admob.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('lt', 'LT'),
      ],
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget _buildPortrait(){
    return Theme(
      data: ThemeData.dark(),
      child: PageView(
        children: <Widget>[
          Page1Portrait(),
          Page2Portrait(),
          Page3Portrait()
        ],
      ),
    );
  }
  Widget _buildLandscape(){
    return Theme(
      data: ThemeData.dark(),
      child: PageView(
        children: <Widget>[
          Page1Landscape(),
          Page2Landscape(),
          Page3Landscape()
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    Ads().start(true);
    return OrientationBuilder(
      builder: (context, orientation){
        return orientation == Orientation.portrait ? _buildPortrait() : _buildLandscape();
      },
    );
  }
}
