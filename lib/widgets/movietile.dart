import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_search_app/models/movieData.dart';

var lightText = TextStyle(
    color: Colors.blueGrey, fontWeight: FontWeight.w500, fontSize: 14);

class MovieTile extends StatelessWidget {
  MovieData movieItem;
  MovieTile({this.movieItem});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3))
        ],
      ),
      height: 172,
      child: Stack(
        overflow: Overflow.visible,
        fit: StackFit.expand,
        children: <Widget>[
          Positioned(
            top: -36,
            width: 140,
            bottom: 12,
            child: buildPoster(movieItem.imageurl),
          ),
          Positioned(
              left: 165,
              bottom: 10,
              top: 12,
              right: 0,
              child: Container(

                  child:  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 16,),
                      buildTitle(movieItem.title),
                      SizedBox(height:12),
                      buildGenreList(movieItem.genre),
                      SizedBox(height: 16,),
                      buildRating(movieItem.rating)
                    ],
                  )

              )
          ),

        ],
      ),
    );
  }

  Widget buildRating(double rating) {
    return  Row(
      children: <Widget>[
        Text(rating.toString(),style: TextStyle(color: Colors.blue,fontSize: 24,fontWeight: FontWeight.w500),),
        SizedBox(width: 12,),
        RatingBar(itemSize: 20,
          direction: Axis.horizontal,
          minRating: 1,
          unratedColor: Colors.blueGrey,
          itemCount: 5,
          initialRating: movieItem.rating/2,
          allowHalfRating: true,
          onRatingUpdate: (value) {},
          itemBuilder: (context,_) => Icon(Icons.star,color: Colors.deepOrange,),
          itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
        )
      ],
    );
  }

  Widget buildGenreList(List<String> genreData) {
    return  Row(
      children: <Widget>[
        Text("Genre : ",style: lightText,),
        Expanded(
          flex: 1,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            //Genre of the Movie Goes Here
            child: Row(
              children: genreData == null ? Text("Uncharted",style: lightText,):genreData.map((e) => Text(e + " ",style: lightText,)).toList(),
            ),
          ),
        )
      ],
    );
  }
  Widget buildPoster(String url) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: NetworkImage(
              "https://image.tmdb.org/t/p/w500" + url),
        ),
      ),
    );
  }

  Widget buildTitle(String text) {
    var actualText = text;
//    if (text.length > 20) {
//      actualText = text.substring(0, 26);
//    }
    return Text(
      actualText,

      overflow: TextOverflow.clip,

      maxLines: 2,
      style: TextStyle(
          color: Colors.black, fontSize: 26, fontWeight: FontWeight.w500),
    );
  }
}
