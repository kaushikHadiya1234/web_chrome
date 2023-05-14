import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import 'package:untitled4/Web%20view/Provider/web_provider.dart';

class WebScreen extends StatefulWidget {
  const WebScreen({Key? key}) : super(key: key);

  @override
  State<WebScreen> createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {

  WebProvider? pf;
  WebProvider? pt;
  PullToRefreshController? pullToRefreshController;
  @override
  void initState() {
    super.initState();
    pullToRefreshController = PullToRefreshController(
      onRefresh: () {
        Provider.of(context,listen: false)!.webViewController!.reload();
      },);
  }

  @override
  Widget build(BuildContext context) {
    pf = Provider.of<WebProvider>(context,listen: false);
    pt = Provider.of<WebProvider>(context,listen: true);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff202124),
        body: Column(
          children: [
            Row(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(onPressed: () {
                      pt!.webViewController!.goBack();
                    }, icon: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.white,size: 20,)),
                    IconButton(onPressed: () {
                      pt!.webViewController!.reload();
                    }, icon: Icon(Icons.refresh,color: Colors.white,size: 20,)),
                    IconButton(onPressed: () {
                      pt!.webViewController!.goForward();
                    }, icon: Icon(Icons.arrow_forward_ios,color: Colors.white,size: 20,)),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      height: 40,
                      width: 225,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white70
                      ),
                      child: TextField(
                        controller: pt!.txtsearch,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          suffixIcon: IconButton(onPressed: () {
                            var search = pt!.txtsearch.text;
                            pt!.webViewController!.loadUrl(
                              urlRequest: URLRequest(
                                url: Uri.parse(
                                    "https://www.google.com/search?q=${pt!.txtsearch.text}"),
                              ),
                            );
                          },icon: Icon(Icons.search)),
                          // hintText: "Search"
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            LinearProgressIndicator(
              value: pt!.p1,
              color: Color(0xff202124),
            ),
            Expanded(
              child: InAppWebView(
                initialUrlRequest: URLRequest(url: Uri.parse("https://www.google.com/")),

                onLoadStart: (controller, url) {
                  pt!.webViewController=controller;
                  pullToRefreshController!.endRefreshing();
                },
                onLoadStop: (controller, url) {
                  pt!.webViewController=controller;
                  pullToRefreshController!.endRefreshing();
                },
                onLoadError: (controller, url, code, message) {
                  pt!.webViewController=controller;
                  pullToRefreshController!.endRefreshing();
                },
                onProgressChanged: (controller, progress) {
                  pt!.webViewController=controller;
                  pullToRefreshController!.endRefreshing();
                   pt!.changeprogress((progress/100).toDouble());
                },
                pullToRefreshController: pullToRefreshController,
              ),
            )
          ],
        ),
      ),
    );
  }
}
