import 'package:flutter/material.dart';
import 'package:test_1/data/json_data.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});
  JsonData data = JsonData();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedCity;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar(context),
        body: SingleChildScrollView(
          child: Column(
            children: [

            ],
            
          ),
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.blue,
        toolbarHeight: 80,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Current Location',
              style: TextStyle(fontSize: 14),
            ),
            InkWell(
              onTap: () {
                print('Clicked on Location!');
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Select a City'),
                      content: Column(
                        children: [
                          DropdownButton<String>(
                            value: selectedCity,
                            items: widget.data.cityList.map((cityMap) {
                              return DropdownMenuItem<String>(
                                value: cityMap["area"]! +
                                    ", " +
                                    cityMap["city"]!,
                                child: Text(cityMap["area"]! +
                                    ", " +
                                    cityMap["city"]!),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              Navigator.pop(context);
                              setState(() {
                                selectedCity = newValue!;
                              });
                            },
                            hint: selectedCity == 'Select a city' ||
                                    selectedCity == null
                                ? Text('Select a city')
                                : Text(selectedCity!),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Row(
                children: [
                  Icon(Icons.location_pin),
                  Text(
                    ' ' + (selectedCity ?? 'Select a city'),
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          InkWell(
            onTap: () {
              print('Clicked on Notification!');
            },
            child: Icon(Icons.notifications_none_outlined),
          ),
        ],
      );
  }
}
