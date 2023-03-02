import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swipe_cards/swipe_cards.dart';

import 'AI.dart';
import 'Favorite.dart';
import 'Splash.dart';
import 'Swipe.dart';
import 'WardrobeSelector.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File _image = File('images/logo.png');
  List<Content> favoriteContents = [];

  int _index = 0;
  List<Widget> screens = [];

  @override
  void initState() {
    favoriteContents = [];
    screens = [
      WardrobeSelector(),
      Favourite(favoriteContents: favoriteContents),
      SwipeCardPage(),
      OutfitSuggestionScreen(),
      ProfilePage(),
    ];
    _index = 4;
    super.initState();
  }

  // function to pick an image from the gallery
  Future getImage() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffD0D0DF),
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
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
              GestureDetector(
                onTap: () {
                  getImage(); // call getImage function when the user taps on the circle
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xffef8100),
                        width: 2,
                      ),
                    ),
                      child: CircleAvatar(
                        radius: 80,
                        backgroundImage: AssetImage('images/logo.png'),
                      ),
                    ),
                ),

              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      // code for the first floating button
                    },
                    child: Icon(Icons.add),
                    backgroundColor: Color(0xffef8100),
                  ),
                  SizedBox(width: 20),
                  FloatingActionButton(
                    onPressed: () {
                      // code for the second floating button
                    },
                    child: Icon(Icons.edit),
                    backgroundColor: Color(0xffef8100),
                  ),
                  SizedBox(width: 20),
                  FloatingActionButton(
                    onPressed: () {
                      // code for the third floating button
                    },
                    child: Icon(Icons.delete),
                    backgroundColor: Color(0xffef8100),
                  ),
                ],
              ),
            ],
          ),
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
