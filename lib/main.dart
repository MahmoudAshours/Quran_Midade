import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            FutureBuilder(
              future: loadAsset(),
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return CircularProgressIndicator();
                Map<String, dynamic> data =
                    json.decode(snapshot.data.toString());
                String _basmala = data['verse']['verse_1'];
                return Text(
                  _basmala,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'fath',
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                );
              },
            ),
            FutureBuilder(
              future: loadAsset(),
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return CircularProgressIndicator();
                Map<String, dynamic> data =
                    json.decode(snapshot.data.toString());
                Map<String, dynamic> _verses = data['verse'];
                return Container(
                  child: RichText(
                    maxLines: 15,
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'fath',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      
                      ),
                      children: mapIndexed(
                        _verses.values,
                        (index, item) => TextSpan(text: '$item '),
                      ).toList(),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Iterable<E> mapIndexed<E, T>(
      Iterable<T> items, E Function(int index, T item) f) sync* {
    var index = 0;

    for (final item in items) {
      yield f(index, item);
      index = index + 1;
    }
  }

  Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/JSON/surah_1.json');
  }
}
