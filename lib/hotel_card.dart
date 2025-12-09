import 'package:flutter/material.dart';
import 'hotel.dart';

class HotelCard extends StatelessWidget {
  final Hotel hotel;
  final bool isBooked;
  final bool isFavorite;
  final VoidCallback onBook;
  final VoidCallback onFavorite;

  const HotelCard({
    super.key,
    required this.hotel,
    required this.isBooked,
    required this.isFavorite,
    required this.onBook,
    required this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(0, 4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _image(),
          _info(),
        ],
      ),
    );
  }

  Widget _image() {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        gradient: LinearGradient(
          colors: hotel.gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          const Center(
            child: Text("Фото отеля",
                style: TextStyle(color: Colors.white, fontSize: 16)),
          ),
          Positioned(
            right: 12,
            top: 12,
            child: GestureDetector(
              onTap: onFavorite,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                    color: Colors.white, shape: BoxShape.circle),
                child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.grey,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _info() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(hotel.name,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                    color: Colors.yellow[100],
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [
                    const Icon(Icons.star, size: 16, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text('${hotel.rating}'),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 4),
          Row(children: [
            const Icon(Icons.location_on, size: 16, color: Colors.redAccent),
            const SizedBox(width: 4),
            Text(hotel.location),
          ]),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(hotel.price,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5B5FD8))),
              isBooked
                  ? Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                          color: Colors.green[50],
                          borderRadius: BorderRadius.circular(8)),
                      child: const Text("Забронировано",
                          style: TextStyle(color: Colors.green)),
                    )
                  : ElevatedButton(
                      onPressed: onBook,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF5B5FD8),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12)),
                      child: const Text("Забронировать",
                          style: TextStyle(color: Colors.white)),
                    )
            ],
          ),
        ],
      ),
    );
  }
}
