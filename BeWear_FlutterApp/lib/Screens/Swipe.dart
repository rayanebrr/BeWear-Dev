import 'package:clothewardrobe/Screens/Login.dart';
import 'package:clothewardrobe/Screens/Profile.dart';
import 'package:clothewardrobe/Screens/Splash.dart';
import 'package:clothewardrobe/Screens/WardrobeSelector.dart';
import 'package:flutter/material.dart';
import 'package:swipe_cards/swipe_cards.dart';

import 'AI.dart';
import 'Favorite.dart';

class Content {
  String title;
  String imageAssetPath;

  Content(this.title, this.imageAssetPath);

  @override
  String toString() {
    return '$title: $imageAssetPath';
  }
}

List<Content> contents = [
  Content('Red', 'images/profil.png'),
  Content('Blue', 'images/star.png'),
  Content('Teal', 'images/swipe.png'),
  Content('Orange', 'images/mon.png'),
];

List<String> contentTitles = contents.map((content) => content.title).toList();

class SwipeCardPage extends StatefulWidget {
  const SwipeCardPage({Key? key}) : super(key: key);

  @override
  State<SwipeCardPage> createState() => _SwipeCardPageState();
}

class _SwipeCardPageState extends State<SwipeCardPage> {
  late MatchEngine _matchEngine;
  late List<SwipeItem> _SwipeItems;
  late bool _isNoItem = false;
  List<Content> favoriteContents = [];

  int _index = 0;
  List<Widget> screens = [];

  void reset() {
    _SwipeItems = [];
    for (var content in contents) {
      var swipeItem = SwipeItem(
        content: content,
      );
      _SwipeItems.add(swipeItem);
    }

    _matchEngine = MatchEngine(swipeItems: _SwipeItems);
    _isNoItem = false;
  }

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
    reset();
    _index = 2;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffD0D0DF),
      body: Padding(
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
                  'Swipe',
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
                child: _isNoItem
                    ? Align(
                        alignment: Alignment.center,
                        child: const Center(
                          child: Text('No Item'),
                        ),
                      )
                    : Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            child: SwipeCards(
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: SizedBox(
                                    width: 300,
                                    height: 400,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(117),
                                      ),
                                      color: Color(0xfff5f5f5),
                                      // set background color here
                                      child: Center(
                                        child: Image.asset(
                                          contents[index].imageAssetPath,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              matchEngine: _matchEngine,
                              onStackFinished: () {
                                print('onStackFinished');
                                setState(() {
                                  _isNoItem = true;
                                });
                              },
                            ),
                          ),
                        ],
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
      floatingActionButton: Padding(
        padding: EdgeInsets.only(top: 600, left: 5),
        child: Align(
          alignment: Alignment.topCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FloatingActionButton(
                onPressed: () {
                  _matchEngine.currentItem!.nope();
                },
                child: Image.asset('images/remove.png', height: 24),
                backgroundColor: Colors.white,
              ),
              FloatingActionButton(
                onPressed: () {
                  _matchEngine.currentItem!.like();
                  setState(() {
                    favoriteContents.add(_matchEngine.currentItem!.content);
                    debugPrint('favoriteContents: $favoriteContents');
                  });
                },
                child: Image.asset('images/star.png', height: 24),
                backgroundColor: Colors.white,
              ),
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    reset();
                  });
                },
                child: Icon(Icons.restore),
                backgroundColor: Colors.white,
                foregroundColor: Color(0xffef8100),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
