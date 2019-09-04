import 'package:flutter/material.dart';
import 'package:notifier/state/app_state.dart';
import 'state/theme_state.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeState>.value(
          value: ThemeState(),
        ),
        ChangeNotifierProvider<AppState>.value(
          value: AppState(),
        ),
      ],
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
        leading: Provider.of<AppState>(context).isLoading
            ? Container(
                padding: EdgeInsets.all(10),
                child: CircularProgressIndicator(
                  backgroundColor: themeData.getTheme().canvasColor,
                ),
              )
            : Container(
                padding: EdgeInsets.all(10),
                child: Image.network(
                  'https://hn.algolia.com/assets/logo-hn-search.png',
                ),
              ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: StorySearch(),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.color_lens),
            onPressed: () {
              themeData.toggleTheme();
            },
          ),
        ],
      ),
      body: Consumer<AppState>(
        builder: (context, state, _) => ListView(
          children: state.stories.map((story) => _buildTile(story)),
        ),
      ),
      bottomNavigationBar: BottomAppBar(),
    );
  }
}

class StorySearch extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return null;
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return null;
  }
}
