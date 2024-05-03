import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:test_1/data/json_data.dart';
import 'package:test_1/widgets/build_featured_listings_card.dart';

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

  int _selectedIndex = 0;

  // static const List<Widget> _widgetOptions = <Widget>[
  //   Text('Home Page'),
  //   Text('My Order Page'),
  //   Text('Save Page'),
  //   Text('Chat Host Page'),
  //   Text('Profile Page'),
  // ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 243, 241, 241),
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
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'House Near You',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        //show all the house near you
                      },
                      child: const Text(
                        'View All',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 109, 98, 3),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 300,
                width: double.infinity,
                padding: EdgeInsets.all(20),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
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
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Featured Listings',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        //view all featured Listings
                      },
                      child: const Text(
                        'View All',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 109, 98, 3),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                child: ListView.builder(
                  shrinkWrap: true, // limit height
                  primary: false, //disable scrolling
                  padding: EdgeInsets.all(12),

                  itemCount: widget.data.houseList.length,
                  itemBuilder: (context, index) {
                    return BuildFeaturedListingCard(
                      widget: widget,
                      index: index,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: bottomNavBar(),
      ),
    );
  }

  BottomNavigationBar bottomNavBar() {
    return BottomNavigationBar(
      showSelectedLabels: true,
      showUnselectedLabels: true,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Home',
          activeIcon: Icon(Icons.home_filled),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.airplane_ticket_outlined),
          activeIcon: Icon(Icons.airplane_ticket),
          label: 'My Order',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.save_outlined),
          activeIcon: Icon(Icons.save),
          label: 'Save',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_outlined),
          activeIcon: Icon(Icons.chat),
          label: 'Chat Host',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_3_outlined),
          activeIcon: Icon(Icons.person_3),
          label: 'Profile',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.black87, // Darker color when selected
      unselectedItemColor: Colors.black38, // Lighter color by default
      onTap: _onItemTapped,
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 243, 241, 241),
      toolbarHeight: 80,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Current Location',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
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
                              ? const Text(
                                  'Select a city',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                )
                              : Text(
                                  selectedCity!,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: Row(
              children: [
                const Icon(
                  Icons.location_pin,
                  color: Color.fromARGB(255, 109, 98, 3),
                ),
                Text(
                  ' ' + (selectedCity ?? 'Select a city'),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
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
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.notifications_none_outlined),
            ),
          ),
        ),
      ],
    );
  }
}
