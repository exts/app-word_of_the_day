import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'package:webview_flutter/webview_flutter.dart';

class WotdDefaultView extends StatelessWidget {
  final String word;
  final String definition;
  final String pronunciation;
  final String definitionLink;

  WotdDefaultView(
      [this.word, this.definition, this.pronunciation, this.definitionLink]);

  bool _hasPronounciation() => pronunciation?.isNotEmpty ?? false;
  bool _hasDefinitionLink() => definitionLink?.isNotEmpty ?? false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _showWord(),
                if (_hasPronounciation()) _showPronounciation(),
                _showDefinition(),
                if (_hasDefinitionLink()) _showDefinitionLinkButton(context),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _showWord() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(word,
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ))
      ],
    );
  }

  Widget _showPronounciation() {
    return Text(
      pronunciation,
      style: TextStyle(
        fontSize: 20,
        fontStyle: FontStyle.italic,
      ),
    );
  }

  Widget _showDefinition() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Text(
        definition,
        style: TextStyle(fontSize: 20),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _showDefinitionLinkButton(BuildContext context) {
    return RaisedButton(
      child: Text("Read More"),
      onPressed: () => _openWebview(context),
    );
  }

  Future<void> _openWebview(BuildContext context) async {
    if (await url_launcher.canLaunch(definitionLink)) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) {
            return Scaffold(
              appBar: AppBar(
                title: Text(word),
              ),
              body: WebView(
                initialUrl: definitionLink,
              ),
            );
          },
        ),
      );
    }
  }
}
