import 'package:flutter/material.dart';
import 'package:mtrak/description.dart';
import 'package:mtrak/utils/text.dart';
import 'package:mtrak/widgets/nowPlayingPage.dart';
import 'package:mtrak/widgets/topRated.dart';
import 'package:mtrak/widgets/moviesPage.dart';
import 'package:mtrak/widgets/trending.dart';
import 'package:mtrak/widgets/trendingPage.dart';
import 'package:mtrak/widgets/tv.dart';
import 'package:mtrak/widgets/tvPage.dart';
import 'package:mtrak/widgets/upcomingMoviesPage.dart';
import 'package:tmdb_api/tmdb_api.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.green,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
        ),
        elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.black),
          ),
        ),
      ),
      home: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String API_KEY = "9e22c17297722ec031db2f1415424f11";
  final String READ_ACCESS_TOKEN =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5ZTIyYzE3Mjk3NzIyZWMwMzFkYjJmMTQxNTQyNGYxMSIsInN1YiI6IjYzNjUwODBjZDhkMzI5MDA3YTRmOTMwMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.XevStwfTlt9lAci9p2CbbgoKJSnQRvXS-Y-PGTtocYc";

  List nowPlayingMovies = [];
  List topRatedMovies = [];
  List trendingMovies = [];
  List tv = [];
  List upcomingMovies = [];

  @override
  void initState() {
    loadMovies();
    super.initState();
  }

  loadMovies() async {
    TMDB tmdbWithCustomLogs = TMDB(ApiKeys(API_KEY, READ_ACCESS_TOKEN),
        logConfig: const ConfigLogger(showLogs: true, showErrorLogs: true));

    Map upcomingMoviesResult = await tmdbWithCustomLogs.v3.movies.getUpcoming();
    Map nowPlayingMoviesResult =
        await tmdbWithCustomLogs.v3.movies.getNowPlaying();
    Map trendingResult = await tmdbWithCustomLogs.v3.trending.getTrending();
    Map topRatedResult = await tmdbWithCustomLogs.v3.movies.getTopRated();
    Map tvResult = await tmdbWithCustomLogs.v3.tv.getPopular();

    setState(() {
      nowPlayingMovies = nowPlayingMoviesResult['results'];
      upcomingMovies = upcomingMoviesResult['results'];
      trendingMovies = trendingResult['results'];
      topRatedMovies = topRatedResult['results'];
      tv = tvResult['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const modified_text(
            text: "MTRAK❤️",
            color: Colors.white,
            size: 26.0,
          ),
        ),
        drawer: Drawer(
          backgroundColor: Colors.black,
          width: 250.0,
          child: Container(
            padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
            child: Column(
              children: [
                const Flexible(
                  flex: 5,
                  child: SizedBox(
                    height: 100.0,
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Scaffold(
                            appBar: AppBar(backgroundColor: Colors.black),
                            backgroundColor: Colors.black,
                            body: TrendingPage(
                              trending: trendingMovies,
                            ),
                          ),
                        ),
                      );
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.trending_up_sharp),
                        SizedBox(
                          width: 50.0,
                        ),
                        Text("Trending"),
                      ],
                    ),
                  ),
                ),
                const Flexible(
                  flex: 1,
                  child: SizedBox(
                    height: 10.0,
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Scaffold(
                            appBar: AppBar(backgroundColor: Colors.black),
                            backgroundColor: Colors.black,
                            body: ListView(
                              scrollDirection: Axis.vertical,
                              children: [
                                NowPlayingMovies(
                                  nowPlayingMovies: nowPlayingMovies,
                                ),
                                UpcomingMovies(
                                  upcomingMovies: upcomingMovies,
                                ),
                                TopRated(
                                  topRated: topRatedMovies,
                                ),
                                TrendingMovies(
                                  trending: trendingMovies,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.movie),
                        SizedBox(
                          width: 50.0,
                        ),
                        Text("Movies"),
                      ],
                    ),
                  ),
                ),
                const Flexible(
                  flex: 1,
                  child: SizedBox(
                    height: 10.0,
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Scaffold(
                            appBar: AppBar(backgroundColor: Colors.black),
                            backgroundColor: Colors.black,
                            body: TVPage(
                              tv: tv,
                            ),
                          ),
                        ),
                      );
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.tv),
                        SizedBox(
                          width: 50.0,
                        ),
                        Text("TV Shows"),
                      ],
                    ),
                  ),
                ),
                const Flexible(
                  flex: 1,
                  child: SizedBox(
                    height: 10.0,
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Row(
                      children: const [
                        Icon(Icons.bookmarks_sharp),
                        SizedBox(
                          width: 50.0,
                        ),
                        Text("Watchlist"),
                      ],
                    ),
                  ),
                ),
                const Flexible(
                  flex: 1,
                  child: SizedBox(
                    height: 10.0,
                  ),
                ),
                const Flexible(
                  flex: 40,
                  child: SizedBox.expand(),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Scaffold(
                            appBar: AppBar(backgroundColor: Colors.black),
                            backgroundColor: Colors.black,
                            body: Container(),
                          ),
                        ),
                      );
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.settings),
                        SizedBox(
                          width: 50.0,
                        ),
                        Text("Settings"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: ListView(
          children: [
            TV(tv: tv),
            TopRated(topRated: topRatedMovies),
            TrendingMovies(trending: trendingMovies),
          ],
        ),
      ),
    );
  }
}
