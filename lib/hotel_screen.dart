import 'package:flutter/material.dart';
import 'hotel.dart';
import 'bookings_screen.dart';
import 'favorites_screen.dart';
import 'profile_screen.dart';

class HotelListScreen extends StatefulWidget {
  const HotelListScreen({Key? key}) : super(key: key);

  @override
  State<HotelListScreen> createState() => _HotelListScreenState();
}

class _HotelListScreenState extends State<HotelListScreen> {
  int _currentIndex = 0;
  String _selectedCity = 'Все';

  List<Hotel> bookedHotels = [];
  List<Hotel> favoriteHotels = [];

  final List<Hotel> allHotels = [

    Hotel(
      name: 'Grand Hotel',
      location: 'Москва, Центр',
      rating: 4.8,
      price: '5 500₽',
      city: 'Москва',
      gradientColors: [Color(0xFF5B5FD8), Color(0xFF7C75F2)],
      amenities: ['Wi-Fi', 'Парковка', 'Бассейн'],
    ),

    Hotel(
      name: 'Hotel Nevsky',
      location: 'Санкт-Петербург',
      rating: 4.5,
      price: '4 200₽',
      city: 'Санкт-Петербург',
      gradientColors: [Color(0xFFFF7AA7), Color(0xFFE94D87)],
      amenities: ['Wi-Fi', 'Ресторан', 'Спортзал'],
    ),

    Hotel(
      name: 'Sochi Beach Resort',
      location: 'Сочи, Набережная',
      rating: 4.9,
      price: '6 300₽',
      city: 'Сочи',
      gradientColors: [Color(0xFF7AE6FF), Color(0xFF28C9FF)],
      amenities: ['Пляж', 'Бассейн', 'Теннис'],
    ),

  ];

  List<Hotel> get filteredHotels {
    if (_selectedCity == 'Все') {
      return allHotels;
    }
    return allHotels.where((hotel) => hotel.city == _selectedCity).toList();
  }

  void _bookHotel(Hotel hotel) {
    setState(() {
      if (!bookedHotels.any((h) => h.name == hotel.name)) {
        bookedHotels.add(hotel);
      }
      _currentIndex = 1;
    });
  }

  void _addToFavorites(Hotel hotel) {
    setState(() {
      if (!favoriteHotels.any((h) => h.name == hotel.name)) {
        favoriteHotels.add(hotel);
      }
    });
  }

  void _removeFromFavorites(Hotel hotel) {
    setState(() {
      favoriteHotels.removeWhere((h) => h.name == hotel.name);
    });
  }

  bool _isFavorite(Hotel hotel) {
    return favoriteHotels.any((h) => h.name == hotel.name);
  }

  bool _isBooked(Hotel hotel) {
    return bookedHotels.any((h) => h.name == hotel.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: _currentIndex == 1
            ? BookingsScreen(
                bookedHotels: bookedHotels,
                onRemoveBooking: (index) {
                  setState(() {
                    bookedHotels.removeAt(index);
                  });
                },
              )
            : _currentIndex == 2
                ? FavoritesScreen(
                    favoriteHotels: favoriteHotels,
                    onRemoveFavorite: (index) {
                      setState(() {
                        favoriteHotels.removeAt(index);
                      });
                    },
                  )
                : _currentIndex == 3
                    ? ProfileScreen(bookedHotels: bookedHotels)
                    : Column(
                        children: [

                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration:
                                const BoxDecoration(color: Color(0xFF5B5FD8)),
                            child: Column(
                              children: [
                                
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    const Text( 'Отели', style: TextStyle( color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold,),),

                                    Row(
                                      children: const [

                                        Icon(Icons.notifications_outlined, color: Colors.white),

                                        SizedBox(width: 16),

                                        Icon(Icons.settings_outlined, color: Colors.white),

                                      ],
                                    ),

                                  ],
                                ),
                                const SizedBox(height: 16),

                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),

                                  child: Row(
                                    children: [

                                      Icon(Icons.search, color: Colors.grey[400]),

                                      const SizedBox(width: 8),

                                      Text( 'Поиск отелей...', style: TextStyle( color: Colors.grey[400], fontSize: 16),),

                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            height: 60,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              children: [

                                _buildCityChip('Все', _selectedCity == 'Все'),

                                const SizedBox(width: 8),

                                _buildCityChip('Москва', _selectedCity == 'Москва'),

                                const SizedBox(width: 8),

                                _buildCityChip('Санкт-Петербург', _selectedCity == 'Санкт-Петербург'),

                                const SizedBox(width: 8),

                                _buildCityChip('Сочи', _selectedCity == 'Сочи'),

                              ],
                            ),
                          ),

                          Expanded(
                            child: filteredHotels.isEmpty
                                ? Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [

                                        Icon(Icons.hotel_outlined, size: 64, color: Colors.grey[400]),

                                        const SizedBox(height: 16),

                                        Text( 'Нет отелей в этом городе', style: TextStyle( fontSize: 18, color: Colors.grey[600]),),

                                      ],
                                    ),
                                  )
                                : ListView.builder(
                                    padding: const EdgeInsets.all(16),
                                    itemCount: filteredHotels.length,
                                    itemBuilder: (context, index) {
                                      final hotel = filteredHotels[index];

                                      return Container(
                                        margin: const EdgeInsets.only(bottom: 24),
                                        decoration: _cardDecoration(),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,

                                          children: [
                                            _hotelImageGradient(
                                              hotel.gradientColors,
                                              isFavorite: _isFavorite(hotel),

                                              onFavorite: () {
                                                if (_isFavorite(hotel)) {
                                                  _removeFromFavorites(hotel);
                                                } else {
                                                  _addToFavorites(hotel);
                                                }
                                              },
                                            ),

                                            _hotelInfo(
                                              hotel: hotel,
                                              booked: _isBooked(hotel),
                                              onBook: () => _bookHotel(hotel),
                                            ),

                                          ],
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        ],
                      ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF5B5FD8),
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },

        items: const [

          BottomNavigationBarItem( icon: Icon(Icons.home), label: 'Главная'),

          BottomNavigationBarItem( icon: Icon(Icons.bookmark_border), label: 'Брони'),

          BottomNavigationBarItem( icon: Icon(Icons.favorite_border), label: 'Избранное'),

          BottomNavigationBarItem( icon: Icon(Icons.person_outline), label: 'Профиль'),

        ],
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [

        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),

      ],
    );
  }

  Widget _hotelImageGradient(
    List<Color> colors, {
    required bool isFavorite,
    required VoidCallback onFavorite,
  }) {

    return Container(
      height: 180,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),

        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),

      child: Stack(
        children: [
          const Center(

            child: Text( 'Фото отеля', style: TextStyle(color: Colors.white, fontSize: 16),),

          ),

          Positioned(
            top: 12,
            right: 12,
            child: GestureDetector(
              onTap: onFavorite,
              child: Container(
                padding: const EdgeInsets.all(8),

                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),

                child: Icon( isFavorite ? Icons.favorite : Icons.favorite_border, size: 20, color: isFavorite ? Colors.red : Colors.grey,),

              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _hotelInfo({
    required Hotel hotel,
    required bool booked,
    required VoidCallback onBook,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              
              Expanded(

                child: Text( hotel.name, style: const TextStyle( fontSize: 18, fontWeight: FontWeight.bold),),
                
              ),

              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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

          const SizedBox(height: 8),

          Wrap(
            spacing: 4,
            runSpacing: 4,
            children: hotel.amenities.map((a) {
              IconData icon;
              if (a == 'Wi-Fi') icon = Icons.wifi;
              else if (a == 'Парковка') icon = Icons.local_parking;
              else if (a == 'Бассейн') icon = Icons.pool;
              else if (a == 'Пляж') icon = Icons.beach_access;
              else if (a == 'Теннис') icon = Icons.sports_tennis;
              else if (a == 'Ресторан') icon = Icons.restaurant;
              else if (a == 'Спортзал') icon = Icons.fitness_center;
              else icon = Icons.check;

              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),

                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    Icon(icon, size: 14),

                    const SizedBox(width: 4),

                    Text(a, style: const TextStyle(fontSize: 12)),

                  ],
                ),

              );
            }).toList(),
          ),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [

                  Text(hotel.price, style: const TextStyle( fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF5B5FD8))),

                  const SizedBox(width: 3),

                  const Text('/ночь', style: TextStyle(fontSize: 19, color: Colors.grey)),

                ],
              ),

              booked
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.green[50],
                        borderRadius: BorderRadius.circular(8),
                      ),

                      child: const Text( 'Забронировано', style: TextStyle( color: Colors.green, fontWeight: FontWeight.w600),),
                    )

                  : ElevatedButton(
                      onPressed: onBook,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5B5FD8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                      ),

                      child: const Text('Забронировать', style: TextStyle(fontSize: 14, color: Colors.white )),),

            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCityChip(String label, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCity = label;
        });
      },

      child: 
      
      Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF5B5FD8) : Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),

        child:
        
        Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[700],
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),

      ),
    );
  }
}