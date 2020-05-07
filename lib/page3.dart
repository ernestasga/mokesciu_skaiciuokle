import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:jiffy/jiffy.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class Page3 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Page3State();
  }
}

class _Page3State extends State<Page3> {
  DateTime gimimoData = DateTime(1960, 1, 1);
  String lytis = 'Vyras';
  DateTime pensijosData = DateTime(2025, 1, 1);
  String pensijosAmzius = '65 metai';
  List<List<DateTime>> list;
  List<String> months = [
    'Sausio',
    'Vasario',
    'Kovo',
    'Balandžio',
    'Gegužės',
    'Birželio',
    'Liepos',
    'Rugpjūčio',
    'Rugsėjo',
    'Spalio',
    'Lapkričio',
    'Gruodžio'
  ];
  void _handlelytisValueChange(String l) {
    setState(() {
      lytis = l;
      _setPensijosAzius(gimimoData);
    });
  }

  void _setPensijosAzius(DateTime bd) {
    if (lytis == 'Vyras') {
      list = [
        [
          new DateTime(1952, 1, 1),
          new DateTime(1952, 10, 31),
          new DateTime(bd.year + 63, bd.month + 2, bd.day)
        ],
        [
          new DateTime(1952, 11, 1),
          new DateTime(1953, 8, 31),
          new DateTime(bd.year + 63, bd.month + 4, bd.day)
        ],
        [
          new DateTime(1953, 9, 1),
          new DateTime(1954, 6, 30),
          new DateTime(bd.year + 63, bd.month + 6, bd.day)
        ],
        [
          new DateTime(1954, 7, 1),
          new DateTime(1955, 4, 30),
          new DateTime(bd.year + 63, bd.month + 8, bd.day)
        ],
        [
          new DateTime(1955, 5, 1),
          new DateTime(1956, 2, 29),
          new DateTime(bd.year + 63, bd.month + 10, bd.day)
        ],
        [
          new DateTime(1956, 3, 1),
          new DateTime(1956, 12, 31),
          new DateTime(bd.year + 64, bd.month, bd.day)
        ],
        [
          new DateTime(1957, 1, 1),
          new DateTime(1957, 10, 31),
          new DateTime(bd.year + 64, bd.month + 2, bd.day)
        ],
        [
          new DateTime(1957, 11, 1),
          new DateTime(1958, 8, 31),
          new DateTime(bd.year + 64, bd.month + 4, bd.day)
        ],
        [
          new DateTime(1958, 9, 1),
          new DateTime(1959, 6, 30),
          new DateTime(bd.year + 64, bd.month + 6, bd.day)
        ],
        [
          new DateTime(1959, 7, 1),
          new DateTime(1960, 4, 30),
          new DateTime(bd.year + 64, bd.month + 8, bd.day)
        ],
        [
          new DateTime(1960, 5, 1),
          new DateTime(1961, 2, 28),
          new DateTime(bd.year + 64, bd.month + 10, bd.day)
        ],
        [
          new DateTime(1961, 3, 1),
          new DateTime(1961, 3, 1),
          new DateTime(bd.year + 65, bd.month, bd.day)
        ],
      ];
    } else {
      list = [
        [
          new DateTime(1954, 1, 1),
          new DateTime(1954, 8, 31),
          new DateTime(bd.year + 61, bd.month + 4, bd.day)
        ],
        [
          new DateTime(1954, 9, 1),
          new DateTime(1955, 4, 30),
          new DateTime(bd.year + 61, bd.month + 8, bd.day)
        ],
        [
          new DateTime(1955, 5, 1),
          new DateTime(1955, 12, 31),
          new DateTime(bd.year + 62, bd.month, bd.day)
        ],
        [
          new DateTime(1956, 1, 1),
          new DateTime(1956, 8, 31),
          new DateTime(bd.year + 62, bd.month + 4, bd.day)
        ],
        [
          new DateTime(1956, 9, 1),
          new DateTime(1957, 4, 30),
          new DateTime(bd.year + 62, bd.month + 8, bd.day)
        ],
        [
          new DateTime(1957, 5, 1),
          new DateTime(1957, 12, 31),
          new DateTime(bd.year + 63, bd.month, bd.day)
        ],
        [
          new DateTime(1958, 1, 1),
          new DateTime(1958, 8, 31),
          new DateTime(bd.year + 63, bd.month + 4, bd.day)
        ],
        [
          new DateTime(1958, 9, 1),
          new DateTime(1959, 4, 30),
          new DateTime(bd.year + 63, bd.month + 8, bd.day)
        ],
        [
          new DateTime(1959, 5, 1),
          new DateTime(1959, 12, 31),
          new DateTime(bd.year + 64, bd.month, bd.day)
        ],
        [
          new DateTime(1960, 1, 1),
          new DateTime(1960, 8, 31),
          new DateTime(bd.year + 64, bd.month + 4, bd.day)
        ],
        [
          new DateTime(1960, 9, 1),
          new DateTime(1961, 4, 30),
          new DateTime(bd.year + 64, bd.month + 8, bd.day)
        ],
        [
          new DateTime(1961, 5, 1),
          new DateTime(1961, 12, 31),
          new DateTime(bd.year + 65, bd.month, bd.day)
        ],
      ];
    }

    if (bd.isAfter(list.last[1])) {
      pensijosData = DateTime(bd.year + 65, bd.month, bd.day);
    } else if (bd.isBefore(list[0][0])) {
      pensijosData = DateTime(bd.year + 63, bd.month + 2, bd.day);
    } else {
      for (var i in list) {
        if (bd.isAfter(i[0]) && bd.isBefore(i[1])) {
          pensijosData = i[2];
        }
      }
    }
    var m = Jiffy(pensijosData).diff(bd, Units.YEAR);
    var mm = Jiffy(pensijosData).diff(bd, Units.MONTH) % m;

    pensijosAmzius = m.toString()+' metai ';
    if(mm!=0){
      pensijosAmzius = pensijosAmzius+'ir '+mm.toString()+' mėn';

    }

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Senatvės pensijos amžiaus skaičiuoklė'),
        leading: Icon(Icons.arrow_left, size: 50,),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 60),
        child: ListView(
          children: <Widget>[
            Center(
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                      child:
                      Text('Gimimo data', style: TextStyle(fontSize: 25)))),
            ),
            Container(
              height: 200,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,

                initialDateTime: DateTime(1960, 1, 1),
                onDateTimeChanged: (DateTime newDateTime) {
                  setState(() {
                    gimimoData = newDateTime;
                    _setPensijosAzius(gimimoData);
                  });
                },
              ),
            ),
            Center(
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                      child: Text('Lytis', style: TextStyle(fontSize: 25)))),
            ),
            Center(
                child: Wrap(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text("Vyras  "),
                        Radio(
                          value: 'Vyras',
                          groupValue: lytis,
                          onChanged: _handlelytisValueChange,
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text("Moteris"),
                        Radio(
                          value: 'Moteris',
                          groupValue: lytis,
                          onChanged: _handlelytisValueChange,
                        )
                      ],
                    )
                  ],
                )),
            Container(

              child: Column(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                      child: Text('Senatvės pensijos amžius ',
                          style: TextStyle(fontSize: 20))),
                  Text(pensijosAmzius, style:
                  TextStyle(fontSize: 30, color: Colors.purple),),
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                      child:  Text('Senatvės pensijos amžiaus sulauksite ',
                          style: TextStyle(fontSize: 20))
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                      child: Text(pensijosData.year.toString()+' '+months[pensijosData.month-1]+' '+pensijosData.day.toString(),
                          style: TextStyle(fontSize: 30, color: Colors.purple))),
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}
