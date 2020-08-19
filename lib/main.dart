import 'package:flutter/material.dart';
import 'package:movie_search_app/providers/MovieProvider.dart';
import 'package:movie_search_app/widgets/movietile.dart';
import 'package:provider/provider.dart';


void main() => runApp(
  MaterialApp(
    home: ChangeNotifierProvider(
      create: (context) => MovieProvider(),
      child: MyApp(),
    ),
  )
);

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int searchPageIndex = 1;
  TextEditingController _textController = new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color:  Color.fromRGBO(242, 247, 245,1),
        padding: EdgeInsets.all(8),

        child : Column(
          children: <Widget>[
            SizedBox(height:24),
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    Provider.of<MovieProvider>(context,listen: false).searchMovies(_textController.text, searchPageIndex);

                  },
                ),
                hintText: "Search Movies"
              ),
            ),

            SizedBox(height: 24,),
            Expanded(
              child: Consumer<MovieProvider>(
                builder: (context,data,child) {
                  var movies = data.fetchMovies;

                  if(movies == null) {
                    return Center(child: Text("No data Received"),);
                  }
                  return ListView.separated(
                      itemBuilder: (context,index) {
                        if(index>20) {
                          index = 0;
                        }
                        print(movies.length);

                        return MovieTile(movieItem : movies[index]);
                      },
                      separatorBuilder: (context,_) => SizedBox(height: 54,),
                      itemCount: movies == null ? 0 : movies.length);
                },
              ),//Data Consuming Here
            )
          ],
        )
      )
    );
  }
}
