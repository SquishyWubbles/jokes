import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jokes/my_joke_page.dart';

import 'joke.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Joke> allMyJokes = [];

  @override
  void initState() {
    super.initState();

    // initialize all jokes from json
    getAllMyJokes();
  }

  void getAllMyJokes() async {
    // SET empty list to fill with all jokes from json
    final _jokes = <Joke>[];

    try {
      // UNPACK the json file
      final _jsonJokes = await rootBundle
          .loadString('assets/data/jokes.json')
          .then((value) => jsonDecode(value));

      // LOOP through the unpacked json file and add all jokes
      // __ to empty joke list, with Joke model
      for (final _item in _jsonJokes) {
        _jokes.add(Joke.fromJson(_item));
      }

      // SET the filled json jokes list to 'allMyJokes' empty list
      setState(() {
        allMyJokes = _jokes;
      });
    } catch (e) {
      throw Exception();
    }
  }

  void getNextJoke() {
    // get next joke
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: ListView.builder(
                itemCount: allMyJokes.length,
                itemBuilder: (BuildContext context, int index) {
                  final _result = allMyJokes[index];

                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(children: [
                        Row(children: [Text(_result.title)]),
                        SizedBox(height: 10.0),
                        Row(children: [Text(_result.content)])
                      ]),
                    ),
                  );
                }),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MyJokePage(
                  title: 'myJokePage',
                  jokes: allMyJokes,
                ),
              ),
            ),
            child: Text('joke Page'),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getNextJoke,
        tooltip: 'Next Joke',
        child: Icon(Icons.add),
      ),
    );
  }
}
