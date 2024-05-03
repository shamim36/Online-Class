import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:test_1/data/json_data.dart';


import '../widgets/build_house_near_me_card.dart';
import '../widgets/build_textFormField.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});
  JsonData data = JsonData();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedCity;
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar(context),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  padding: EdgeInsets.only(left: 15),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(
                        20.0), // Adjust the radius as needed
                  ),
                  child: Build_textFormField(
                      focusNode: _focusNode, isFocused: _isFocused),
                ),
              ),
              Container(
                height: 300,
                width: double.infinity,
                padding: EdgeInsets.all(20),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true, // limit height
                  primary: false, //disable scrolling
                  padding: EdgeInsets.all(12),
                
                  itemCount: widget.data.houseList.length,
                  itemBuilder: (context, index) {
                    return BuildHouseNearMeCard(
                      widget: widget,
                      index: index,
                    );
                  },
                ),
              ),
              SizedBox(
                child: ListView.builder(
                  shrinkWrap: true, // limit height
                  primary: false, //disable scrolling
                  padding: EdgeInsets.all(12),

                  itemCount: widget.data.houseList.length,
                  itemBuilder: (context, index) {
                    return BuildHouseNearMeCard(
                      widget: widget,
                      index: index,
                    );
                  },
                ),
              ),
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
                              value: cityMap["area"]! + ", " + cityMap["city"]!,
                              child: Text(
                                  cityMap["area"]! + ", " + cityMap["city"]!),
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
