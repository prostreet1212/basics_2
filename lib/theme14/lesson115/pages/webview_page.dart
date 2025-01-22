import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

enum MenuOptions {
  clearCache,
  clearCookies,
}

class WebViewPage extends StatefulWidget {
  WebViewPage({super.key});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

double progress1 = 0;

class _WebViewPageState extends State<WebViewPage> {
  late WebViewController _webController;

  @override
  void initState() {
    super.initState();
    _webController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(onNavigationRequest: (request) {
          if (request.url.startsWith('https://m.youtube.com')) {
            log('Навигация заблокирована к $request');
            return NavigationDecision.prevent;
          }
          log('Навигация разрешена к $request');
          return NavigationDecision.navigate;
        }, onProgress: (progress) {
          progress1 = progress / 100;
          setState(() {});
        }, onPageStarted: (url) async{
          log('Новый сайт $url');
          if(url.contains('https://flutter.dev')){
           /*a Future.delayed(Duration(microseconds: 300),(){
              _webController.runJavaScript("document.getElementsByTagName('footer')[0].style.display='none'");
            });*/
            await _webController.runJavaScript("document.getElementsByTagName('footer')[0].style.display='none'");

          }


        }, onPageFinished: (url) {
          log('Страница полностью загружена $url');
        }),
      )
      //..loadRequest(Uri.parse('https://flutter.dev'));
      ..loadRequest(Uri.parse('https://kdrc.ru/wp-admin'))
    ;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        if (await _webController.canGoBack()) {
          _webController.goBack();
        } else {
          log('нет записи в истории');

          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('WebView'),
          actions: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () async {
                if (await _webController.canGoBack()) {
                  _webController.goBack();
                } else {
                  log('нет записи в истории');
                }
                return;
              },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () async {
                if (await _webController.canGoForward()) {
                  _webController.goForward();
                } else {
                  log('нет записи в истории');
                }
                return;
              },
            ),
            IconButton(
              icon: const Icon(Icons.replay),
              onPressed: () async {
                await _webController.reload();
              },
            ),
            PopupMenuButton<MenuOptions>(onSelected: (value) {
              switch (value) {
                case MenuOptions.clearCache:
                  _onClearCache(_webController, context);
                  break;
                case MenuOptions.clearCookies:
                  _onClearCookies(context);
                  break;
              }
            }, itemBuilder: (context) {
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
        body: Column(
          children: [
            LinearProgressIndicator(
              value: progress1,
              color: Colors.red,
              backgroundColor: Colors.green,
            ),
            Expanded(
              child: WebViewWidget(
                controller: _webController,
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.next_plan, size: 32),
          onPressed: () async {
            /* final currentUrl = await _webController.currentUrl();
            log('Предыдущий сайт: $currentUrl');
            await _webController
                .loadRequest(Uri.parse('https://www.youtube.com'));*/
            //_webController.runJavaScript("document.getElementsByTagName('footer')[0].style.display='none'");
            const email = 'admin';
            const pass = 'wJAzsURT1&YFypaaqpCuSi2U';


            _webController.runJavaScriptReturningResult(
              "document.getElementById('user_login').value='$email'",
            );
            _webController.runJavaScriptReturningResult(
              "document.getElementById('user_pass').value='$pass'",
            );

            await Future.delayed(Duration(seconds: 1));
            Object a=await _webController.runJavaScriptReturningResult("document.forms[0].submit()");
            print(a);


          },
        ),
      ),
    );
  }

  void _onClearCookies(BuildContext context) async {
    final bool hadCookies = await WebViewCookieManager().clearCookies();
    String message = 'Cookies удалены';
    if (!hadCookies) {
      message = 'Cookies все были очищены';
    }
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _onClearCache(WebViewController controller, BuildContext context) async {
    await controller.clearCache();
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Кеш очищен')));
  }
}
