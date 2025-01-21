import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class WebViewLocalPage extends StatefulWidget {
  const WebViewLocalPage({super.key});

  @override
  State<WebViewLocalPage> createState() => _WebViewLocalPageState();
}

class _WebViewLocalPageState extends State<WebViewLocalPage> {
  late WebViewController _webController;
  @override
  void initState() {
    super.initState();
    _webController=WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WebView Local'),
      ),
      body: WebViewWidget(controller: _webController),
    );
  }
}
