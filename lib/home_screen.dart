import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:silverscreen3/nowplaying.dart';

import 'details2.dart';
import 'main.dart';
import 'myhomepage.dart';
import 'now_playing.dart';




class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  var posts;
  var data ;
  var unfilterData;
  var str2 ;

  var post;
  var info;
// API
  Future <bool>loadHomeScreenData() async{

    String serviceUrl = "https://api.themoviedb.org/3/movie/now_playing?api_key=38e61227f85671163c275f9bd95a8803&language=en-US&page=1";

    var response = await http.get(Uri.parse (serviceUrl));

    print(response.body);

    setState(() {
      posts = json.decode(response.body.toString());
      data = posts["results"];
      print(posts);
      print("-------x------");
      print(data[0]["title"]);
      str2 = data[1]["id"].toString();
      print(str2);

    });

    return true;
  }


  void initState(){
    super.initState();
    this.loadHomeScreenData();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
    appBar: AppBar(
      flexibleSpace: Image.network("https://dcassetcdn.com/profile_pics/797680/0afaca4e-6990-4224-b674-d64c23045351.png",fit: BoxFit.cover,),
      toolbarHeight: 110,),

      body: Column (

        children: <Widget>[
          Row(
            children: [

              TextButton.icon(
                icon: Icon(Icons.search),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));

                }, label: Text("Search a movie name                                   ", style: TextStyle(color: Colors.grey.withOpacity(0.5),fontSize: 18),),
              ),
            ],
          ),
          Row(
            children: [SizedBox(width: 12),
              Container(
                child: Text("Recent Movies 🎬", style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,fontSize: 20),
                ),

              )


            ],

          ),
          Expanded(child: ListView.builder(
            scrollDirection: Axis.vertical,

            padding:  const EdgeInsets.all(8.0),

            itemCount:data == null ? 0:data.length,
            itemBuilder: ( BuildContext context,int index){
              return Container (

                //width: 120.0,
                height: 250.0,

                child:Row(
                  children: [
                    GestureDetector(
                      child: Container(
                        height: 500,
                        alignment: Alignment.centerLeft,
                        child: Card(
                          child: Image.network(
                              "https://image.tmdb.org/t/p/w500" +
                                  data[index]['poster_path']),
                        ),
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Details2( receivedata: data[index],movieID: data[index]["id"].toString(),)));
                      },
                    ),
                    SizedBox(width: 5,),
                    Expanded(
                      child: Container(
                        child: Column(

                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 1.0,
                            ),
                            Text(

                              data[index]["original_title"],
                              style: TextStyle(color: Colors.black ,fontWeight: FontWeight.bold,fontSize: 20),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text("Release Date: "+
                                data[index]["release_date"],
                              style: TextStyle(color: Colors.black,fontSize: 18),
                            ),
                            SizedBox(
                              height: 1,
                            ),
                            Text("Vote Average :⭐ "+
                                data[index]["vote_average"].toString() +"/10",
                              style: TextStyle(color: Colors.black,fontSize: 18),
                            ),
                            SizedBox(
                              height: 1,
                            ),
                            // Container(
                            //   height: 180,
                            //   child: Text("Description: "+
                            //     data[index]["genre_ids"].toString(),
                            //     style: TextStyle(color: Colors.black,fontSize: 12),
                            //     maxLines: 13,
                            //   ),
                            //
                            // ),

                          ],
                        ),
                      ),
                    ),
                  ],
                  // children: [
                  //   Padding(
                  //       padding:  const EdgeInsets.all(8.0),
                  //
                  //   child: Image.network("https://image.tmdb.org/t/p/w500/"+data[index]["poster_path"])),
                  //    Text(data[index]['title']),
                  //   Text(data[index]["overview"]),
                  // ],
                ),
              );

              // child: Image.network("https://image.tmdb.org/t/p/w500/"+data[index]["poster_path"]);
              //   return ListTile(
              // title: Text(data[index]['title']),
              //
              //   subtitle:Text(data[index]["overview"]),
              //
              // );
            },
          )),
        ],
      ),

      // body: Container (
      //   child: ListView(
      //     children: [
      //       Row(children : [
      //         TextButton.icon(
      //           icon: Icon(Icons.search),
      //           // child:Text("String"),
      //           onPressed: (){
      //             Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
      //
      //           }, label: Text("Search a movie name"),
      //         )
      //       ]
      //
      //       ),
      //
      //     ],
      //   ),
      //
      // ),
    );

  }
}