import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
      title: "Weather app",
      home: Home(),
    ));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;
  Future getWeather() async{
    http.Response response = await http.get("http://api.openweathermap.org/data/2.5/weather?q=Dhaka&units=metric&appid=d35a37ef161e95741a61d163da5b5e97");
    var results = jsonDecode(response.body);
    setState(() {
      this.temp = results['main']['temp'];
      this.description = results['weather'][0]['description'];
      this.currently = results['weather'][0]['main'];
      this.humidity = results['main']['humidity'];
      this.windSpeed = results['wind']['speed'];
    });
  }

  @override

void initState()
  {
    super.initState();
    this.getWeather();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
              color: Colors.blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Text(
                    "Weather of Dhaka",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold),
                  ),
                  ),
                  Text(
                      temp != null ?temp.toString()+"\u00B0": "Loading",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 50),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      currently != null ? currently.toString(): "Loading",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: ListView(
                  children: [
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                      title: Text("Temperature", style: TextStyle(fontSize: 15,color: Colors.black, fontWeight: FontWeight.bold),),
                      trailing: Text(temp !=null ?temp.toString()+"\u00B0": "Loading",style: TextStyle(fontSize: 15,color: Colors.black, fontWeight: FontWeight.bold) )),
                    ListTile(
                        leading: FaIcon(FontAwesomeIcons.cloud),
                        title: Text("Weather", style: TextStyle(fontSize: 15,color: Colors.black, fontWeight: FontWeight.bold)),
                        trailing: Text(description !=null ?description.toString(): "Loading", style: TextStyle(fontSize: 15,color: Colors.black, fontWeight: FontWeight.bold))),
                    ListTile(
                        leading: FaIcon(FontAwesomeIcons.sun),
                        title: Text("Temperature Humidity", style: TextStyle(fontSize: 15,color: Colors.black, fontWeight: FontWeight.bold)),
                        trailing: Text(humidity !=null ?humidity.toString(): "Loading", style: TextStyle(fontSize: 15,color: Colors.black, fontWeight: FontWeight.bold))),
                    ListTile(
                        leading: FaIcon(FontAwesomeIcons.wind),
                        title: Text("Wind Speed", style: TextStyle(fontSize: 15,color: Colors.black, fontWeight: FontWeight.bold)),
                        trailing: Text(windSpeed !=null ?windSpeed.toString(): "Loading", style: TextStyle(fontSize: 15,color: Colors.black, fontWeight: FontWeight.bold))),
                  ],
                ),
              ),

            )
          ],
        ),
    );
  }
}
