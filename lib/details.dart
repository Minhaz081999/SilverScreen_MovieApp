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

class DetailsPage extends StatelessWidget {
  // const DetailsPage({Key? key}) : super(key: key);
 var receivedata;

 DetailsPage({
   this.receivedata
});



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
                       // IconButton(icon: Icon(Icons.bubble_chart),iconSize:100,onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => YoutubePage( youdata: receivedata["id"],)));}, ),
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
                         color : Colors.yellow,
                         child: Text("Watch Trailer",style:TextStyle(fontSize: 20,color:Colors.white)),
                         onPressed: (){
                           Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => YoutubePage( youdata: receivedata["id"].toString(),store: "")));
                         }

                     ),

                   // child: IconButton(
                   //   icon: Icon(
                   //     Icons.play_arrow,
                   //   ), iconSize:50,color: Colors.orange,
                   //   onPressed:
                   //       () {
                   //     Navigator.push(context, MaterialPageRoute(
                   //         builder: (context) => YoutubePage( youdata: receivedata["id"].toString(),)));
                   //   },
                   // )
               )),
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
                   child: Text("Overview : " + receivedata["overview"] , style: TextStyle(color: Colors.white70 ,fontStyle: FontStyle.italic,fontSize: 20),
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




