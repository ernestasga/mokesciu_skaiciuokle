import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_view_indicators/arrow_page_indicator.dart';
import './main.dart';
import 'package:firebase_admob/firebase_admob.dart';

import './formulas.dart';

class Page1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Page1State();
  }
}

class _Page1State extends State<Page1> {
  double NPD = 0.0; // auto, 600, 640
  double pensijosImoka = 0.03; // 0 arba 0.021 arba 0.03
  double darbdavioGrupe = 0.0014; // I 0.0014 II 0.004 III 0.007 IV 0.014
  double sutartiesRusis = 0.0; // neterminuota 0, terminuota 0.0072
  List<double> mokesciai = [0, 0, 0, 0, 0, 0, 0, 0];

  double iRankas;
  double antPopieriaus;
  bool editingAntPop = false;
  bool editiniRankas = false;
  final TextEditingController irtec = new TextEditingController();
  final TextEditingController aptec = new TextEditingController();

  void setIRankas() {
    if (!aptec.text.isEmpty) {
      var skaiciuokle =
          AtlyginimuSkaiciuokle(pensijosImoka, darbdavioGrupe, sutartiesRusis);
      skaiciuokle.setAntPopieriaus(double.parse(aptec.text));
      skaiciuokle.setNpd(NPD);
      mokesciai = skaiciuokle.getIRankas();
      iRankas = mokesciai[4];
      editingAntPop = true;
      editiniRankas = false;
    }
  }

  void _handleSutartiesRusisValueChange(double value) {
    setState(() {
      sutartiesRusis = value;
      setIRankas();
    });
  }

  void _handleNPDValueChange(double value) {
    setState(() {
      NPD = value;
      setIRankas();
    });
  }

  void _handlePensijosImokaValueChanger(double value) {
    setState(() {
      pensijosImoka = value;
      setIRankas();
    });
  }

  void _handleDarbdavioGrupeValueChanger(double value) {
    setState(() {
      darbdavioGrupe = value;
      setIRankas();
    });
  }


  @override
  Widget build(BuildContext context) {

    if (antPopieriaus != null && !editingAntPop) {
      aptec.text = antPopieriaus.toStringAsFixed(2);
    }
    if (iRankas != null && !editiniRankas) {
      irtec.text = iRankas.toStringAsFixed(2);
    }
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          title: Center(child: Text('Atlyginimų Skaičiuoklė ')),
        actions: <Widget>[
          Icon(Icons.arrow_right, size: 50,)
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 60),
        child: ListView(

          children: <Widget>[

            Container(

                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: Text("Darbo sutarties rūšis",
                              style: TextStyle(fontSize: 20))),
                      Wrap(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text("Neterminuota  "),
                              Radio(
                                  value: 0.0,
                                  groupValue: sutartiesRusis,
                                  onChanged: _handleSutartiesRusisValueChange),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text("Terminuota"),
                              Radio(
                                value: 0.0072,
                                groupValue: sutartiesRusis,
                                onChanged: _handleSutartiesRusisValueChange,
                              )
                            ],
                          )
                        ],
                      ),
                      Padding(
                          padding: EdgeInsets.all(10),
                          child:
                          Text("Taikomas NPD", style: TextStyle(fontSize: 20))),
                      Row(
                        children: <Widget>[
                          Text("Apskaičiuoti automatiškai"),
                          Radio(
                              value: 0.0,
                              groupValue: NPD,
                              onChanged: _handleNPDValueChange),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text("30-55% darbingumas"),
                          Radio(
                            value: 600.0,
                            groupValue: NPD,
                            onChanged: _handleNPDValueChange,
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text("0-25% darbingumas"),
                          Radio(
                            value: 645.0,
                            groupValue: NPD,
                            onChanged: _handleNPDValueChange,
                          ),
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
                                  onChanged: _handlePensijosImokaValueChanger),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text("2.1%"),
                              Radio(
                                value: 0.021,
                                groupValue: pensijosImoka,
                                onChanged: _handlePensijosImokaValueChanger,
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text("3.0%"),
                              Radio(
                                value: 0.03,
                                groupValue: pensijosImoka,
                                onChanged: _handlePensijosImokaValueChanger,
                              )
                            ],
                          )
                        ],
                      ),
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(' Darbdavio įmokos Sodrai grupė',
                              style: TextStyle(fontSize: 20))),
                      Wrap(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text("I (0.14%)  "),
                              Radio(
                                  value: 0.0014,
                                  groupValue: darbdavioGrupe,
                                  onChanged: _handleDarbdavioGrupeValueChanger),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text("II (0.4%)  "),
                              Radio(
                                  value: 0.004,
                                  groupValue: darbdavioGrupe,
                                  onChanged: _handleDarbdavioGrupeValueChanger),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text("III (0.7%)  "),
                              Radio(
                                  value: 0.007,
                                  groupValue: darbdavioGrupe,
                                  onChanged: _handleDarbdavioGrupeValueChanger),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text("IV (1.4%)"),
                              Radio(
                                  value: 0.014,
                                  groupValue: darbdavioGrupe,
                                  onChanged: _handleDarbdavioGrupeValueChanger),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(50, 5, 50, 5),
                      child: Center(
                          child: TextField(
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 25, color: Colors.green),
                            controller: aptec,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                hintText: 'Atlyginimas ant popieriaus',
                                prefixText: '€',
                                prefixStyle:
                                TextStyle(color: Colors.green, fontSize: 25)),
                            onChanged: (text) {
                              setState(() {
                                setIRankas();
                              });
                            },
                          )),
                    ),
                    Center(
                      child: Text('"Ant popieriaus"'),
                    ),
                    Center(
                      child: Icon(Icons.arrow_downward),
                    ),
                    Container(

                      child: Column(
                        children: <Widget>[
                          Row(children: <Widget>[
                            Expanded(child: Text('Taikomas NPD: ', style: TextStyle(fontSize: 20),)),
                            Text('€' + mokesciai[6].toStringAsFixed(2),
                                style: TextStyle(color: Colors.red, fontSize: 20))
                          ]),
                          Padding(
                              padding: EdgeInsets.all(10),
                              child: Container(
                                  child: Text('Darbuotojo mokami mokesčiai',
                                      style: TextStyle(fontSize: 25)))),
                          Row(children: <Widget>[
                            Expanded(child: Text('GPM - 20%: ', style: TextStyle(fontSize: 20))),
                            Text('€' + mokesciai[0].toStringAsFixed(2),
                                style: TextStyle(color: Colors.red, fontSize: 20))
                          ]),
                          Row(children: <Widget>[
                            Expanded(child: Text('PSD - 6.98%: ', style: TextStyle(fontSize: 20))),
                            Text('€' + mokesciai[1].toStringAsFixed(2),
                                style: TextStyle(color: Colors.red, fontSize: 20))
                          ]),
                          Row(children: <Widget>[
                            Expanded(child:  Text('VSD - 12.52%: ', style: TextStyle(fontSize: 20))),
                            Text('€' + mokesciai[2].toStringAsFixed(2),
                                style: TextStyle(color: Colors.red, fontSize: 20))
                          ]),
                          Row(children: <Widget>[
                            Expanded(child: Text('Pensijos kaupimas ' +
                                (pensijosImoka * 100).toStringAsFixed(2) +
                                '%: ', style: TextStyle(fontSize: 20))),
                            Text('€' + mokesciai[3].toStringAsFixed(2),
                                style: TextStyle(color: Colors.red, fontSize: 20))
                          ]),
                          Divider(color: Colors.black, thickness: 2,),
                          Row(children: <Widget>[
                            Expanded(child: Text('Viso mokesčių: ', style: TextStyle(fontSize: 20))),
                            Text('€' + (mokesciai[0]+mokesciai[1]+mokesciai[2]+mokesciai[3]).toStringAsFixed(2),
                                style: TextStyle(color: Colors.red, fontSize: 20))
                          ]),

                          Padding(
                              padding: EdgeInsets.all(10),
                              child: Container(
                                  child: Text('Darbdavio mokami mokesčiai',
                                      style: TextStyle(fontSize: 25)))),
                          Row(children: <Widget>[
                            Expanded(child: Text('Įmokos "Sadrai": ', style: TextStyle(fontSize: 20))),
                            Text('€' +mokesciai[5].toStringAsFixed(2),
                                style: TextStyle(color: Colors.red, fontSize: 20))
                          ]),
                          Padding(padding: EdgeInsets.all(15), child: Row(children: <Widget>[
                            Expanded(child: Text('Darbo vietos kaina: ',
                                style: TextStyle(fontSize: 25))),
                            Text('€' +mokesciai[7].toStringAsFixed(2),
                                style: TextStyle(color: Colors.red, fontSize: 25))
                          ],))
                        ],
                      ),
                    ),
                    Center(
                      child: Icon(Icons.arrow_upward),
                    ),
                    Center(
                      child: Text('"Į rankas"'),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(50, 5, 50, 5),
                      child: Center(
                          child: TextField(
                            enabled: false,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            style: TextStyle(fontSize: 25, color: Colors.green),
                            decoration: InputDecoration(
                                hintText: 'Atlyginimas į rankas',
                                prefixText: '€',
                                prefixStyle:
                                TextStyle(color: Colors.green, fontSize: 25)),
                            controller: irtec,
                            onChanged: (text) {
                              setState(() {
                                var skaiciuokle = AtlyginimuSkaiciuokle(
                                    pensijosImoka, darbdavioGrupe, sutartiesRusis);
                                skaiciuokle.setIRankas(double.parse(text));
                                antPopieriaus = double.parse(text) / 2;
                                editiniRankas = true;
                                editingAntPop = false;
                              });
                            },
                          )),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}
