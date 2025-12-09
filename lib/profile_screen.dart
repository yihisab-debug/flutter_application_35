import 'package:flutter/material.dart';
import 'hotel.dart';

class ProfileScreen extends StatelessWidget {
  final List<Hotel> bookedHotels;

  const ProfileScreen({
    Key? key,
    required this.bookedHotels,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                },
                
                icon: const Icon(Icons.settings), iconSize: 28, color: Colors.grey[700], ),

              IconButton(
                onPressed: () {
                },

                icon: const Icon(Icons.logout), iconSize: 28, color: Colors.grey[700],),

            ],
          ),
        ),
        
        Center(
          child: Column(
            children: [

              const SizedBox(height: 10),
              
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xFF5B5FD8), Color(0xFF8B8FE8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),

                  boxShadow: [

                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),

                  ],
                ),

                child: const Icon( Icons.person, size: 50, color: Colors.white, ),

              ),
              
              const SizedBox(height: 16),
              
              const Text( 'Имя Пользователя', style: TextStyle( fontSize: 24, fontWeight: FontWeight.bold, ),),
              
              const SizedBox(height: 4),
              
              Text( 'user@example.com', style: TextStyle( fontSize: 14, color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 25),
        
        Expanded(
          child: bookedHotels.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  
                      Text( 'Нет броней', style: TextStyle(fontSize: 18, color: Colors.grey[600]),),

                    ],
                  ),
                )

              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: bookedHotels.length,
                  itemBuilder: (context, index) {
                    final hotel = bookedHotels[index];
                  
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

                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [

                                    Text( hotel.name, style: const TextStyle( fontSize: 18, fontWeight: FontWeight.bold), ),

                                    Container(
                                      padding: const EdgeInsets.symmetric( horizontal: 8, vertical: 4),

                                      decoration: BoxDecoration(
                                        color: Colors.yellow[100],
                                        borderRadius: BorderRadius.circular(8),
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