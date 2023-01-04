import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'main.dart';
import 'myhomepage.dart';
class Playing extends StatelessWidget {

  var posts;
  var data;

  var unfilterData;

  Future <bool> loadJsonData() async {
    // String serviceUrl = "https://api.themoviedb.org/3/movie/now_playing?api_key=38e61227f85671163c275f9bd95a8803";
    //  https://api.themoviedb.org/3/search/movie?api_key=38e61227f85671163c275f9bd95a8803&language=en-US&query=%22Black%20Adam%22&page=1&include_adult=false
    //   if(str == " "){
    //     str = "black adam";
    //   }
    String serviceUrl = "https://api.themoviedb.org/3/movie/now_playing?api_key=38e61227f85671163c275f9bd95a8803&language=en-US&page=1";
    var response = await http.get(Uri.parse(serviceUrl));

    print(response.body);



      posts = json.decode(response.body.toString());
      data = posts["results"];
      print(posts);
      print("-------x------");
      print(data[0]["title"]);

    this.unfilterData = data;
    return true;
  }





@override
Widget build(BuildContext context) {

  return Container(
    padding: EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Movies ',
        ),
        SizedBox(height: 10),
        Container(
          // color: Colors.red,
            height: 200,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(5),
                    // color: Colors.green,
                    width: 250,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://image.tmdb.org/t/p/w500' +
                                        data[index]['backdrop_path']),
                                fit: BoxFit.cover),
                          ),
                          height: 140,
                        ),
                        SizedBox(height: 5),
                        Container(
                          child: Text(

                               data[index]["original_title"]),
                        )
                      ],
                    ),
                  );
                }))
      ],
    ),
  );
}


}