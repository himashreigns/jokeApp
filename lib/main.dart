import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'joke_service.dart';
import 'joke.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Joke App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: JokeHomePage(),
    );
  }
}

class JokeHomePage extends StatefulWidget {
  @override
  _JokeHomePageState createState() => _JokeHomePageState();
}

class _JokeHomePageState extends State<JokeHomePage> {
  final JokeService _jokeService = JokeService();
  List<Joke> jokes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadJokes();
  }

  Future<void> _loadJokes() async {
    setState(() {
      isLoading = true;
    });

    try {
      final newJokes = await _jokeService.fetchJokes();
      setState(() {
        jokes = newJokes.take(5).toList();
      });
    } catch (e) {
      final cachedJokes = await _jokeService.getCachedJokes();
      setState(() {
        jokes = cachedJokes.take(5).toList();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Loading cached jokes')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white!, Colors.purple[400]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Highlighted Heading
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'TOP 5 JOKES',
                  style: TextStyle(
                    fontSize: 40, // Larger font size for better emphasis
                    fontWeight: FontWeight.w900, // Bold weight
                    letterSpacing: 2, // Spacing for a premium look
                    foreground: Paint()
                      ..shader = LinearGradient(
                        colors: [
                          // Colors.cyan[300]!,
                          Colors.purple[500]!,
                          Colors.pink[400]!
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(Rect.fromLTWH(0.0, 0.0, 300.0, 100.0)),
                    shadows: [
                      // Shadow(
                      //   blurRadius: 12.0,
                      //   color: Colors.black26,
                      //   offset: Offset(3, 3),
                      // ),
                      // Shadow(
                      //   blurRadius: 12.0,
                      //   color: Colors.purple.withOpacity(0.5),
                      //   offset: Offset(-3, -3),
                      // ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              // Enhanced Fetch Jokes Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GestureDetector(
                  onTap: _loadJokes,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.purple, Colors.pink],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.pink.withOpacity(0.4),
                          blurRadius: 12,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 48, vertical: 18),
                      child: Text(
                        'Fetch Jokes',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),

              // Jokes List
              Expanded(
                child: isLoading
                    ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 6,
                  ),
                )
                    : ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: jokes.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 6,
                      margin: EdgeInsets.only(bottom: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: LinearGradient(
                            colors: [
                              Colors.blue[50]!,
                              Colors.purple[50]!
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius:
                                      BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      '#${index + 1}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      jokes[index].setup,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12),
                              Text(
                                jokes[index].punchline,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[700],
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
