import 'package:flutter/material.dart';

class Movie
{
  String title;
  int year;
  num duration;
  String? image;

  Movie({required this.title, required this.year, required this.duration, this.image});
}

class MovieModel extends ChangeNotifier {
  /// Internal, private state of the list.
  final List<Movie> items = [];

  //Normally a model would get from a database here, we are just hardcoding some data for this week
  MovieModel()
  {
    add(Movie(title:"Lord of the Rings", year:2001, duration:9001, image:"https://upload.wikimedia.org/wikipedia/en/f/fb/Lord_Rings_Fellowship_Ring.jpg"));
    add(Movie(title:"The Matrix", year:1999, duration:150, image:"https://m.media-amazon.com/images/I/91-rkATc5iL.__AC_SX300_SY300_QL70_ML2_.jpg"));
  }

  void add(Movie item) {
    items.add(item);
    update();
  }

  // This call tells the widgets that are listening to this model to rebuild.
  void update()
  {
    notifyListeners();
  }
}
