import 'dart:collection';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/stories.dart';

enum StoryType { TopStories, NewStories }

class AppState with ChangeNotifier {
  List _topStoriesIds = [];
  List _newStoriesIds = [];

  List<Stories> _topStories = [];
  List<Stories> _newStories = [];

  var _cache = HashMap<int, Stories>();

  final String baseUrl = "https://hacker-news.firebaseio.com/v0/";

  bool _topIsLoading = true;
  bool _newIsLoading = true;

  StoryType _storyType = StoryType.NewStories;

  AppState._() {
    _updateStories(_storyType);
  }

  List<Stories> get stories {
    if (_storyType == StoryType.NewStories) return _newStories;
    return _topStories;
  }

  bool get isLoading {
    if (_storyType == StoryType.NewStories) return _newIsLoading;
    return _topIsLoading;
  }

  List<Stories> get allStories {
    var _allStories = List<Stories>();
    _allStories.addAll(_newStories);
    _allStories.addAll(_topStories);
    return _allStories;
  }

  set storyType(StoryType type) {
    _storyType = type;
    _updateStories(type);
  }

  factory AppState() {
    return AppState._();
  }

  Future<List> initStories(StoryType type) async {
    String endpoint = type == StoryType.NewStories ? "new" : "top";
    String url = "$baseUrl${endpoint}stories.json";

    final res = await http.get(url);

    if (res.statusCode != 200) throw "Couldn't fetch stories";

    return jsonDecode(res.body);
  }

  Future<Stories> _getStory(int id) async {
    if (!_cache.containsKey(id)) {
      final url = "${baseUrl}item/$id.json";
      final res = await http.get(url);
      if (res.statusCode != 200) throw "Couldn't fetch stories";
      _cache[id] = parseStories(res.body);
    }
    return _cache[id];
  }

  Future _updateStories(StoryType type) async {
    if ((type == StoryType.NewStories && _newStories.isEmpty) ||
        (type == StoryType.NewStories && _topStories.isEmpty)) {
      var stortIds = await initStories(type);
      type == StoryType.NewStories
          ? _newStoriesIds = stortIds
          : _topStoriesIds = stortIds;
      for (int id in stortIds) {
        Stories newStories = await _getStory(id);
        type == StoryType.NewStories
            ? _newStories.add(newStories)
            : _topStories.add(newStories);
      }
    }
    type == StoryType.NewStories
        ? _newIsLoading = false
        : _topIsLoading = false;
    notifyListeners();
  }
}
