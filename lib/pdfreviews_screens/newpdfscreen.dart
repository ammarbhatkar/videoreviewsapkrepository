import 'dart:typed_data';

import 'package:flutter/material.dart';

class AddMarkerOnPdfAnn extends StatefulWidget {
  final String? currentUserEmail;
  final String? projectId;
  final Uint8List? currentPageImage;

  AddMarkerOnPdfAnn({
    Key? key,
    required this.currentUserEmail,
    required this.projectId,
    required this.currentPageImage,
  }) : super(key: key);

  @override
  _AddMarkerOnPdfAnnState createState() => _AddMarkerOnPdfAnnState();
}

class _AddMarkerOnPdfAnnState extends State<AddMarkerOnPdfAnn> {
  late double imageWidth;
  late double imageHeight;
  Offset markerPosition = Offset(0, 0);
  Offset imageOffset = Offset(0, 0);

  void handleTap(TapDownDetails details) {
    double percentageX =
        (details.localPosition.dx - imageOffset.dx) / imageWidth;
    double percentageY =
        (details.localPosition.dy - imageOffset.dy) / imageHeight;
    print(percentageX);
    print(percentageY);
    // Calculate the marker position based on percentages
    double markerX = percentageX * imageWidth;
    double markerY = percentageY * imageHeight;

    print(markerX);
    print(markerY);
    // Update marker position
    setState(() {
      markerPosition = Offset(markerX, markerY);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Marker on PDF'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Update image dimensions when constraints change
          imageWidth = constraints.maxWidth;
          imageHeight = constraints.maxHeight;
          print("the layout height is :$imageHeight");
          print("teh layour idth is :$imageWidth");

          return Center(
            child: GestureDetector(
              onTapDown: handleTap,
              child: Stack(
                children: [
                  // Display the PDF page image
                  Image.memory(
                    widget.currentPageImage!,
                    width: imageWidth,
                    height: imageHeight,
                    fit: BoxFit.contain,
                  ),
                  // Display the marker at the calculated position
                  Positioned(
                    left: markerPosition.dx - 12,
                    top: markerPosition.dy - 12,
                    child: Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
