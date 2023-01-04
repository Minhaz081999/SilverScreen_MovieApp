// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:async';
// import 'dart:convert';
//
// class MyHomePage extends StatefulWidget {
//
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   var posts;
//   var data ;
//   var unfilterData;
//
//   Future <bool>loadJsonData(String str) async{
//     // String serviceUrl = "https://api.themoviedb.org/3/movie/now_playing?api_key=38e61227f85671163c275f9bd95a8803";
//     //  https://api.themoviedb.org/3/search/movie?api_key=38e61227f85671163c275f9bd95a8803&language=en-US&query=%22Black%20Adam%22&page=1&include_adult=false
//     //   if(str == " "){
//     //     str = "black adam";
//     //   }
//     String serviceUrl = "https://api.themoviedb.org/3/search/movie?api_key=38e61227f85671163c275f9bd95a8803&language=en-US&query="+str+"&page=1&include_adult=false";
//     var response = await http.get(Uri.parse (serviceUrl));
//
//     print(response.body);
//
//
//
//     setState(() {
//       posts = json.decode(response.body.toString());
//       data = posts["results"];
//       print(posts);
//       print("-------x------");
//       print(data[0]["title"]);
//     });
//     this.unfilterData = data;
//     return true;
//   }
//
//   @override
//   void initState(){
//     super.initState();
//     loadJsonData("Black Adam");
//   }
//   searchData(str){
//     var strExist = str.length>0? true : false;
//     if (strExist){
//       var filterData = [];
//       for (var i =0; i<unfilterData.length; i++)
//       { String name = unfilterData[i]["title"].toUpperCase();
//       if(name.contains(str.toUpperCase())){
//         filterData.add (unfilterData[i]);
//       }
//       }
//       setState(() {
//         this.data = filterData;
//       });
//     }else{
//       setState(() {
//         this.data = this.unfilterData;
//       });
//
//     }
//   }
//   @override
//   Widget build(BuildContext context){
//
//     return Container (
//       // backgroundColor: Colors.blueGrey,
//       // appBar: AppBar(
//       //   backgroundColor: Colors.black38,
//       //   title: const Text ("Movie"),
//       //
//       // ),
//
//       child: Column (
//
//         children: <Widget>[
//           TextField(decoration: InputDecoration(
//               hintText: "Search a movie name"
//           ),
//             onChanged: (String str)
//             {
//               print(str);
//               this.loadJsonData(str);
//               this.searchData(str);
//             },
//           ),
//           Expanded(child: ListView.builder(
//
//
//             padding:  const EdgeInsets.all(8.0),
//
//             itemCount:data.length!,//data.length == null ? 0:data.length,
//             itemBuilder: ( BuildContext context,int index){
//               return Container (
//                 width: 120.0,
//                 height: 180.0,
//                 child:Row(
//                   children: [
//                     Container(
//                       height: 500,
//                       alignment: Alignment.centerLeft,
//                       child: Card(
//                         child: Image.network(
//                             "https://image.tmdb.org/t/p/w500" +
//                                 data[index]['poster_path']),
//                       ),
//                     ),
//                     SizedBox(width: 5,),
//                     Expanded(
//                       child: Container(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             SizedBox(
//                               height: 1.0,
//                             ),
//                             // Text("Title",
//                             //     style: TextStyle(color: Colors.black ,fontWeight: FontWeight.bold),
//                             // ),
//                             Text(
//
//                               data[index]["original_title"],
//                               style: TextStyle(color: Colors.black ,fontWeight: FontWeight.bold),
//                             ),
//                             SizedBox(
//                               height: 2,
//                             ),
//                             Text("Release Date: "+
//                                 data[index]["release_date"],
//                               style: TextStyle(color: Colors.black),
//                             ),
//                             SizedBox(
//                               height: 1,
//                             ),
//                             Text("⭐ "+
//                                 data[index]["vote_average"].toString(),
//                               style: TextStyle(color: Colors.black),
//                             ),
//                             SizedBox(
//                               height: 1,
//                             ),
//                             Container(
//                               height: 110,
//                               child: Text("Description: "+
//                                   data[index]["overview"],
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                   // children: [
//                   //   Padding(
//                   //       padding:  const EdgeInsets.all(8.0),
//                   //
//                   //   child: Image.network("https://image.tmdb.org/t/p/w500/"+data[index]["poster_path"])),
//                   //    Text(data[index]['title']),
//                   //   Text(data[index]["overview"]),
//                   // ],
//                 ),
//               );
//               // child: Image.network("https://image.tmdb.org/t/p/w500/"+data[index]["poster_path"]);
//               //   return ListTile(
//               // title: Text(data[index]['title']),
//               //
//               //   subtitle:Text(data[index]["overview"]),
//               //
//               // );
//             },
//           )),
//         ],
//       )
//       ,
//       //   body:  ListView.builder(
//       //
//       //
//       //       padding:  const EdgeInsets.all(8.0),
//       //
//       //       itemCount: data.length,
//       //       itemBuilder: ( BuildContext context,int index){
//       //         return Container (
//       //           width: 120.0,
//       //           height: 180.0,
//       //           child:Row(
//       //             children: [
//       //               Container(
//       //                 height: 500,
//       //                 alignment: Alignment.centerLeft,
//       //                 child: Card(
//       //                   child: Image.network(
//       //                       "https://image.tmdb.org/t/p/w500" +
//       //                           data[index]['poster_path']),
//       //                 ),
//       //               ),
//       //               SizedBox(width: 5,),
//       //               Expanded(
//       //                 child: Container(
//       //                   child: Column(
//       //                     crossAxisAlignment: CrossAxisAlignment.start,
//       //                     children: [
//       //                       SizedBox(
//       //                         height: 1.0,
//       //                       ),
//       //                       Text(
//       //                         data[index]["original_title"],
//       //                         style: TextStyle(color: Colors.black),
//       //                       ),
//       //                       SizedBox(
//       //                         height: 2,
//       //                       ),
//       //                       Text(
//       //                         data[index]["release_date"],
//       //                         style: TextStyle(color: Colors.black),
//       //                       ),
//       //                       SizedBox(
//       //                         height: 1,
//       //                       ),
//       //                       Text(
//       //                         data[index]["vote_average"].toString(),
//       //                         style: TextStyle(color: Colors.black),
//       //                       ),
//       //                       SizedBox(
//       //                         height: 1,
//       //                       ),
//       //                       Container(
//       //                         height: 110,
//       //                         child: Text(
//       //                           data[index]["overview"],
//       //                           style: TextStyle(color: Colors.black),
//       //                         ),
//       //                       ),
//       //                     ],
//       //                   ),
//       //                 ),
//       //               ),
//       //             ],
//       //             // children: [
//       //             //   Padding(
//       //             //       padding:  const EdgeInsets.all(8.0),
//       //             //
//       //             //   child: Image.network("https://image.tmdb.org/t/p/w500/"+data[index]["poster_path"])),
//       //             //    Text(data[index]['title']),
//       //             //   Text(data[index]["overview"]),
//       //             // ],
//       //           ),
//       //         );
//       //         // child: Image.network("https://image.tmdb.org/t/p/w500/"+data[index]["poster_path"]);
//       //       //   return ListTile(
//       //       // title: Text(data[index]['title']),
//       //       //
//       //       //   subtitle:Text(data[index]["overview"]),
//       //       //
//       //       // );
//       //  },
//       // ),
//     );
//
//   }}
