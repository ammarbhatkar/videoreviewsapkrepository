// Container(
//                 height: containerHeight,
//                 width: containerWidth,
//                 decoration: BoxDecoration(
//                   color: Color.fromRGBO(50, 229, 14, 1),
//                 ),
//                 child: Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     GestureDetector(
//                       onTapDown: (TapDownDetails details) async {
//                         Offset localPosition = details.localPosition;
//                         double dx =
//                             (localPosition.dx - imagePositiondx!) / imageWidth;
//                         double dy =
//                             (localPosition.dy - imagePositiondy!) / imageHeight;
//                         double dxPixel = localPosition.dx;
//                         double dyPixel = localPosition.dy;

//                         // print("dy is :$dy");
//                         // print("the divided oi s:$dx");
//                         print("the offsetx is :${localPosition.dx}");
//                         print("the offsety is :${localPosition.dy}");

//                         showDialog(
//                           context: context,
//                           builder: (BuildContext context) {
//                             _textController.clear();
//                             return AlertDialog(
//                               title: Text(
//                                 "Review",
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                               ),
//                               content: TextField(
//                                 maxLines: null,
//                                 minLines: null,
//                                 autofocus: true,
//                                 controller: _textController,
//                                 decoration: InputDecoration(
//                                   border: OutlineInputBorder(),
//                                 ),
//                               ),
//                               actions: [
//                                 TextButton(
//                                   onPressed: () async {
//                                     Navigator.of(context).pop();
//                                   },
//                                   child: Text(
//                                     'Cancel',
//                                     style: TextStyle(
//                                       color: const Color.fromARGB(
//                                           255, 166, 162, 162),
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.w400,
//                                     ),
//                                   ),
//                                 ),
//                                 Container(
//                                   height:
//                                       MediaQuery.of(context).size.height / 22,
//                                   decoration: BoxDecoration(
//                                     color: Colors.purple,
//                                     borderRadius: BorderRadius.circular(100),
//                                   ),
//                                   child: TextButton(
//                                     onPressed: () async {
//                                       Navigator.of(context).pop();
//                                       String currentReview =
//                                           _textController.text;
//                                       ReviewModel model = ReviewModel(
//                                         position: details.globalPosition,
//                                         review: currentReview,
//                                         order: reviewList.length + 1,
//                                       );
//                                       setState(() {
//                                         reviewList.add(model);
//                                         _addMarker(dxPixel, dyPixel);
//                                         Marker lastMarker = markers.last;
//                                         lastMarker.isVisible = true;
//                                       });
//                                       _addMarkersToFirestore(
//                                           dx, dy, dxPixel, dyPixel);
//                                     },
//                                     child: Text(
//                                       'Done',
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w400,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             );
//                           },
//                         );
//                       },
//                       child: Image.memory(
//                         widget.currentPageImage,
//                         key: imageKey,
//                         // height: imageHeight,
//                         // width: imageWidth,
//                       ),
//                     ),
//                     for (var marker in markers)
//                       if (marker.isVisible)
//                         Positioned(
//                           left: marker.dx,
//                           top: marker.dy,
//                           // child: Transform.translate(
//                           //   offset: Offset(-0.5 * 20, -0.5 * 20),
//                           child: Container(
//                             height: 20,
//                             width: 20,
//                             // height: currentDeviceWidth * 0.05,
//                             // width: containerWidth * 0.05,
//                             decoration: BoxDecoration(
//                               color: Color.fromRGBO(208, 98, 98, 1),
//                               shape: BoxShape.circle,
//                             ),
//                             child: Center(
//                               child: Text(
//                                 '${marker.index}',
//                                 style: GoogleFonts.openSans(
//                                   fontSize: 10,
//                                   fontWeight: FontWeight.w700,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                     //   ),
//                   ],
//                 ),
//               ),