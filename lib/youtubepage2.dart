import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class YoutubePage2 extends StatefulWidget {
  // const YoutPlayer({Key? key, required String url}) : super(key: key);
  YoutubePage2({required this.store});

  var  store;


  @override
  State<YoutubePage2> createState() => _YoutubePage2State(store);
}

class _YoutubePage2State extends State<YoutubePage2> {
  //YoutubePlayerController? _controller;
  _YoutubePage2State(this.store);
  var store;

  YoutubePlayerController? _controller;
  var posts;
  var data;
  var src = "";
  var testVideo ;
  var baseURL = "https://www.youtube.com/watch?v=";
  Future <bool>loadJsonData() async{

    String serviceUrl2 = "https://api.themoviedb.org/3/movie/436270/videos?api_key=38e61227f85671163c275f9bd95a8803&language=en-US";
    var response = await http.get(Uri.parse(serviceUrl2));

    print(response.body);
    posts = json.decode(response.body);
    data = posts["results"];
    print("-------x------");
    //   print(posts);
    // setState(() {
    //   posts = json.decode(response.body.toString());
    //   data = posts["results"];
    //   print(posts);
    //   print("-------x------");
    //   print(data[0]["title"]);
    //   str2 = data[0]["id"].toString();
    //   print(str2);
    //
    //
    // });
    src= data[0]["key"];
    print( src );
    testVideo = src;
    print(testVideo);
    print(baseURL+testVideo);
    return true;

  }

  //"U3lFtv2SIl0"; Kung FU Panda
  void runYoutubePlayer(){
    _controller = YoutubePlayerController(
        initialVideoId: store,
        flags : YoutubePlayerFlags(
          enableCaption: false,
          autoPlay: true,
          isLive: true,


        ));
  }
  @override
  void initState(){
    loadJsonData();
    runYoutubePlayer();
    super.initState();
    if (this.src.isNotEmpty)
    {
      var id = YoutubePlayer.convertUrlToId(
        this.src,) ?? '';
      if (this.src == this.src) _controller?.load(id);
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }
  @override
  void dispose(){
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller!,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.amber,
        progressColors: ProgressBarColors(
          playedColor: Colors.amber,
          handleColor: Colors.amberAccent,
        ),
      ),
      builder: (context, player) {
        return Scaffold(
          backgroundColor: Colors.black12,
          appBar: AppBar (
            flexibleSpace: Image.network("https://dcassetcdn.com/profile_pics/797680/0afaca4e-6990-4224-b674-d64c23045351.png",fit: BoxFit.cover,),
            toolbarHeight: 110,
            // backgroundColor: Colors.black,
            // title:  Text ("Sliver Screen 🎬",style : TextStyle(fontStyle: FontStyle.italic)),
          ),
          body: player,

        );
      },

    );

    //   _controller = YoutubePlayerController(
    //   initialVideoId:str,                                        // https://www.youtube.com/watch?v=Tb9k9_Bo-G4
    //   flags: YoutubePlayerFlags(
    //     autoPlay: true,
    //     mute: false,
    //     isLive: true,
    //   ),
    // );

  }



}
