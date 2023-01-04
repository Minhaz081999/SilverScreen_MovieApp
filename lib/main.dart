import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:silverscreen3/details.dart';
import 'package:silverscreen3/details2.dart';
import 'package:silverscreen3/splashscreen.dart';
import 'dart:async';
import 'dart:convert';
import 'home_screen.dart';
import 'myhomepage.dart';
import 'now_playing.dart';
import 'nowplaying.dart';
import 'package:vimeo_player_flutter/vimeo_player_flutter.dart';
void main() {
  ErrorWidget.builder = (FlutterErrorDetails datails) => Scaffold(body: Container(child:Text("",style: TextStyle(color: Colors.black ,fontWeight: FontWeight.bold),), ) ,);

  runApp( MaterialApp

    (home: SplashScreen(),
debugShowCheckedModeBanner: false,
  ));
}

class MyHomePage extends StatefulWidget {

  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var posts;
  var data ;
  var unfilterData;
  var str2 ;

  var post;
  var info;
// API
  Future <bool>loadJsonData(String str) async{

    String serviceUrl = "https://api.themoviedb.org/3/search/movie?api_key=38e61227f85671163c275f9bd95a8803&language=en-US&query="+str+"&page=1&include_adult=false";

    var response = await http.get(Uri.parse (serviceUrl));

    // String serviceUrl2 = "https://api.themoviedb.org/3/movie/"+str2+"/videos?api_key=38e61227f85671163c275f9bd95a8803&language=en-US";
    // var response2 = await http.get(Uri.parse(serviceUrl2));

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
  this.unfilterData = data;
  return true;
}

  // Future <bool>loadJsonData2(String str2) async{
  //
  //   String serviceUrl2 = "https://api.themoviedb.org/3/movie/"+str2+"/videos?api_key=38e61227f85671163c275f9bd95a8803&language=en-US";
  //   var response2 = await http.get(Uri.parse(serviceUrl2));
  //
  //   print(response2.body);
  //
  //   setState(() {
  //     post = json.decode(response2.body.toString());
  //     info = post["results"];
  //     print(post);
  //     print("-------x------");
  //     print(info[0]["key"].toString());
  //     str2 = info[0]["id"].toString();
  //     print(str2);
  //
  //   });
  //
  //   return true;
  // }



  void initState(){
  super.initState();
  loadJsonData("");

}
searchData(str){
    var strExist = str.length>0? true : false;
    if (strExist){
      var filterData = [];
      for (var i =0; i<unfilterData.length; i++)
        { String name = unfilterData[i]["title"].toUpperCase();
          if(name.contains(str.toUpperCase())){
            filterData.add (unfilterData[i]);
          }
        }
      setState(() {
        this.data = filterData;
      });
    }else{
      setState(() {
        this.data = this.unfilterData;
      });

    }
}
 @override
 Widget build(BuildContext context){


  return Scaffold (
    backgroundColor: Colors.white,
    appBar: AppBar(
      flexibleSpace: Image.network("https://dcassetcdn.com/profile_pics/797680/0afaca4e-6990-4224-b674-d64c23045351.png",fit: BoxFit.cover,),
      toolbarHeight: 110,
      // backgroundColor: Colors.black,
      // title:  Text ("Sliver Screen 🎬",style : TextStyle(fontStyle: FontStyle.italic)),

    ),

   body: Column (

     children: <Widget>[
       TextField(decoration: InputDecoration(
         hintText: "Search a movie name",
         hintStyle: TextStyle( fontWeight: FontWeight.bold,color: Colors.grey.withOpacity(0.7)),
         //label:Text (" Search a movie name",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey.withOpacity(0.7)))
       ),
         onChanged: (String str)
         {
           print(str);
           this.loadJsonData(str);
           this.searchData(str);
         },
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

  //   body:  ListView.builder(
  //
  //
  //       padding:  const EdgeInsets.all(8.0),
  //
  //       itemCount: data.length,
  //       itemBuilder: ( BuildContext context,int index){
  //         return Container (
  //           width: 120.0,
  //           height: 180.0,
  //           child:Row(
  //             children: [
  //               Container(
  //                 height: 500,
  //                 alignment: Alignment.centerLeft,
  //                 child: Card(
  //                   child: Image.network(
  //                       "https://image.tmdb.org/t/p/w500" +
  //                           data[index]['poster_path']),
  //                 ),
  //               ),
  //               SizedBox(width: 5,),
  //               Expanded(
  //                 child: Container(
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       SizedBox(
  //                         height: 1.0,
  //                       ),
  //                       Text(
  //                         data[index]["original_title"],
  //                         style: TextStyle(color: Colors.black),
  //                       ),
  //                       SizedBox(
  //                         height: 2,
  //                       ),
  //                       Text(
  //                         data[index]["release_date"],
  //                         style: TextStyle(color: Colors.black),
  //                       ),
  //                       SizedBox(
  //                         height: 1,
  //                       ),
  //                       Text(
  //                         data[index]["vote_average"].toString(),
  //                         style: TextStyle(color: Colors.black),
  //                       ),
  //                       SizedBox(
  //                         height: 1,
  //                       ),
  //                       Container(
  //                         height: 110,
  //                         child: Text(
  //                           data[index]["overview"],
  //                           style: TextStyle(color: Colors.black),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ],
  //             // children: [
  //             //   Padding(
  //             //       padding:  const EdgeInsets.all(8.0),
  //             //
  //             //   child: Image.network("https://image.tmdb.org/t/p/w500/"+data[index]["poster_path"])),
  //             //    Text(data[index]['title']),
  //             //   Text(data[index]["overview"]),
  //             // ],
  //           ),
  //         );
  //         // child: Image.network("https://image.tmdb.org/t/p/w500/"+data[index]["poster_path"]);
  //       //   return ListTile(
  //       // title: Text(data[index]['title']),
  //       //
  //       //   subtitle:Text(data[index]["overview"]),
  //       //
  //       // );
  //  },
  // ),
  );

}}
