import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: Ch7RowColumn(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      body: Column(
        children: [
          Text('A random idea:'),
          Text(appState.current.asLowerCase),
        ],
      ),
    );
  }
}

class Ch7RowColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Row and Column'),
      ),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                child: Container(
                  color: Colors.purpleAccent,
                  child: Text(
                    'Mountain',
                    style: _textStyle,
                  ),
                ),
              ),
              Card(
                child: Container(
                  color: Colors.greenAccent,
                  child: Text('Beach', style: _textStyle),
                ),
              ),
              Card(
                child: Container(
                  color: Colors.blue,
                  child: Text('Lake', style: _textStyle),
                ),
              ),
            ],
          ),
          Card(
            child: Container(
              height: 150.0,
              child: Image.network(
                  'https://mixkit.imgix.net/art/preview/mixkit-desert-landscape-under-a-bright-sun-86-original-large.png?q=80&auto=format%2Ccompress&h=700&q=50&dpr=2'),
            ),
          ),
          Card(
            child: Container(
              height: 150.0,
              child: Image.network(
                  'https://mixkit.imgix.net/art/preview/mixkit-starry-night-sky-over-hills-and-water-85-original-large.png?q=80&auto=format%2Ccompress&h=700&q=50&dpr=2'),
            ),
          ),
          Card(
            child: Container(
                height: 150.0,
                child: Image.network(
                    'https://mixkit.imgix.net/art/preview/mixkit-people-sunbathing-on-the-beach-73-original-large.png?q=80&auto=format%2Ccompress&h=700&q=50&dpr=2')),
          ),
        ],
      ),
    );
  }

  TextStyle get _textStyle => TextStyle(color: Colors.white, fontSize: 20.0);
}