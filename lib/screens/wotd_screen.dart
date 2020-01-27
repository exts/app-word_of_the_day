import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:word_of_the_day/components/online_checker.dart';
import 'package:word_of_the_day/domain/wotd/wotd_provider.dart';

class WotdScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Word of the Day!"),
        centerTitle: true,
        actions: <Widget>[
          _refreshButton(() => null),
        ],
      ),
      body: Consumer<WotdProvider>(
        builder: (context, model, _) {
          return FutureBuilder(
            future: model.loadWordOfTheDay(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return _showLoadingIndicator();
                default:
                  if (_showOfflineToast()) {
                    return Container();
                  }

                  if (snapshot.hasData) {}

                  return _showInvalidResultsIndicator();
              }
            },
          );
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

  bool _showOfflineToast() {
    OnlineChecker.isNotOnline().then((result) {
      if (result) {
        Fluttertoast.showToast(
          msg: "No Internet Connection",
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.red,
        );
        return true;
      }
      return false;
    });
  }
}
