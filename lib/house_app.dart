import 'package:flutter/material.dart';
import 'package:test_1/screens/home_page.dart';

class HouseApp extends StatefulWidget {
  const HouseApp({super.key});

  @override
  State<HouseApp> createState() => _HouseAppState();
}

class _HouseAppState extends State<HouseApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}