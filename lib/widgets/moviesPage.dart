import 'package:flutter/material.dart';
import 'package:mtrak/description.dart';
import 'package:mtrak/utils/text.dart';
import 'package:tmdb_api/tmdb_api.dart';

class MoviesPage extends StatelessWidget {
  const MoviesPage({super.key, required this.movies});

  final List movies;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const modified_text(
            text: "Upcoming Movies",
            size: 26.0,
            color: Colors.white,
          ),
          const SizedBox(
            height: 10,
          ),
          Flexible(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemCount: movies.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: ((context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Description(
                            movieId: movies[index]['id'],
                            name: movies[index]["title"],
                            description: movies[index]['overview'],
                            bannerurl: 'https://image.tmdb.org/t/p/w500' +
                                movies[index]['backdrop_path'],
                            posterurl: 'https://image.tmdb.org/t/p/w500' +
                                movies[index]['poster_path'],
                            vote: movies[index]['vote_average'].toString(),
                            lanch_on: movies[index]['release_date'],
                          ),
                        ),
                      );
                    },
                    child: movies[index]['title'] != null
                        ? Container(
                            padding: const EdgeInsets.all(5),
                            width: 250.0,
                            child: Column(
                              children: [
                                Container(
                                  width: 250,
                                  height: 140,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        'https://image.tmdb.org/t/p/w500' +
                                            movies[index]['backdrop_path'],
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  child: modified_text(
                                    text:
                                        movies[index]['title'] ?? "Loading...!",
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
