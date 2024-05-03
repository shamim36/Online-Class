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
      color: Colors.white,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            child: Container(
              height: 100,
              width: 160,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  '${widget.data.houseList[index]["img"]}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${widget.data.houseList[index]["resort"]}"),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '\$${widget.data.houseList[index]["price"]}',
                        style: const TextStyle(
                          color: Color.fromARGB(
                              255, 109, 98, 3), // Set the color to yellow
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const TextSpan(
                        text: ' /night',
                        style: TextStyle(
                          color: Colors.black54, // Set the color to black
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
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
          ),
        ],
      ),
    );
  }
}
