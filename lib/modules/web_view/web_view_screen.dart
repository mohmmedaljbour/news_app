 import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {

 final String url ;
 WebViewScreen (this.url);
// ignore: use_key_in_widget_constructors

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:WebView(
        initialUrl: url,
      ),
    );
  }
}
