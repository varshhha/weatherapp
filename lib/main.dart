import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:weather_app/main.dart';


void main() =>runApp(
    MaterialApp(
      title: "Weather App",
      home: Home(),
    )
);

class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return _HomeState();
  }
}

class _HomeState extends State <Home>{
  var location;
  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;

  Future getWeather() async{

    http.Response response=await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=chennai,india&APPID=aec6efd615eafc25ddd0055673575486'));

    var results=jsonDecode(response.body);
    setState(() {

      this.temp=results['main']['temp'];
      this.description=results['weather'][0]['description'];
      this.currently=results['weather'][0]['main'];
      this.humidity=results['main']['humidity'];
      this.windSpeed=results['wind']['speed'];
    });
  }

  @override
  void initState(){
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
        children:<Widget>[
          Container(
            height:MediaQuery.of(context).size.height/ 3,
            width: MediaQuery.of(context).size.width,
            color: Colors.red,
            child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:<Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom:10.0),
                    child:Text(
                      "Currently in chennai",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                  Text(
                    temp !=null ? temp.toString()+ "\u00B0" : "Loading",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40.0,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top:10.0),
                    child:Text(
                      currently !=null ? currently.toString() :"Loading" ,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  ),

                ]
            ),
          ),
          Expanded(
              child:Padding(
                padding:EdgeInsets.all(20.0) ,
                child: ListView(
                    children:<Widget>[
                      ListTile(
                        title: Text("Temperature"),
                        leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                        trailing: Text(temp != null ?temp.toString()+"\u00B0": "Loading"),
                      ),
                      ListTile(
                        title: Text("Weather"),
                        leading: FaIcon(FontAwesomeIcons.cloud),
                        trailing: Text(description != null ?description.toString():"Loading"),
                      ),
                      ListTile(
                        title: Text("Humidity"),
                        leading: FaIcon(FontAwesomeIcons.sun),
                        trailing: Text(humidity != null? humidity.toString() :"Loading"),
                      ),
                      ListTile(
                        title: Text("Wind Speed"),
                        leading: FaIcon(FontAwesomeIcons.wind),
                        trailing: Text(windSpeed !=null ? windSpeed.toString():"Loading"),
                      )
                    ]
                ),
              )
          )
        ],
      ),
    );
  }
}




