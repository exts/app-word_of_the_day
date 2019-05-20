import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_of_the_day/model/wotd_model.dart';
import 'package:word_of_the_day/services/wotd_data.dart';
import 'package:word_of_the_day/view/wotd_view.dart';
import 'package:word_of_the_day/view/unknown_view.dart';
import 'package:word_of_the_day/view/loader_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:word_of_the_day/services/online_checker.dart';

class WotdPresenter extends StatefulWidget {
  @override
  _WotdPresenterState createState() => _WotdPresenterState();
}

class _WotdPresenterState extends State<WotdPresenter> {
  final wotdUrl = "https://www.dictionary.com/e/word-of-the-day";

  WotdData data;

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<WotdModel>(context);
    data = WotdData(websiteUrl: wotdUrl);

    return Scaffold(
      appBar: AppBar(
        title: Text("Word of the Day!"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => model.reload(),
          )
        ],
      ),
      body: FutureBuilder(
        future: this.data.loadWordOfTheDay(),
        builder: (BuildContext ctx, AsyncSnapshot snap) {
          switch (snap.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return LoaderView();
            default:

              // do something if there's no internet connection
              OnlineChecker.isNotOnline().then((result) {
                if (result) {
                  Fluttertoast.showToast(
                    msg: "Internet Connection Lost",
                    gravity: ToastGravity.BOTTOM,
                    textColor: Colors.white,
                    toastLength: Toast.LENGTH_LONG,
                    backgroundColor: Colors.red,
                  );
                }
              });

              if (snap.hasData) {
                model.updateFrom(snap.data);
              } else {
                return UnknownView();
              }
              return WotdView(model);
          }
        },
      ),
    );
  }
}
