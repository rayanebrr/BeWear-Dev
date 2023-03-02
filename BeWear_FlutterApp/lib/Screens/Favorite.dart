import 'package:clothewardrobe/Screens/Profile.dart';
import 'package:flutter/material.dart';

import 'AI.dart';
import 'Login.dart';
import 'Splash.dart';
import 'Swipe.dart';
import 'WardrobeSelector.dart';

class Favourite extends StatefulWidget {
  final List<Content> favoriteContents;

  const Favourite({Key? key, required this.favoriteContents}) : super(key: key);

  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  int _index = 1; // Index of the current screen in BottomNavigationBar
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
    _index = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffD0D0DF),
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image(
                  image: AssetImage("images/logo.png"),
                  height: 83,
                  width: 68,
                ),
                SizedBox(width: 10),
                Text(
                  'Favourites',
                  style: TextStyle(
                    fontSize: 32,
                    color: const Color(0xffef8100),
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 15),
                child: ListView.builder(
                  itemCount: widget.favoriteContents.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 300,
                                height: 200,
                                child: Image.asset(
                                  widget.favoriteContents[index].imageAssetPath,
                                  fit: BoxFit.none,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                widget.favoriteContents[index].title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              widget.favoriteContents.removeAt(index);
                            });
                          },
                          icon: Icon(Icons.remove_circle_outline),
                          color: const Color(0xffef8100),
                          iconSize: 30,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
    );
  }
}
