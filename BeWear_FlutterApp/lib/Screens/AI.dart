import 'package:flutter/material.dart';

import 'Favorite.dart';
import 'Profile.dart';
import 'Swipe.dart';
import 'WardrobeSelector.dart';

class OutfitSuggestionScreen extends StatefulWidget {
  @override
  _OutfitSuggestionScreenState createState() => _OutfitSuggestionScreenState();
}

class _OutfitSuggestionScreenState extends State<OutfitSuggestionScreen> {
  String color = "red";
  String style = "casual";
  String weather = "warm";
  String suggestedOutfit = "";

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
    _index = 3;
    super.initState();
  }

  void suggestOutfit() {
    // Create an instance of the OutfitSuggestionModel class
    OutfitSuggestionModel outfitSuggestionModel =
    OutfitSuggestionModel(color, style, weather);

    // Call the suggest_outfit method and update the state with the suggested outfit
    setState(() {
      suggestedOutfit = outfitSuggestionModel.suggest_outfit()!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffD0D0DF),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 30),
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
                      // add some space between the image and text
                      Text(
                        'Outfit Suggestion',
                        style: TextStyle(
                          fontSize: 32,
                          color: const Color(0xffef8100),
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 60),
            Text(
              "Select your preferences",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            DropdownButton<String>(
              value: color,
              onChanged: (value) {
                setState(() {
                  color = value!;
                });
              },
              style: TextStyle(fontSize: 18, color: Colors.black),
              dropdownColor: const Color(0xffef8100),
              items: <String>['red', 'blue', 'green', 'yellow']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            DropdownButton<String>(
              value: style,
              onChanged: (value) {
                setState(() {
                  style = value!;
                });
              },
              style: TextStyle(fontSize: 18, color: Colors.black),
              dropdownColor: const Color(0xffef8100),
              items: <String>['casual', 'formal', 'sporty']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            DropdownButton<String>(
              value: weather,
              onChanged: (value) {
                setState(() {
                  weather = value!;
                });
              },
              style: TextStyle(fontSize: 18, color: Colors.black),
              dropdownColor: const Color(0xffef8100),
              items: <String>['warm', 'cool', 'hot']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: suggestOutfit,
              child: Text("Get Outfit Suggestion"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffef8100),
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: Text(
                suggestedOutfit,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: const Color(0xffef8100)),
                textAlign: TextAlign.center,
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

class OutfitSuggestionModel {
  String color;
  String style;
  String weather;

  OutfitSuggestionModel(this.color, this.style, this.weather);

  String? suggest_outfit() {
    if (weather == 'warm') {
      if (style == 'casual') {
        if (color == 'red') {
          return 'Wear a red t-shirt and denim shorts';
        } else if (color == 'blue') {
          return 'Wear a blue tank top and white shorts';
        } else if (color == 'green') {
          return 'Wear a green polo shirt and khaki shorts';
        } else {
          return 'Wear a yellow t-shirt and denim shorts';
        }
      } else if (style == 'formal') {
        if (color == 'red') {
          return 'Wear a red dress shirt, black dress pants, and black dress shoes';
        } else if (color == 'blue') {
          return 'Wear a blue dress shirt, gray dress pants, and brown dress shoes';
        } else if (color == 'green') {
          return 'Wear a green dress shirt, beige dress pants, and brown dress shoes';
        } else {
          return 'Wear a yellow dress shirt, navy dress pants, and black dress shoes';
        }
      } else {
        if (color == 'red') {
          return 'Wear a red tank top, black leggings, and running shoes';
        } else if (color == 'blue') {
          return 'Wear a blue sports bra, black yoga pants, and running shoes';
        } else if (color == 'green') {
          return 'Wear a green athletic top, black leggings, and running shoes';
        } else {
          return 'Wear a yellow tank top, black shorts, and running shoes';
        }
      }
    } else if (weather == 'cool') {
      if (style == 'casual') {
        if (color == 'red') {
          return 'Wear a red sweater, blue jeans, and brown boots';
        } else if (color == 'blue') {
          return 'Wear a blue hoodie, black jeans, and white sneakers';
        } else if (color == 'green') {
          return 'Wear a green sweater, gray jeans, and black boots';
        } else {
          return 'Wear a yellow cardigan, brown corduroy pants, and black boots';
        }
      } else if (style == 'formal') {
        if (color == 'red') {
          return 'Wear a red dress shirt, black dress pants, black dress shoes, and a black blazer';
        } else if (color == 'blue') {
          return 'Wear a blue dress shirt, gray dress pants, brown dress shoes, and a gray blazer';
        } else if (color == 'green') {
          return 'Wear a green dress shirt, beige dress pants, brown dress shoes, and a beige blazer';
        } else {
          return 'Wear a yellow dress shirt, navy dress pants, black dress shoes, and a navy blazer';
        }
      } else {
        if (color == 'red') {
          return 'Wear a red sweatshirt, black leggings, and white sneakers';
        } else if (color == 'blue') {
          return 'Wear a blue hoodie, black yoga pants, and white sneakers';
        } else if (color == 'green') {
          return 'Wear a green sweater, black leggings, and black boots';
        } else {
          if (color == 'red') {
            return 'Wear a red sweatshirt, black leggings, and white sneakers';
          } else if (color == 'blue') {
            return 'Wear a blue hoodie, black yoga pants, and white sneakers';
          } else if (color == 'green') {
            return 'Wear a green sweater, black leggings, and black boots';
          } else if (color == 'yellow') {
            return 'Wear a yellow t-shirt, blue jeans, and brown boots';
          } else {
            return 'Unable to suggest an outfit for the selected color';
          }
        }
      }
    }
  }
}
