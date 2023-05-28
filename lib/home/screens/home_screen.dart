//Inbuilt import
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';
//local import
import 'widgets/appbar_menu.dart';
import '../../providers/user_provider.dart';
import '../../auth/widgets/loader.dart';
//global package import
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true;
  late WebViewController _webViewController;

  // @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            if (progress == 100) {
              print('_isLoading is false');
              setState(() {
                _isLoading = false;
              });
            }
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://flutter.dev'));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text("Welcome ${user.email}"),
          ),
          actions: const [
            AppBarMenu(),
          ],
        ),
        body: Stack(
          children: [
            WebViewWidget(controller: _webViewController),
            _isLoading
                ? Positioned.fill(
                    child: SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: BackdropFilter(
                        filter: ui.ImageFilter.blur(
                          sigmaX: 3.0,
                          sigmaY: 3.0,
                        ),
                        child: const Loader(),
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
