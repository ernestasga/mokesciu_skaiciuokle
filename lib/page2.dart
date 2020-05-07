import 'package:flutter/material.dart';
import './formulas.dart';

class Page2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Page2State();
  }
}

class _Page2State extends State<Page2> {
  double pajamos = 0;
  int sanauduTipas = 1;
  double sanaudos = 0.0; // custom or 0.3
  double taikomasGPM = 0.15;
  double pensijosImoka = 0; // 0 arba 0.021 arba 0.03
  bool _isSanaudosEnabled = false;


  final TextEditingController ptec = new TextEditingController();
  final TextEditingController stec = new TextEditingController();

  final TextEditingController pelnastec = new TextEditingController();

  List<double> mokesciai = [0, 0, 0, 0, 0, 0.05, 0, 0, 0];

  double sumoketasVSD = 0.0;
  double sumoketasPSD = 0.0;

  void _handleSanaudosValueChange(int v) {
    setState(() {
      sanauduTipas = v;
      if (sanauduTipas == 2) {
        _isSanaudosEnabled = true;
      } else {
        _isSanaudosEnabled = false;
        stec.text = '';
      }
    });
  }

  void _handleIndPensijosImokaValueChange(double value) {
    setState(() {
      pensijosImoka = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    mokesciai = IndividualiosVeiklosSkaiciuokle(
            pajamos, sanaudos, pensijosImoka, sanauduTipas)
        .getPelnas();
    pelnastec.text = mokesciai[6].toStringAsFixed(2);
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Container(child: Text('Individualios veiklos skaičiuoklė')),
        leading: Icon(Icons.arrow_left, size: 50,),
        actions: <Widget>[
          Icon(Icons.arrow_right, size: 50,)
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 60),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.all(10),
                      child: Text("Sąnaudu skaičiavimas",
                          style: TextStyle(fontSize: 20))),
                  Wrap(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text("30% nuo pajamų  "),
                          Radio(
                              value: 1,
                              groupValue: sanauduTipas,
                              onChanged: _handleSanaudosValueChange),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text("Faktiškai patirtos"),
                          Radio(
                            value: 2,
                            groupValue: sanauduTipas,
                            onChanged: _handleSanaudosValueChange,
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Flexible(
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: TextField(
                              controller: ptec,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 25, color: Colors.green),
                              onChanged: (text) {
                                setState(() {
                                  pajamos = double.parse(text);
                                });
                              },
                              decoration: InputDecoration(
                                  labelText: "Pajamos",
                                  prefixText: '€',
                                  prefixStyle:
                                  TextStyle(fontSize: 55, color: Colors.green)),
                            ),
                          )),
                      Flexible(
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: TextField(
                                enabled: _isSanaudosEnabled,
                                controller: stec,
                                keyboardType: TextInputType.number,
                                style: TextStyle(fontSize: 25, color: Colors.red),
                                onChanged: (text) {
                                  setState(() {
                                    sanaudos = double.parse(text);
                                  });
                                },
                                decoration: InputDecoration(
                                    labelText: "Sąnaudos",
                                    prefixText: '€',
                                    prefixStyle:
                                    TextStyle(fontSize: 55, color: Colors.red))),
                          )),
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.all(10),
                      child: Text("Pensijos kaupimas",
                          style: TextStyle(fontSize: 20))),
                  Wrap(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text("Nekaupiama"),
                          Radio(
                              value: 0.0,
                              groupValue: pensijosImoka,
                              onChanged: _handleIndPensijosImokaValueChange),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text("2.1%"),
                          Radio(
                            value: 0.021,
                            groupValue: pensijosImoka,
                            onChanged: _handleIndPensijosImokaValueChange,
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text("3.0%"),
                          Radio(
                            value: 0.03,
                            groupValue: pensijosImoka,
                            onChanged: _handleIndPensijosImokaValueChange,
                          )
                        ],
                      )
                    ],
                  ),

                ],
              ),
            ),
            Container(

              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                    child: Row(children: <Widget>[
                      Expanded(
                          child: Text('Pajamų suma: ',
                              style: TextStyle(fontSize: 20))),
                      Text('€' + pajamos.toStringAsFixed(2),
                          style: TextStyle(color: Colors.green, fontSize: 30))
                    ]),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                    child: Row(children: <Widget>[
                      Expanded(
                          child: Text('"Sodros" įmokų bazė (90 proc. pelno): ',
                              style: TextStyle(fontSize: 20))),
                      Text('€' + mokesciai[0].toStringAsFixed(2),
                          style: TextStyle(color: Colors.green, fontSize: 20))
                    ]),
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                      child:                Row(children: <Widget>[
                        Expanded(
                            child: Text('Apskaičiuotas VSD - 12.52%: ',
                                style: TextStyle(fontSize: 20))),
                        Text('€' + mokesciai[1].toStringAsFixed(2),
                            style: TextStyle(color: Colors.red, fontSize: 20))
                      ])
                  ),

                  Padding(padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                    child: Row(children: <Widget>[
                      Expanded(
                          child: Text('Apskaičiuotas PSD - 6.98%: ',
                              style: TextStyle(fontSize: 20))),
                      Text('€' + mokesciai[2].toStringAsFixed(2),
                          style: TextStyle(color: Colors.red, fontSize: 20))
                    ]),),



                  Padding(padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                    child: Row(children: <Widget>[
                      Expanded(
                          child: Text('Apskaičiuotas GPM',
                              style: TextStyle(fontSize: 20))),
                      Text((mokesciai[5]*100).toStringAsFixed(2)+'% - €' + mokesciai[4].toStringAsFixed(2),
                          style: TextStyle(color: Colors.red, fontSize: 20))
                    ]),),
                  Divider(color: Colors.black, thickness: 2,),

                  Padding(padding: EdgeInsets.fromLTRB(5, 10, 5, 10), child:
                  Row(children: <Widget>[
                    Expanded(child: Text('Viso mokesčių: ', style: TextStyle(fontSize: 20))),
                    Text('€' + (mokesciai[1]+mokesciai[2]+mokesciai[4]).toStringAsFixed(2),
                        style: TextStyle(color: Colors.red, fontSize: 20))
                  ]),),

                  Padding(padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                    child: Row(children: <Widget>[
                      Expanded(
                          child: Text('Papildomas pensijos kaupimas '+(pensijosImoka*100).toString()+'%',
                              style: TextStyle(fontSize: 20))),
                      Text('€' + mokesciai[3].toStringAsFixed(2),
                          style: TextStyle(color: Colors.red, fontSize: 20))
                    ]),),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.green,
                            width: 3
                        )
                    ),
                    child: Column(
                      children: <Widget>[Padding(
                          padding: EdgeInsets.all(10),
                          child: Container(
                              child: Text('Grynas pelnas',
                                  style: TextStyle(fontSize: 20)))),
                        Padding(
                          padding: EdgeInsets.fromLTRB(50, 5, 50, 5),
                          child: Center(
                              child: TextField(
                                enabled: false,
                                controller: pelnastec,
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                style: TextStyle(fontSize: 25, color: Colors.green),
                                decoration: InputDecoration(
                                    hintText: 'Grynas pelnas',
                                    prefixText: '€',
                                    prefixStyle:
                                    TextStyle(color: Colors.green, fontSize: 25)),
                              )),
                        )],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
