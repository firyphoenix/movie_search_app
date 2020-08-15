import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_search_app/models/movieData.dart';



var imgurl = "https://i1.wp.com/www.socialnews.xyz/wp-content/uploads/2019/04/06/Arjun-Reddy-Hindi-remake-Kabir-Singh-First-Look-Poster-.jpg?w=676&quality=90&zoom=1&ssl=1";
var movieName = "Kabir Singh";
var genre = ["Drama","Romance"];
var rating = 7.2;
var lightText = TextStyle(
    color: Colors.blueGrey,fontWeight: FontWeight.w500,
    fontSize: 14
);



class MovieTile extends StatelessWidget {
  MovieData movieData;
  MovieTile({this.movieData});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,

      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.grey,
                spreadRadius: 1,
                offset: Offset(1,1),
                blurRadius: 6
            )
          ]
      ),
      padding: EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 240,
            width: 140,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage("https://image.tmdb.org/t/p/w500" +
                        movieData.imageurl,
                    ),
                    fit: BoxFit.fill
                ),
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(8)
            ),
          ),
          SizedBox(width: 28,),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height : 32),
                movieData.title.length > 18 ? Text(movieData.title.substring(0,21),style:TextStyle(
                    color: Colors.black,
                    fontSize: 26,
                    fontWeight: FontWeight.bold
                ) ,) :
                Text(movieData.title,style: TextStyle(
                    color: Colors.black,
                    fontSize: 26,
                    fontWeight: FontWeight.bold
                ),),
                SizedBox(height:12),
                Row(
                  children: <Widget>[
                    Text("Genre : ",style: lightText,),
                    Expanded(
                      flex: 1,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: movieData.genre == null ? Text("Uncharted",style: lightText,): movieData.genre.map((e) => Text(e + " ",style: lightText,)).toList(),
                        ),
                      ),
                    )
                  ],
                ),

                SizedBox(height: 16,),
                Row(
                  children: <Widget>[
                    Text(movieData.rating.toString(),style: TextStyle(color: Colors.blue,fontSize: 24,fontWeight: FontWeight.w500),),
                    SizedBox(width: 12,),
                    RatingBar(itemSize: 20,
                      direction: Axis.horizontal,
                      minRating: 1,
                      unratedColor: Colors.blueGrey,
                      itemCount: 5,
                      initialRating:
                      movieData.rating/2,
                      allowHalfRating: true,
                      onRatingUpdate: (value) {},
                      itemBuilder: (context,_) => Icon(Icons.star,color: Colors.deepOrange,),
                      itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                    )
                  ],
                )




              ],
            ),
          )

        ],
      ),
    );
  }
}


