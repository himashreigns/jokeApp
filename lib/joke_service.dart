import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'joke.dart';

class JokeService {
  final String apiUrl = "https://official-joke-api.appspot.com/jokes/programming/ten";

  Future<List<Joke>> fetchJokes() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      List<Joke> jokes = jsonResponse.map((joke) => Joke.fromJson(joke)).toList();
      _cacheJokes(jokes);
      return jokes;
    } else {
      throw Exception('Failed to load jokes');
    }
  }

  void _cacheJokes(List<Joke> jokes) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> jsonJokes = jokes.map((joke) => json.encode(joke.toJson())).toList();
    prefs.setStringList('cached_jokes', jsonJokes);
  }

  Future<List<Joke>> getCachedJokes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? jsonJokes = prefs.getStringList('cached_jokes');
    if (jsonJokes != null) {
      return jsonJokes.map((joke) => Joke.fromJson(json.decode(joke))).toList();
    }
    return [];
  }
}