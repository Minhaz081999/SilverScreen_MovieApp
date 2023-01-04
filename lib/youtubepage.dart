import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'dart:async';
import 'dart:convert';
import 'package:silverscreen3/details.dart';
//import 'video_list.dart';


class YoutubePage extends StatefulWidget {

  YoutubePage({required this.youdata, required this.store});

  String youdata;
  String store;

  @override
  _YoutubePageState createState() => _YoutubePageState(youdata,store);

}

class _YoutubePageState extends State<YoutubePage> {

  _YoutubePageState(this.youdata,this.store);
  var youdata;
  var store;
  static String str2 = "";
  TextEditingController tec = TextEditingController();
   var posts;
  var data ;
  var unfilterData;




  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;

  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;
  bool showLiveFullscreenButton = true;
  bool hideThumbnail = true;

  VideoList(){}

  // final List<String> _ids = [
  //   // 'nPt8bK2gbaU',
  //   // 'gQDByCdjUXw',
  //   // 'iLnmTe5Q2Qw',
  //   // '_WoCV4c6XOE',
  //   // 'KmzdUe0RSJo',
  //   // '6jZDSSZZxjQ',
  //   // 'p2lYr3vM_1w',
  //   // '7QUtEmBT_-w',
  //   // '34_PXCzGw1M',
  // ];
  String movie_id = "U3lFtv2SIl0";

  @override
  void initState() {

    // this.videoJsonData(youdata);
    super.initState();
    //this.videoJsonData(youdata);
    _controller = YoutubePlayerController(
      initialVideoId: store ,//_YoutubePageState.str2 ,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: true,
        enableCaption: true,

      //showLiveFullscreenButton : true,
        controlsVisibleAtStart: false,
        hideThumbnail : false,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;

  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return YoutubePlayerBuilder(
      // onExitFullScreen: () {
      //   // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
      //   SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      // },
      player: YoutubePlayer(
        aspectRatio: 16/9,
        controller: _controller,
        showVideoProgressIndicator: false,
        progressIndicatorColor: Colors.blueAccent,
        topActions: <Widget>[
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              _controller.metadata.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          // IconButton(
          //   icon: const Icon(
          //     Icons.settings,
          //     color: Colors.white,
          //     size: 25.0,
          //   ),
          //   onPressed: () {
          //     log('Settings Tapped!');
          //   },
          // ),
        ],
        onReady: () {
          _isPlayerReady = true;
        },
        onEnded: (data) {
          _controller
              .load(_YoutubePageState.str2[(_YoutubePageState.str2.indexOf(data.videoId) + 1) % _YoutubePageState.str2.length]);
          _showSnackBar('Next Video Started!');
        },
      ),
      builder: (context, player) => Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          flexibleSpace: Image.network("https://dcassetcdn.com/profile_pics/797680/0afaca4e-6990-4224-b674-d64c23045351.png",fit: BoxFit.cover,),
          toolbarHeight: 110,
          // leading: Padding(
          //   padding: const EdgeInsets.only(left: 12.0),
          //   child: Image.asset(
          //     'assets/ypf.png',
          //     fit: BoxFit.fitWidth,
          //   ),
          // ),
          // title: const Text(
          //   'Youtube Player Flutter',
          //   style: TextStyle(color: Colors.white),
          // ),
          // actions: [
          //   IconButton(
          //     icon: const Icon(Icons.video_library),
          //     onPressed: () => Navigator.push(
          //       context,
          //       CupertinoPageRoute(
          //         builder: (context) => VideoList(),
          //       ),
          //     ),
          //   ),
          // ],
        ),
        body: ListView(

          children: [
            player,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _space,
                  _text('Title', _videoMetaData.title),
                  _space,
                  _text('Channel', _videoMetaData.author),
                  //_space,
                  //_text('Video Id', _videoMetaData.videoId),

                  //_space,
                  // Row(
                  //   children: [
                  //     _text(
                  //       'Playback Quality',
                  //       _controller.value.playbackQuality ?? '',
                  //     ),
                  //     const Spacer(),
                  //     _text(
                  //       'Playback Rate',
                  //       '${_controller.value.playbackRate}x  ',
                  //     ),
                  //   ],
                  // ),
                  //_space,
                  // TextField(
                  //   enabled: _isPlayerReady,
                  //   controller: _idController,
                  //   decoration: InputDecoration(
                  //     border: InputBorder.none,
                  //
                  //     hintText: "",
                  //
                  //     fillColor: Colors.blueAccent.withAlpha(20),
                  //     filled: true,
                  //     hintStyle: const TextStyle(
                  //       fontWeight: FontWeight.w300,
                  //       color: Colors.blueAccent,
                  //     ),
                  //     suffixIcon: IconButton(
                  //       icon: const Icon(Icons.clear),
                  //       onPressed: () => _idController.clear(),
                  //     ),
                  //   ),
                  //
                  // ),
                 // _space,

                  // Row(
                  //   children: [
                  //     loadCueButton('Play'),
                  //     const SizedBox(width: 10.0),
                  //     //_loadCueButton('CUE'),
                  //   ],
                  // ),
                  _space,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // IconButton(
                      //   icon: const Icon(Icons.skip_previous),
                      //   onPressed: _isPlayerReady
                      //       ? () => _controller.load(_ids[
                      //   (_ids.indexOf(_controller.metadata.videoId) -
                      //       1) %
                      //       _ids.length])
                      //       : null,
                      // ),
                      // IconButton(
                      //   icon: Icon(
                      //     _controller.value.isPlaying
                      //         ? Icons.pause
                      //         : Icons.play_arrow,
                      //   ),color: Colors.tealAccent,
                      //   onPressed: _isPlayerReady
                      //       ? () {
                      //     _controller.value.isPlaying
                      //         ? _controller.pause()
                      //         : _controller.play();
                      //     setState(() {});
                      //   }
                      //       : null,
                      // ),
                      // IconButton(
                      //   icon: Icon(_muted ? Icons.volume_off : Icons.volume_up),
                      //     color: Colors.redAccent,
                      //   onPressed: _isPlayerReady
                      //       ? () {
                      //     _muted
                      //         ? _controller.unMute()
                      //         : _controller.mute();
                      //     setState(() {
                      //       _muted = !_muted;
                      //     });
                      //   }
                      //       : null,
                      // ),
                      // FullScreenButton(
                      //   controller: _controller,
                      //   color: Colors.yellow,
                      //
                      // ),
                      // IconButton(
                      //   icon: const Icon(Icons.skip_next),
                      //   onPressed: _isPlayerReady
                      //       ? () => _controller.load(_ids[
                      //   (_ids.indexOf(_controller.metadata.videoId) +
                      //       1) %
                      //       _ids.length])
                      //       : null,
                      // ),
                    ],
                  ),
                  _space,
                  // Row(
                  //   children: <Widget>[
                  //     const Text(
                  //       "Volume",
                  //       style: TextStyle(color:Colors.green,fontWeight: FontWeight.bold,fontSize: 15),
                  //
                  //     ),
                  //     Expanded(
                  //       child: Slider(
                  //        // inactiveColor: Colors.transparent,
                  //         value: _volume,
                  //         min: 0.0,
                  //         max: 100.0,
                  //         divisions: 10,
                  //         label: '${(_volume).round()}',
                  //         onChanged: _isPlayerReady
                  //             ? (value) {
                  //           setState(() {
                  //             _volume = value;
                  //           });
                  //           _controller.setVolume(_volume.round());
                  //         }
                  //             : null,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  _space,
                  // AnimatedContainer(
                  //   duration: const Duration(milliseconds: 800),
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(20.0),
                  //     color: _getStateColor(_playerState),
                  //   ),
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Text(
                  //     _playerState.toString(),
                  //     style: const TextStyle(fontSize: 20,
                  //       fontWeight: FontWeight.bold,
                  //       color: Colors.white,
                  //     ),
                  //     textAlign: TextAlign.center,
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _text(String title, String value) {
    return RichText(
      text: TextSpan(
        text: '$title : ',
        style: const TextStyle(
          color: Colors.blueGrey,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(
            text: value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStateColor(PlayerState state) {
    switch (state) {
      case PlayerState.unknown:
        return Colors.grey[700]!;
      case PlayerState.unStarted:
        return Colors.pink;
      case PlayerState.ended:
        return Colors.red;
      case PlayerState.playing:
        return Colors.blueAccent;
      case PlayerState.paused:
        return Colors.orange;
      case PlayerState.buffering:
        return Colors.yellow;
      case PlayerState.cued:
        return Colors.blue[900]!;
      default:
        return Colors.blue;
    }
  }

  Widget get _space => const SizedBox(height: 10);

  Widget loadCueButton(String action) {
    return Expanded(
      child: MaterialButton(
        color: Colors.green,
        onPressed: _isPlayerReady
            ? () {
          if (_YoutubePageState.str2.isNotEmpty) {
            var id = YoutubePlayer.convertUrlToId(
              _YoutubePageState.str2,) ?? '';
            if (action == 'Play') _controller.load(id);
            //if (action == 'CUE') _controller.cue(id);
            FocusScope.of(context).requestFocus(FocusNode());
          } else {
            _showSnackBar('Source can\'t be empty!');
          }
        }
            : null,
        disabledColor: Colors.blue,
        disabledTextColor: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 1),
          child: Text(
            action,
            style: const TextStyle(
              fontSize: 30.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 200.0,
          ),
        ),
        backgroundColor: Colors.black,
        behavior: SnackBarBehavior.floating,
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    );
  }
}