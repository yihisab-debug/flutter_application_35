import 'package:flutter/material.dart';

class Hotel {
  final String name;
  final String location;
  final double rating;
  final String price;
  final String city;
  final List<Color> gradientColors;
  final List<String> amenities;

  Hotel({
    required this.name,
    required this.location,
    required this.rating,
    required this.price,
    required this.city,
    required this.gradientColors,
    required this.amenities,
  });
}