import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:movie_search_app/models/movieData.dart';




class MovieService {
  var movies = List<MovieData>();




  Future<List<MovieData>> fetchMovieList(String searchText,int currentIndex) async {


    List<String> fetchGenreList(var genreData , List<dynamic> genreIds) {
      List<String> GenreList = [];
      for(int i = 0 ; i<genreIds.length ; i++) {
        for(var item in genreData) {
          if(int.parse(genreIds[i].toString()) == item['id']) {
            GenreList.add(item['name']);//Genre id to Genre<String>  Conversion
          }
        }

      }
      return GenreList;

    }
    try {
      http.Response genreResponse = await http.get("https://api.themoviedb.org/3/genre/movie/list?api_key=3df6568946416299672303c119143725&language=en-US");
      Map<String,dynamic> jsonGenreData = jsonDecode(genreResponse.body); //Total Genre Data



      http.Response response = await http.get(
          "https://api.themoviedb.org/3/search/movie?api_key=3df6568946416299672303c119143725&language=en-US&query=${searchText}&page=${currentIndex}&include_adult=false");

      if (response.statusCode == 200) {
        print("Status code" + response.statusCode.toString());
        final jsonData = json.decode(response.body);
        print(jsonData);//Response for the search Text
        List<MovieData> movieResponseList = [];
        for (var item in jsonData['results']) {
          var movie = MovieData(
              title: item['title'],
              imageurl: item['poster_path'],
              rating: double.parse(item['vote_average'].toString()),
              genre: fetchGenreList(jsonGenreData['genres'], item['genre_ids']),
          );
          movieResponseList.add(movie);//provide search Data
          this.movies.add(movie);//summing up the data
        }
        print(movies.length.toString());



        return movies;
      }
    }//Try catch for fetching Data From Server
    catch (e) {
      print("From http Catch Error " + e.toString());
    }

    return movies;
  }
}