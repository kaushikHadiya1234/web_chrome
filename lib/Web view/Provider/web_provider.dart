
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebProvider extends ChangeNotifier
{
  TextEditingController txtsearch = TextEditingController();
  InAppWebViewController? webViewController;


  double p1 = 0;


  void changeprogress(double updated)
  {
    p1 = updated;
    notifyListeners();
  }


}