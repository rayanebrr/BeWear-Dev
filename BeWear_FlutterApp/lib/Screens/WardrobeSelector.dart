import 'package:flutter/material.dart';

import 'AI.dart';
import 'Favorite.dart';
import 'Login.dart';
import 'Profile.dart';
import 'Splash.dart';
import 'Swipe.dart';

class WardrobeSelector extends StatefulWidget {
  const WardrobeSelector({Key? key}) : super(key: key);

  @override
  State<WardrobeSelector> createState() => _WardrobeSelectorState();
}

class _WardrobeSelectorState extends State<WardrobeSelector> {
  int _index = 0;
  List<Widget> screens = [];
  List<Content> favoriteContents = [];

  @override
  void initState() {
    screens = [
      WardrobeSelector(),
      Favourite(favoriteContents: favoriteContents),
      SwipeCardPage(),
      OutfitSuggestionScreen(),
      ProfilePage(),
    ];
    _index = 0;
    super.initState();
  }

  List<String> _types = [
    'Top & Hauts',
    'Pants & Bottoms',
    'Dresses',
    'Shoes',
    'Coats'
  ];

  List<List<String>> _items = [
    [
      'images/top1.png',
      'images/logo.png',
      'images/logo.png',
      'images/logo.png',
      'images/logo.png',
      'images/logo.png'
    ],
    [
      'images/logo.png',
      'images/logo.png',
      'images/logo.png',
      'images/logo.png',
      'images/logo.png',
      'images/logo.png'
    ],
    [
      'images/logo.png',
      'images/logo.png',
      'images/logo.png',
      'images/logo.png',
      'images/logo.png',
      'images/logo.png'
    ],
    [
      'images/logo.png',
      'images/logo.png',
      'images/logo.png',
      'images/logo.png',
      'images/logo.png',
      'images/logo.png'
    ],
    [
      'images/logo.png',
      'images/logo.png',
      'images/logo.png',
      'images/logo.png',
      'images/logo.png',
      'images/logo.png'
    ],
  ];

  List<List<String>> _itemsNames = [
    ['Top 1', 'Top 2', 'Top 3', 'Top 4', 'Top 5', 'Top 6'],
    ['Bottom 1', 'Bottom 2', 'Bottom 3', 'Bottom 4', 'Bottom 5', 'Bottom 6'],
    ['Dress 1', 'Dress 2', 'Dress 3', 'Dress 4', 'Dress 5', 'Dress 6'],
    ['Shoe 1', 'Shoe 2', 'Shoe 3', 'Shoe 4', 'Shoe 5', 'Shoe 6'],
    ['Coat 1', 'Coat 2', 'Coat 3', 'Coat 4', 'Coat 5', 'Coat 6'],
  ];

  void _onItemTapped(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffD0D0DF),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 30),
            child: Row(
              children: [
                Image(
                  image: AssetImage("images/logo.png"),
                  height: 83,
                  width: 68,
                ),
                SizedBox(width: 10),
                // add some space between the image and text
                Text(
                  'Mon dressing',
                  style: TextStyle(
                    fontSize: 32,
                    color: const Color(0xffef8100),
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 20, right: 8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _types
                    .asMap()
                    .map(
                      (index, type) => MapEntry(
                        index,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: ChoiceChip(
                            label: Text(
                              type,
                              style: TextStyle(
                                  color: _index == index
                                      ? Colors.white
                                      : Colors.black),
                            ),
                            backgroundColor: Colors.white,
                            selectedColor: const Color(0xffef8100),
                            selected: _index == index,
                            onSelected: (selected) {
                              setState(() {
                                _index = selected ? index : -1;
                              });
                            },
                          ),
                        ),
                      ),
                    )
                    .values
                    .toList(),
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 20.0,
              padding: EdgeInsets.only(top: 28.0, left: 8.0, right: 8.0),
              childAspectRatio: 100 / 130,
              children: _items[_index]
                  .asMap()
                  .map(
                    (index, item) => MapEntry(
                      index,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Card(
                            color: Color(0xfff5f5f5),
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(item),
                                  fit: BoxFit.none,
                                ),
                              ),
                              height: 170,
                              width: 170,
                            ),
                          ),
                          SizedBox(height: 10), // added space between card and text
                          Text(
                            _itemsNames[_index][index], // added text below card
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  )
                  .values
                  .toList(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 60.0,
        decoration: BoxDecoration(
          color: Colors.grey[300],
        ),
        child: BottomNavigationBar(
          backgroundColor: Color(0xffD0D0DF),
          selectedItemColor: Colors.amber[800],
          unselectedItemColor: Colors.grey[600],
          type: BottomNavigationBarType.fixed,
          currentIndex: _index,
          onTap: (value) {
            setState(() {
              _index = value;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => screens[_index]),
              );
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Image.asset('images/mon.png', height: 24),
              label: 'Mon',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('images/favourite.png', height: 24),
              label: 'Favoris',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('images/swipe.png', height: 24),
              label: 'Swipe',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('images/reseau.png', height: 24),
              label: 'Réseau',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('images/profil.png', height: 24),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}
