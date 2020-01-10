import 'package:flutter/material.dart';
import 'package:word_of_the_day/model/wotd_model.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'package:webview_flutter/webview_flutter.dart';
import 'package:fluttery_audio/fluttery_audio.dart';

class WotdView extends StatelessWidget {
  final WotdModel model;

  WotdView(this.model);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  model.word,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
//                if (model.audiofile != null && model.audiofile.isNotEmpty)
//                  _playPronounciation(),
              ],
            ),
            if (model.pronounced != null && model.pronounced.isNotEmpty)
              Text(
                model.pronounced,
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
              ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                model.definition,
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            if (model.weblink != null && model.weblink.isNotEmpty)
              RaisedButton(
                child: Text("Read More"),
                onPressed: () => _openWebview(context),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _openWebview(BuildContext ctx) async {
    if (await url_launcher.canLaunch(model.weblink)) {
      Navigator.of(ctx).push(
        MaterialPageRoute(
          builder: (_) {
            return Scaffold(
              appBar: AppBar(
                title: Text(model.word),
              ),
              body: WebView(
                initialUrl: model.weblink,
              ),
            );
          },
        ),
      );
    }
  }

  Widget _playPronounciation() {
    return new Audio(
      audioUrl: model.audiofile,
//      playbackState: PlaybackState.paused,
      buildMe: [WatchableAudioProperties.audioPlayerState],
      playerBuilder: (BuildContext context, AudioPlayer player, Widget child) {
        // prevent player to auto play after reloading state
        if (player.state == AudioPlayerState.loading) {
          player.pause();
        }

        // default icon status
        var icon = Icons.play_arrow;
        if (player.state == AudioPlayerState.playing) {
          icon = Icons.stop;
        } else if (player.state == AudioPlayerState.stopped) {
          icon = Icons.play_arrow;
        }

        return IconButton(
          icon: Icon(icon),
          onPressed: () {
            if (player.state == AudioPlayerState.playing) {
              player.stop();
            } else {
              player.play();
            }
          },
        );
      },
    );
  }
}
