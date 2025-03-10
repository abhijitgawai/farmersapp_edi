import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';

class Fertilizer extends StatefulWidget {
  @override
  _PredModelState createState() => _PredModelState();
}

class Usertemp {
  //dropdown //change User to usertemp
  const Usertemp(this.name);
  final String name;
}

class _PredModelState extends State<Fertilizer> {
  var predValue = "";
  @override
  void initState() {
    super.initState();
    predValue = "click predict button";
  }

  final N_Controller = TextEditingController();
  final P_Controller = TextEditingController();
  final K_Controller = TextEditingController();
  final Moist_Controller = TextEditingController();
  // final Ph_Controller = TextEditingController();
  // final Rain_Controller = TextEditingController();              //del
  final City_Controller = TextEditingController();
  //
  var Temp_api;
  var Humidity_api;

  Future<void> Fertilizer_function() async {
    //String strr
    final interpreter = await Interpreter.fromAsset('fertilizer_model.tflite');
    //var input = [ [90.0,42.0,43.0,20.0,82.0,6.0,202.0] ];
    var N_ = double.parse(N_Controller.text);
    var P_ = double.parse(P_Controller.text);
    var K_ = double.parse(K_Controller.text);
    var Moist_ = double.parse(Moist_Controller.text);

    // var Ph_ = double.parse(Ph_Controller.text);
    // var Rain_ = double.parse(Rain_Controller.text);
    var City_ = City_Controller.text;

    http.Response response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=" +
            City_.toString() +
            "&units=metric&appid=e43ac111fdcd8670e101cf9d0f9c7749")); // any way this is secret
    var results = jsonDecode(response.body);
    setState(() {
      this.Temp_api = results['main']['temp'];
      this.Humidity_api = results['main']['humidity'];
    });

    Temp_api = results['main']['temp'];
    Humidity_api = results['main']['humidity'];

    print("This is what I wanted below");
    print(Temp_api.toString());
    print(Humidity_api.toString());

    var Temp_ = double.parse(Temp_api.toString());
    var Humidity_ = double.parse(Humidity_api.toString());
    print(Temp_.toString() + " Temp_");
    print(Humidity_.toString() + " Humidity_");

    print(Soil_);
    print(Soil_!.name);
    print(Crop_);
    print(Crop_!.name);

    //var input = [ [ N_Controller.text, P_Controller.text, K_Controller.text, Temp_Controller.text, Humidity_Controller.text, Ph_Controller.text, Rain_Controller.text       ]  ];
    //var input =[[  onePointOne,onePointOne,onePointOne,onePointOne,onePointOne,onePointOne,onePointOne  ]];
    //print(strr);
    //var input = [[ N_, P_, K_, Temp_, Humidity_, Ph_, Rain_]];
    // var input = [[Temp_api, Humidity_api, Moist_, N_, K_, P_, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0]];
    //var input = [[3.0, 3.0, 46.0, 5.0, 7.0, 8.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0]];
    var input = [
      [
        Temp_,
        Humidity_,
        Moist_,
        N_,
        K_,
        P_,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0
      ]
    ];

    if (Soil_!.name == "Soil Type_Black") {
      input[0][6] = 1.0;
    }
    if (Soil_!.name == "Soil Type_Clayey") {
      input[0][7] = 1.0;
    }
    if (Soil_!.name == "Soil Type_Loamy") {
      input[0][8] = 1.0;
    }
    if (Soil_!.name == "Soil Type_Red") {
      input[0][9] = 1.0;
    }

    if (Soil_!.name == "Soil Type_Sandy") {
      input[0][10] = 1.0;
    }
    if (Crop_!.name == "Crop Type_Barley") {
      input[0][11] = 1.0;
    }
    if (Crop_!.name == "Crop Type_Cotton") {
      input[0][12] = 1.0;
    }
    if (Crop_!.name == "Crop Type_Ground Nuts") {
      input[0][13] = 1.0;
    }
    if (Crop_!.name == "Crop Type_Maize") {
      input[0][14] = 1.0;
    }
    if (Crop_!.name == "Crop Type_Millets") {
      input[0][15] = 1.0;
    }
    if (Crop_!.name == "Crop Type_Oil seeds") {
      input[0][16] = 1.0;
    }
    if (Crop_!.name == "Crop Type_Paddy") {
      input[0][17] = 1.0;
    }
    if (Crop_!.name == "Crop Type_Pulses") {
      input[0][18] = 1.0;
    }
    if (Crop_!.name == "Crop Type_Sugarcane") {
      input[0][19] = 1.0;
    }
    if (Crop_!.name == "Crop Type_Tobacco") {
      input[0][20] = 1.0;
    }
    if (Crop_!.name == "Crop Type_Wheat") {
      input[0][21] = 1.0;
    }

    print('THis is controllers input');
    print(N_Controller.text + ' N_Controller.text');
    print(P_Controller.text + ' P_Controller.text');
    print(K_Controller.text + ' K_Controller.text');
    print(Moist_Controller.text + ' Moist_Controller.text');
    // // print(  Temp_Controller.text + ' Temp_Controller.text');
    // // print(  Humidity_Controller.text + ' Humidity_Controller.text');
    // print(  Ph_Controller.text + ' Ph_Controller.text');
    // print(  Rain_Controller.text + ' Rain_Controller.text');
    print(City_Controller.text + ' City_Controller.text');

    var output = List.filled(7, 0).reshape([1, 7]);
    interpreter.run(input, output);
    //print(output);
    print(output[0]);
    print(output[0][0]);
    //print(output[0].reduce(max));

    var x = 0;
    var maax = output[0][0];
    var index = 0;
    for (x; x < 7; x++) {
      if (output[0][x] > maax) {
        maax = output[0][x];
        index = x;
      }
    }
    print(maax);
    print(index);

    this.setState(() {
      //predValue = "abhi";//index.toString();//output[0][0].toString();
      if (index == 0) predValue = '10-26-26';
      if (index == 1) predValue = '14-35-14';
      if (index == 2) predValue = '17-17-17';
      if (index == 3) predValue = '20-20';
      if (index == 4) predValue = '28-28';
      if (index == 5) predValue = 'DAP';
      if (index == 6) predValue = 'Urea';
    });
  }

  Usertemp? Soil_;
  Usertemp? Crop_;
  List<Usertemp> soil = <Usertemp>[
    Usertemp('Soil Type_Black'),
    Usertemp('Soil Type_Clayey'),
    Usertemp('Soil Type_Loamy'),
    Usertemp('Soil Type_Red')
  ];
  List<Usertemp> crop = <Usertemp>[
    Usertemp('Crop Type_Barley'),
    Usertemp('Crop Type_Cotton'),
    Usertemp('Crop Type_Ground Nuts'),
    Usertemp('Crop Type_Maize'),
    Usertemp('Crop Type_Millets'),
    Usertemp('Crop Type_Oil seeds'),
    Usertemp('Crop Type_Paddy'),
    Usertemp('Crop Type_Pulses'),
    Usertemp('Crop Type_Sugarcane'),
    Usertemp('Crop Type_Tobacco'),
    Usertemp('Crop Type_Wheat')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              // N
              controller: N_Controller,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'PLEASE ENTER Nitrogen content',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),

            TextField(
              // P
              controller: P_Controller,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'PLEASE ENTER Phosphorus Content',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),

            TextField(
              // K
              controller: K_Controller,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'PLEASE ENTER Potassium Content',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),

            // TextField(                                           // Ph
            //   controller: Ph_Controller,
            //   keyboardType: TextInputType.number,
            //   textAlign: TextAlign.left,
            //   decoration: InputDecoration(
            //     border: InputBorder.none,
            //     hintText: 'PLEASE ENTER Ph value',
            //     hintStyle: TextStyle(color: Colors.grey),
            //   ),
            // ),
            //
            // TextField(                                               // Rain
            //   controller: Rain_Controller,
            //   keyboardType: TextInputType.number,
            //   textAlign: TextAlign.left,
            //   decoration: InputDecoration(
            //     border: InputBorder.none,
            //     hintText: 'PLEASE ENTER Rain Content',
            //     hintStyle: TextStyle(color: Colors.grey),
            //   ),
            // ),
            //
            TextField(
              // Moist
              controller: Moist_Controller,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'PLEASE ENTER Moist',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),

            TextField(
              // City
              controller: City_Controller,

              textAlign: TextAlign.left,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'PLEASE ENTER City (Temp, Humidity feteched by API)',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),

            // Text(
            //   "change the input values in code to get the prediction",
            //   style: TextStyle(fontSize: 16),
            // ),
            // Row(
            // children: [ //Text("Soil Type ->  "),

            DropdownButton<Usertemp>(
              // Soil Type
              hint: new Text("Select Soil Type"),
              value: Soil_,
              onChanged: (Usertemp? newValue) {
                setState(() {
                  Soil_ = newValue!;
                });
              },
              items: soil.map((Usertemp usertemp) {
                return new DropdownMenuItem<Usertemp>(
                  value: usertemp,
                  child: new Text(
                    usertemp.name,
                    style: new TextStyle(color: Colors.black),
                  ),
                );
              }).toList(),
            ),
            // ],
            //),

            // Row(
            //   children: [ //Text("Crop Type ->  "),
            DropdownButton<Usertemp>(
              // Crop Type
              hint: new Text("Select Crop Type"),
              value: Crop_,
              onChanged: (Usertemp? newValue) {
                setState(() {
                  Crop_ = newValue!;
                });
              },
              items: crop.map((Usertemp usertemp) {
                return new DropdownMenuItem<Usertemp>(
                  value: usertemp,
                  child: new Text(
                    usertemp.name,
                    style: new TextStyle(color: Colors.black),
                  ),
                );
              }).toList(),
            ),
            // ],
            //),

            SizedBox(height: 12),
            MaterialButton(
              color: Colors.blue,
              child: Text(
                "predict",
                style: TextStyle(fontSize: 25),
              ),

              onPressed: Fertilizer_function,
              //onPressed: () {
              //  predData( 'abhi' );
              //},
            ),
            SizedBox(height: 12),
            Text("This is fertilizer"),
            Text(
              "Predicted value :  $predValue ",
              style: TextStyle(color: Colors.red, fontSize: 23),
            ),
          ],
        ),
      ),
    );
  }
}
