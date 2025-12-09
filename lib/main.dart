import 'package:flutter/material.dart';
import 'hotel_screen.dart';

void main() {
  runApp(const HotelApp());
}

class HotelApp extends StatelessWidget {
  const HotelApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HotelListScreen(),
    );
  }
}