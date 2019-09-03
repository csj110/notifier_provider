import 'package:flutter/material.dart';
import 'state/theme_state.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeState>(
      builder: (context) => ThemeState(),
      child: MyMaterialApp(),
    );
  }
}

class MyMaterialApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeData = Provider.of<ThemeState>(context);
    return MaterialApp(
      title: 'Notifier App',
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
      theme: themeData.getTheme(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeData = Provider.of<ThemeState>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.color_lens),
            onPressed: () {
              themeData.toggleTheme();
            },
          ),
        ],
      ),
      body: Container(),
      bottomNavigationBar: BottomAppBar(),
    );
  }
}
