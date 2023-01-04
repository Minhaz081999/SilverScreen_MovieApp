import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:silverscreen3/details.dart';
import 'package:silverscreen3/splashscreen.dart';
import 'package:silverscreen3/youtubepage.dart';
import 'package:silverscreen3/youtubepage2.dart';

class Details2 extends StatefulWidget {

  //const Details2({Key? key}) : super(key: key);
  Details2({required this.receivedata,required this.movieID,});

  var receivedata;
  var movieID;

  @override
  State<Details2> createState() => _Details2State(receivedata,movieID);
}

class _Details2State extends State<Details2> {
  _Details2State(this.receivedata,this.movieID);
  var receivedata;
  var movieID;


 var movieKey;
  var posts;
  var data ;
  var unfilterData;

  Future <bool>loadJsonData(String str3 ) async{

    String serviceUrl = "https://api.themoviedb.org/3/movie/"+str3+"/videos?api_key=38e61227f85671163c275f9bd95a8803&language=en-US";
    var response = await http.get(Uri.parse (serviceUrl));

    print(response.body);

  setState(() {
    posts = json.decode(response.body.toString());
    data = posts["results"];
    print(posts);
    print("-------x------");
    movieKey = data[0]["key"];
    print(movieKey);
  });
    //this.unfilterData = data;
    return true;
  }
  void initState(){
    super.initState();
    this.loadJsonData(movieID);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar (

        flexibleSpace: Image.network("https://dcassetcdn.com/profile_pics/797680/0afaca4e-6990-4224-b674-d64c23045351.png",fit: BoxFit.cover,),
        toolbarHeight: 110,
        // backgroundColor: Colors.black,
        // title:  Text ("Sliver Screen 🎬",style : TextStyle(fontStyle: FontStyle.italic)),
      ),

      body: Container(

        child: ListView(
          children: [
            Container(
              height: 250,
              child: Stack(
                children: [

                  GestureDetector(
                    child: Center(child: Container(
                      height: 250,
                      width: MediaQuery.of(context).size.width,

                      child: Image.network("https://image.tmdb.org/t/p/w500" +
                          receivedata['backdrop_path'] ,  fit: BoxFit.fitHeight,),

                      decoration: BoxDecoration(
                        
                        border: Border.all(width: 10.0, color: Colors.white),

                      ),
                    ),

                      // onPressed: (){
                      //   Navigator.push(context, MaterialPageRoute(builder: (context) => YoutubePage( youdata: receivedata["id"],)));
                      // },
                    ),

                  ),

                  // Positioned(child: Container(
                  //   // decoration: BoxDecoration(
                  //   //   borderRadius: BorderRadius.circular(20),
                  //   //   border: Border.all(width: 5.0, color: Colors.white70)
                  //   // ),
                  //   height: 250,
                  //   width: MediaQuery.of(context).size.width,
                  //   child: Image.network("https://image.tmdb.org/t/p/w500" +
                  //       receivedata['backdrop_path'] ,  fit: BoxFit.fitHeight,),
                  //   decoration: BoxDecoration(
                  //       border: Border.all(width: 10.0, color: Colors.white),
                  //
                  //   ),
                  // ))
                ],
              ),
            ),

            Row(
              children: [
                Flexible(
                    child: Container(
                      padding:  const EdgeInsets.all(4.0),
                      child: Text("Title : " + receivedata["original_title"] , style: TextStyle(color: Colors.white70 ,fontWeight: FontWeight.bold,fontSize: 20),
                      ),

                    )
                ),
                SizedBox(width: 10,),

                Flexible(child: Container(
                  child : MaterialButton(

                      color : Colors.blueGrey,
                      child: Text("Watch Trailer",style:TextStyle(fontSize: 20,color:Colors.white,fontStyle: FontStyle.italic)),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => YoutubePage( youdata: receivedata["id"].toString(),store: movieKey ?? " ")));
                      }

                  ),

                ),
                ),
              ],
            ),
            Expanded(child: Container(
              padding:  const EdgeInsets.all(6.0),
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text("Release Date : " + receivedata["release_date"] , style: TextStyle(color: Colors.white70 ,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,fontSize: 17),
                  ),
                  SizedBox(height: 8,),
                  Text("Vote Average :⭐ " + receivedata["vote_average"].toString() + "/10" , style: TextStyle(color: Colors.white70 ,fontWeight: FontWeight.bold,fontSize: 17),
                  ),
                ],
              ),

            )),
            Row(
              children: [

                Flexible(
                    child: Container(
                      padding:  const EdgeInsets.all(6.5),
                      child: Text.rich (
                        TextSpan(children: <TextSpan>[
                          TextSpan(text: "Overview : ",
                          style: TextStyle(color: Colors.white70,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,fontSize: 20),
                          ),
                          TextSpan(text : receivedata["overview"].toString() , style: TextStyle(color: Colors.white70 ,fontStyle: FontStyle.italic,fontSize: 17),
                          ),
                        ],
                        ),
                      ),

                    )
                ),

              ],
            )
          ],
        ),
      ),
    );
  }
}


