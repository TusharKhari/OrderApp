 import 'dart:html';

import 'package:flutter/material.dart';
  import "dart:ui_web" as webui;

class MyImage extends StatelessWidget {
 final String url;
  const MyImage({super.key, required this.url});


  @override
  Widget build(BuildContext context) {
    String imageUrl = url;
    webui.platformViewRegistry.registerViewFactory(
      imageUrl,
      (int _) => ImageElement()..src = imageUrl,
    );
    return HtmlElementView(
      viewType: imageUrl,
      
    );
  }
}