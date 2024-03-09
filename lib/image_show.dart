import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageShowScreen extends StatefulWidget {
  final Uint8List imageData;
  const ImageShowScreen({super.key, required this.imageData});

  @override
  State<ImageShowScreen> createState() => _ImageShowScreenState();
}

class _ImageShowScreenState extends State<ImageShowScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(

      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxHeight: size.width, maxWidth: size.width),
          child: Image.memory(widget.imageData, width: size.width, height: size.height, fit: BoxFit.cover,),

        ),
      ),
    );
  }
}
