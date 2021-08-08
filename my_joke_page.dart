import 'dart:math';

import 'package:flutter/material.dart';

import 'joke.dart';

class MyJokePage extends StatefulWidget {
  final String title;
  final List<Joke> jokes;

  MyJokePage({
    Key? key,
    required this.title,
    required this.jokes,
  }) : super(key: key);

  @override
  _MyJokePageState createState() => _MyJokePageState();
}

class _MyJokePageState extends State<MyJokePage> {
  List<Joke> allMyJokes = [];
  late Joke _currentJoke;

  @override
  void initState() {
    super.initState();

    // initialize all jokes from previous page
    allMyJokes = widget.jokes;

    // get the first joke
    _currentJoke = allMyJokes.first;
  }

  void getNextJoke() {
    // generates a new Random object
    final _random = new Random();

    // generate a random index based on the list length
    // and use it to retrieve the element
    final _newJoke = allMyJokes[_random.nextInt(allMyJokes.length)];

    // set new joke to old joke
    setState(() {
      _currentJoke = _newJoke;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Card(
        margin: EdgeInsets.all(10),
        color: Colors.green[100],
        shadowColor: Colors.blueGrey,
        elevation: 10,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.album, color: Colors.cyan, size: 45),
              title: Text(
                _currentJoke.title,
                style: TextStyle(fontSize: 20),
              ),
              subtitle: Text(_currentJoke.content),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getNextJoke,
        tooltip: 'Next Joke',
        child: Icon(Icons.add),
      ),
    );
  }
}
