import 'package:flutter/material.dart';

import '../screens/home_page.dart';

class BuildHouseNearMeCard extends StatelessWidget {
  const BuildHouseNearMeCard({
    super.key,
    required this.widget,
    required this.index,
  });

  final HomePage widget;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            // decoration: BoxDecoration(
            //   borderRadius:
            //       BorderRadius.circular(500.0), // Adjust the radius as needed
            // ),
            child: Container(
              height: 100,
              width: 100,
              child: Image(
                image: NetworkImage('${widget.data.houseList[index]["img"]}'),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${widget.data.houseList[index]["resort"]}"),
              Text("\$${widget.data.houseList[index]["price"]}\/night"),
              Row(
                children: [
                  Icon(Icons.location_pin),
                  Text(
                      "${widget.data.houseList[index]["area"]}, ${widget.data.houseList[index]["city"]}"),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.menu_book_sharp),
                  Text("${widget.data.houseList[index]["roomSize"]}"),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
