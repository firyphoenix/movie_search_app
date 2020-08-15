import 'package:flutter/foundation.dart';
import 'package:movie_search_app/models/movieData.dart';
import 'package:movie_search_app/services/MovieService.dart';

class MovieProvider extends ChangeNotifier {
  MovieService _movieService = new MovieService();
  List<MovieData> _movieList = [];
  int currentIndex = 1;
  String oldText;

  List<MovieData> get fetchMovies {
    return this._movieList;

  }




  void searchMovies(String text,int searchindex) async {
  this._movieList.clear();
    this._movieList = await this._movieService.fetchMovieList(text, searchindex);
    notifyListeners();
  }
}