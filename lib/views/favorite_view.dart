import 'package:anime_quotes_bloc/db/database.dart';
import 'package:anime_quotes_bloc/main.dart';
import 'package:anime_quotes_bloc/models/models.dart';
import 'package:flutter/material.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({Key? key}) : super(key: key);

  @override
  _FavoriteViewState createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  var db = MyDatabase();

  late Future<List<Quote>> quotes = db.fetchSavedQuotes();

  void afterSaved() {
    setState(() {
      quotes = db.fetchSavedQuotes();
    });
  }

  @override
  void initState() {
    super.initState();
    stream.listen((saved) {
      if (saved) afterSaved();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: quotes,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.length > 0) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.purple),
                            borderRadius: BorderRadius.circular(10)),
                        shadowColor: Colors.blue.shade100,
                        color: Colors.white10,
                        child: Column(children: [
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              '${snapshot.data![index].anime}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.toDouble(),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: Text(
                                    '${snapshot.data![index].quote}',
                                    style: const TextStyle(fontSize: 18.0),
                                  )),
                              IconButton(
                                  alignment: Alignment.centerRight,
                                  icon: const Icon(Icons.delete),
                                  color: Colors.red,
                                  onPressed: () {
                                    setState(() {
                                      db.deleteQuoteFromFavorite(
                                          '${snapshot.data![index].quote}');

                                      quotes = db.fetchSavedQuotes();
                                    });

                                    const removedSnackBar = SnackBar(
                                        duration: Duration(seconds: 1),
                                        content: Text(
                                          'Removed From Favorites',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                        backgroundColor: Colors.deepPurple);
                                    ScaffoldMessenger.of(context)
                                      ..removeCurrentSnackBar()
                                      ..showSnackBar(removedSnackBar);
                                  }),
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 10.0, top: 10),
                            child: Text(
                              '- ${snapshot.data![index].character} -',
                              style: const TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ]),
                      );
                    },
                  ),
                )
              ],
            );
          } else {
            return Stack(
              children: const [
                Center(
                  child: Text(
                    'No Data in the favorites',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontFamily: 'quoteScript'),
                  ),
                )
              ],
            );
          }
        } else if (snapshot.hasError) {
          return Stack(
            children: const [
              Center(
                child: Text('Failed to Load Favorites'),
              ),
              // Refresh()
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
