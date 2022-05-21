import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'movie_details.dart';
import 'movie.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    //BEGIN: the old MyApp builder from last week
    return ChangeNotifierProvider(
        create: (context) => MovieModel(),
        child: MaterialApp(
            title: 'Database Tutorial',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: MyHomePage(title: 'Database Tutorial')
        )
    );
    //END: the old MyApp builder from last week
  }
}

class MyHomePage extends StatefulWidget
{
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage>
{
  @override
  Widget build(BuildContext context) {
    return Consumer<MovieModel>(
        builder:buildScaffold
    );
  }

  Scaffold buildScaffold(BuildContext context, MovieModel movieModel, _) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            //YOUR UI HERE
            Expanded(
              child: ListView.builder(
                  itemBuilder: (_, index) {
                    var movie = movieModel.items[index];
                    var image = movie.image;
                    return ListTile(
                      title: Text(movie.title),
                      subtitle: Text(movie.year.toString() + " - " + movie.duration.toString() + " Minutes"),
                      leading: image != null ? Image.network(image) : null,

                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return MovieDetails(id: index);
                            }));
                      },
                    );
                  },
                  itemCount: movieModel.items.length
              ),
            )
          ],
        ),
      ),
    );
  }
}

//A little helper widget to avoid runtime errors -- we can't just display a Text() by itself if not inside a MaterialApp, so this workaround does the job
class FullScreenText extends StatelessWidget {
  final String text;

  const FullScreenText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection:TextDirection.ltr, child: Column(children: [ Expanded(child: Center(child: Text(text))) ]));
  }
}
