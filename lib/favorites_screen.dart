import 'package:flutter/material.dart';
import 'hotel.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Hotel> favoriteHotels;
  final Function(int) onRemoveFavorite;

  const FavoritesScreen({
    Key? key,
    required this.favoriteHotels,
    required this.onRemoveFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(color: Color(0xFF5B5FD8)),
          child: const Row(
            children: [

              Text( 'Избранное', style: TextStyle( color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold,),),

            ],
          ),
        ),

        Expanded(
          child: favoriteHotels.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Icon(Icons.favorite_border, size: 64, color: Colors.grey[400]),

                      const SizedBox(height: 16),

                      Text( 'Нет избранных отелей', style: TextStyle(fontSize: 18, color: Colors.grey[600]), ),

                    ],
                  ),
                )

              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: favoriteHotels.length,
                  itemBuilder: (context, index) {
                    final hotel = favoriteHotels[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [

                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),

                        ],
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Container(
                            height: 120,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                              ),

                              gradient: LinearGradient(
                                colors: hotel.gradientColors,
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),

                            child: Stack(
                              children: [
                                const Center(

                                  child: Text('Фото отеля', style: TextStyle( color: Colors.white, fontSize: 14),

                                  ),
                                ),

                                Positioned(
                                  top: 12,
                                  right: 12,
                                  child: GestureDetector(
                                    onTap: () {
                                      onRemoveFavorite(index);
                                    },

                                    child: Container(
                                      padding:
                                          const EdgeInsets.all(8),
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),

                                      child: const Icon(Icons.favorite, size: 20, color: Colors.red),),

                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [

                                    Text( hotel.name, style: const TextStyle( fontSize: 18, fontWeight: FontWeight.bold), ),

                                    Container(
                                      padding:
                                          const EdgeInsets.symmetric( horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.yellow[100],
                                        borderRadius:
                                            BorderRadius.circular(8),
                                      ),

                                      child: Row(
                                        children: [

                                          const Icon(Icons.star, color: Colors.amber, size: 16),

                                          const SizedBox(width: 4),

                                          Text('${hotel.rating}', style: const TextStyle( fontWeight: FontWeight.bold, fontSize: 14)),

                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 4),

                                Row(
                                  children: [
                                    const Icon(Icons.location_on, color: Colors.redAccent, size: 16),

                                    const SizedBox(width: 4),

                                    Text(hotel.location, style: const TextStyle( fontSize: 14, color: Colors.grey)),

                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}