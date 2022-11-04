import 'package:flutter/material.dart';
import 'package:mtrak/description.dart';
import 'package:mtrak/utils/text.dart';
import 'package:tmdb_api/tmdb_api.dart';

class TopRatedPage extends StatelessWidget {
  final List topRated;

  const TopRatedPage({super.key, required this.topRated});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const modified_text(
            text: "Top Rated Movies",
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
                itemCount: topRated.length,
                scrollDirection: Axis.vertical,
                itemBuilder: ((context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Description(
                                  name: topRated[index]["title"],
                                  description: topRated[index]['overview'],
                                  bannerurl: 'https://image.tmdb.org/t/p/w500' +
                                      topRated[index]['backdrop_path'],
                                  posterurl: 'https://image.tmdb.org/t/p/w500' +
                                      topRated[index]['poster_path'],
                                  vote: topRated[index]['vote_average']
                                      .toString(),
                                  lanch_on: topRated[index]['release_date'])));
                    },
                    child: topRated[index]['title'] != null
                        ? Container(
                            width: 140.0,
                            child: Column(
                              children: [
                                Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          'https://image.tmdb.org/t/p/w500' +
                                              topRated[index]['backdrop_path']),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: modified_text(
                                    text: topRated[index]['title'] ??
                                        "Loading...!",
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