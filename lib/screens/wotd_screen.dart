import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:word_of_the_day/components/online_checker.dart';
import 'package:word_of_the_day/domain/wotd/widgets/wotd_default_view.dart';
import 'package:word_of_the_day/domain/wotd/wotd_model.dart';
import 'package:word_of_the_day/domain/wotd/wotd_provider.dart';

class WotdScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var model = Provider.of<WotdProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Word of the Day!"),
        centerTitle: true,
        actions: <Widget>[
          _refreshButton(() => model.reload()),
        ],
      ),
      body: FutureBuilder(
        future: model.loadWordOfTheDay(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return _showLoadingIndicator();
            default:
              _showOfflineToast();

              if (snapshot.hasData) {
                return _showWotdView(snapshot.data);
              }

              return _showInvalidResultsIndicator();
          }
        },
      ),
    );
  }

  Widget _refreshButton(onpressed) {
    return IconButton(
      icon: Icon(Icons.refresh),
      onPressed: onpressed,
    );
  }

  Widget _showLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _showWotdView(WotdModel model) {
    return WotdDefaultView(
        model.word, model.definition, model.pronounced, model.weblink);
  }

  Widget _showInvalidResultsIndicator() {
    return Center(
      child: Text(
        "Invalid Word of the Day",
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _showOfflineToast() {
    OnlineChecker.isNotOnline().then((result) {
      if (result) {
        Fluttertoast.showToast(
          msg: "No Internet Connection",
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.red,
        );
      }
    });
  }
}
