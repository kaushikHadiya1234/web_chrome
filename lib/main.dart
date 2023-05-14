import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:untitled4/Web%20view/Provider/web_provider.dart';
import 'package:untitled4/Web%20view/View/web_Screen.dart';

void main() {
  runApp(
    Sizer(
      builder: (context, orientation, deviceType) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => WebProvider(),),
        ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            routes: {
              '/':(context) => WebScreen()
            },
          ),
        ),
    ),
  );
}
