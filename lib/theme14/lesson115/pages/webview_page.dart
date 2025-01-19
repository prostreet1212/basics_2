import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

enum MenuOptions{
  clearCache,
  clearCookies,
}

class WebViewPage extends StatefulWidget {
  WebViewPage({super.key});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {

  WebViewController _webController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setNavigationDelegate(NavigationDelegate(
    ))
    ..loadRequest(Uri.parse('https://flutter.dev'));

  @override
  Widget build(BuildContext context) {
    return PopScope(
     /* onWillPop: ()async{

        if(await _webController.canGoBack()){
        _webController.goBack();
        }else{
        log('нет записи в истории');
        }
        return false;
      },*/
      child: Scaffold(
        appBar: AppBar(
          title: const Text('WebView'),
          actions: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () async {
                if(await _webController.canGoBack()){
                  _webController.goBack();
                }else{
                  log('нет записи в истории');
                }
                return;
              },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () async {
                if(await _webController.canGoForward()){
                  _webController.goForward();
                }else{
                  log('нет записи в истории');
                }
                return;
              },
            ),
            IconButton(
              icon: const Icon(Icons.replay),
              onPressed: ()async {
                await _webController.reload();
              },
            ),
            PopupMenuButton<MenuOptions>(
              onSelected: (value){
                switch(value){
                  case MenuOptions.clearCache:
                    _webController.clearCache();

                  case MenuOptions.clearCookies:
                    throw UnimplementedError();
                }
              },
                itemBuilder: (context){
                  return <PopupMenuItem<MenuOptions>>[
                     PopupMenuItem(
                      value: MenuOptions.clearCache,
                    child: Text('Удалить кеш'),
                    ),
                    PopupMenuItem(
                      value: MenuOptions.clearCookies,
                      child: Text('Удалить Cookies'),
                    ),
                  ];
                })
          ],
        ),
        body: WebViewWidget(
          controller: _webController,
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.next_plan, size: 32),
          onPressed: () async {
            _webController.loadRequest(Uri.parse('https://www.youtube.com'));
          },
        ),
      ),
    );
  }
}
