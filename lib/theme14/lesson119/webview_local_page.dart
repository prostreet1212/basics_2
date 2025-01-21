import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

import 'main119.dart';

class WebViewLocalPage extends StatefulWidget {
  const WebViewLocalPage({super.key});

  @override
  State<WebViewLocalPage> createState() => _WebViewLocalPageState();
}

class _WebViewLocalPageState extends State<WebViewLocalPage> {
  late WebViewControllerPlus _webController;

  @override
  void initState() {
    super.initState();
    _webController = WebViewControllerPlus(

    )
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      //..loadRequest(Uri.parse('lib/theme14/lesson119/assets/index.html'))
      //..loadFlutterAssetWithServer('lib/theme14/lesson119/assets/index.html', localhostServer.port!)
    //..loadFile('lib/theme14/lesson119/assets/index.html')
    //..loadFlutterAsset('lib/theme14/lesson119/assets/index.html')
    ;
    //loadLocalHTML();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WebView Local'),
      ),
      body: WebViewWidget(
        controller: _webController,
      ),
    );
  }

//   final html = '''<!DOCTYPE html>
// <html>
// <body>
//
// <h1>This is heading 1</h1>
// <h2>This is heading 2</h2>
// <h3>This is heading 3</h3>
// <h4>This is heading 4</h4>
// <h5>This is heading 5</h5>
// <h6>This is heading 6</h6>
//
// </body>
// </html>''';

  Future<void> loadLocalHTML() async {
    final html=await rootBundle.loadString('lib/theme14/lesson119/assets/index.html');
    final url = Uri.dataFromString(
      html,
      mimeType: 'text/html',
      encoding: Encoding.getByName('utf-8'),
    ).toString();
    _webController.loadRequest(Uri.parse(url));

  }
}
