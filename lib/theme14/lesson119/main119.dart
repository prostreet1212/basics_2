
import 'package:basics_2/theme14/lesson115/pages/webview_page.dart';
import 'package:basics_2/theme14/lesson119/webview_local_page.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';
LocalhostServer localhostServer = LocalhostServer();
void main() async{
  await localhostServer.start(port: 0);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark(
          useMaterial3: false,
        ),
        home:WebViewLocalPage(),
    );
  }
}