import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'dart:ui' as ui;
import 'filter.dart';
import 'image_show.dart';

class ImageFilter extends StatefulWidget {
  const ImageFilter({super.key});

  @override
  State<ImageFilter> createState() => _ImageFilterState();
}

class _ImageFilterState extends State<ImageFilter> {
  final GlobalKey globalKey = GlobalKey();

  final List<List<double>> filters = [SEPIUM, SEPIA, GREYSCALE, VINTAGE];

  void convertToImageSave() async {
    RenderRepaintBoundary? renderRepaintBoundary =
        globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    ui.Image boxImage = await renderRepaintBoundary!.toImage(pixelRatio: 1);
    ByteData? byteData =
        await boxImage.toByteData(format: ui.ImageByteFormat.png);
    Uint8List uint8list = byteData!.buffer.asUint8List();

    Navigator.of(globalKey.currentContext!).push(MaterialPageRoute(
        builder: (context) => ImageShowScreen(imageData: uint8list)));
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Image Filters"),
          backgroundColor: Colors.deepOrange,
          actions: [
            IconButton(
              onPressed:convertToImageSave,
              icon: Icon(Icons.check),
            )
          ],
        ),
        backgroundColor: Colors.black,
        body: Center(
          child: RepaintBoundary(
            key: globalKey,
            child: Container(
              constraints:
                  BoxConstraints(maxWidth: size.width, maxHeight: size.width),
              child: PageView.builder(
                  itemCount: filters.length,
                  itemBuilder: (context, index) {
                    return ColorFiltered(
                        colorFilter: ColorFilter.matrix(filters[index]),
                        child: Image.asset("assets/images/flower.png",
                            width: size.width, fit: BoxFit.cover));
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
