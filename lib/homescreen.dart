import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var temp;
  var description;
  var currently;
  var windspeed;

  Future getWeather() async {
    http.Response response = await http.get(
      Uri.parse('Your API'),
    );

    var results = jsonDecode(response.body);
    setState(() {
      this.temp = results['main']['temp'];
      this.description = results['weather'][0]['description'];
      this.currently = results['weather'][0]['main'];
      this.windspeed = results['wind']['speed'];
    });
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            color: Colors.green.shade400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Currently in Dhaka',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  temp != null ? temp.toString() + '\u00B0' : 'Loading',
                  style: const TextStyle(
                      fontSize: 40, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    currently != null ? currently.toString() : 'Loading',
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  ListTile(
                    leading: const Icon(Icons.thermostat),
                    title: const Text('Temparature'),
                    trailing: Text(
                        temp != null ? temp.toString() + '\u00B0' : 'Loading'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.umbrella),
                    title: const Text('Weather'),
                    trailing: Text(description != null
                        ? description.toString()
                        : 'Loading'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.air),
                    title: const Text('Wind Speed'),
                    trailing: Text(
                        windspeed != null ? windspeed.toString() : 'Loading'),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
