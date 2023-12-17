// // ignore_for_file: use_build_context_synchronously, prefer_const_constructors

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:video_player/video_player.dart';
// import 'package:videodemo/views/bottom_sheet_widget.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class VideoView extends StatefulWidget {
//   final XFile? videoPath;
//   VideoView({Key? key, this.videoPath}) : super(key: key);

//   @override
//   State<VideoView> createState() => _VideoViewState();
// }

// class _VideoViewState extends State<VideoView> {
//   late final VideoPlayerController _controller;
//   late Future<void> initializeVideoPlayer;
//   late final TextEditingController _textController;
//   List<Marker> markers = [];
//   late List<ReviewModel> reviewList = [];
//   bool isVideoPlaying = false;
//   int duration = 0;
//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.file(File(widget.videoPath!.path));

//     initializeVideoPlayer = _controller.initialize();
//     _textController = TextEditingController();
//     _controller.addListener(() {
//       Duration currentTime = _controller.value.position;

//       setState(() {
//         duration = currentTime.inMilliseconds;
//       });
//       print("current Time  is this where it will display: $currentTime");
//       for (var marker in markers) {
//         var diff =
//             (marker.position.inMilliseconds - currentTime.inMilliseconds).abs();
//         if (diff < 100) {
//           marker.isVisible = true;
//         } else {
//           marker.isVisible = false;
//         }
//         // }
//         // if (_controller.value.isPlaying) {
//         //   Duration currentTime = _controller.value.position;
//         //   setState(() {
//         //     duration = currentTime.inMilliseconds;
//         //   });
//         //   print("current Time  is this where it will display: $currentTime");
//         //   for (var marker in markers) {
//         //     var diff =
//         //         (marker.position.inMilliseconds - currentTime.inMilliseconds)
//         //             .abs();
//         //     if (diff < 100) {
//         //       marker.isVisible = true;
//         //     } else {
//         //       marker.isVisible = false;
//         //     }
//         //   }
//         setState(() {});
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     _textController.dispose();
//     super.dispose();
//   }

//   void _addMarker(Duration positionInSeconds, Offset positionOffset) {
//     setState(() {
//       markers.add(Marker(
//         index: markers.length + 1,
//         position: positionInSeconds,
//         positionOffset: positionOffset,
//         isVisible: false,
//       ));
//       print("tiem when marker is added : $positionInSeconds");
//       print("Position Offset: $positionOffset");
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromRGBO(33, 37, 50, 1),
//       resizeToAvoidBottomInset: false,
//       body: Column(
//         children: [
//           SafeArea(
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Color.fromARGB(255, 255, 255, 251),
//               ),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(top: 18, left: 18, bottom: 19),
//                     child: GestureDetector(
//                       onTap: () {
//                         // Handle the arrow back functionality here
//                       },
//                       child: Icon(
//                         Icons.arrow_back,
//                         size: 20,
//                         color: Color.fromRGBO(0, 0, 0, 0.6),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: Center(
//                       child: Padding(
//                         padding: const EdgeInsets.only(top: 17, bottom: 18),
//                         child: Text(
//                           "Add Feedback ",
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.black,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 20), // Adjust the width to your requirement
//                 ],
//               ),
//             ),
//           ),
//           SizedBox(height: 40),
//           Container(
//             child: Stack(
//               children: [
//                 GestureDetector(
//                   onTapDown: (TapDownDetails details) async {
//                     if (_controller.value.isPlaying) {
//                       await _controller.pause();

//                       Duration currentPosition = _controller.value.position;
//                       print("this is Current Time :$currentPosition");
//                       int seconds = currentPosition.inSeconds;
//                       print("this are the seconds yo tapped : $seconds");
//                       _addMarker(currentPosition, details.globalPosition);
//                       print(
//                           'Details global posiiton :${details.globalPosition}');

//                       showDialog(
//                           context: context,
//                           builder: (BuildContext context) {
//                             return AlertDialog(
//                                 title: Text(
//                                   "Review",
//                                   style: TextStyle(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.w700,
//                                   ),
//                                 ),
//                                 content: TextField(
//                                   controller: _textController,
//                                   decoration: InputDecoration(
//                                       border: OutlineInputBorder()),
//                                 ),
//                                 actions: [
//                                   TextButton(
//                                     onPressed: () async {
//                                       Navigator.of(context).pop();

//                                       await _controller.play();
//                                     },
//                                     child: Text(
//                                       'Cancel',
//                                       style: TextStyle(
//                                           color: const Color.fromARGB(
//                                               255, 166, 162, 162),
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.w400),
//                                     ),
//                                   ),
//                                   Container(
//                                     height:
//                                         MediaQuery.of(context).size.height / 22,
//                                     decoration: BoxDecoration(
//                                       color: Colors.purple,
//                                       borderRadius: BorderRadius.circular(100),
//                                     ),
//                                     child: TextButton(
//                                       onPressed: () async {
//                                         Navigator.of(context).pop();
//                                         String currentReview =
//                                             _textController.text;
//                                         ReviewModel model = ReviewModel(
//                                           position: details.globalPosition,
//                                           time: currentPosition,
//                                           review: currentReview,
//                                           order: reviewList.length + 1,
//                                         );
//                                         setState(() {
//                                           reviewList.add(model);
//                                         });
//                                         await _controller.play();
//                                       },
//                                       child: Text(
//                                         'Done',
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 14,
//                                           fontWeight: FontWeight.w400,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ]);
//                           });
//                     }
//                   },
//                   child: Container(
//                     height: 375,
//                     decoration:
//                         BoxDecoration(color: Color.fromRGBO(15, 18, 27, 1)),
//                     child: FutureBuilder(
//                       future: initializeVideoPlayer,
//                       builder: (context, snapshot) {
//                         if (snapshot.connectionState == ConnectionState.done) {
//                           return AspectRatio(
//                             aspectRatio: 2 / 4,
//                             child: VideoPlayer(_controller),
//                           );
//                         } else {
//                           return Center(child: CircularProgressIndicator());
//                         }
//                       },
//                     ),
//                   ),
//                 ),
//                 for (var marker in markers)
//                   if (marker.isVisible)
//                     Positioned(
//                       left: marker.positionOffset.dx,
//                       top: marker.positionOffset.dy,
//                       child: Container(
//                         width: 40,
//                         height: 40,
//                         decoration: BoxDecoration(
//                           color: Color.fromRGBO(208, 98, 98, 1),
//                           //  border: Border.all(width: 2, color: Colors.white),
//                           shape: BoxShape.circle,
//                         ),
//                         child: Center(
//                           child: Text(
//                             '${marker.index}',
//                             style: GoogleFonts.openSans(
//                               fontSize: 24,
//                               fontWeight: FontWeight.w700,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//               ],
//             ),
//           ),
//           Flexible(
//             child: Padding(
//               padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Color.fromRGBO(15, 18, 27, 1),
//                   border: Border.all(width: 1),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.only(top: 26, bottom: 26),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       GestureDetector(
//                         onTap: () async {
//                           final result = await showModalBottomSheet(
//                             //     isScrollControlled: true,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(20),
//                                 topRight: Radius.circular(20),
//                               ),
//                             ),
//                             context: context,
//                             builder: (context) {
//                               return Container(
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(20),
//                                     topRight: Radius.circular(20),
//                                   ),
//                                 ),
//                                 child: BottomSheetWidget(
//                                   reviewLists: reviewList,
//                                   controller: _controller,
//                                 ),
//                               );
//                             },
//                           );
//                         },
//                         child: SvgPicture.asset('assets/icon/chat.svg'),
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             if (isVideoPlaying) {
//                               _controller.pause();
//                             } else {
//                               _controller.play();
//                             }
//                             isVideoPlaying = !isVideoPlaying;
//                           });
//                         },
//                         child: SvgPicture.asset(
//                           isVideoPlaying
//                               ? 'assets/icon/motion_photos_paused.svg'
//                               : 'assets/icon/sound_sampler.svg',
//                         ),
//                       ),
//                       SvgPicture.asset('assets/icon/stop_circle.svg'),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class Marker {
//   final int index;
//   final Duration position;
//   final Offset positionOffset;
//   bool isVisible;

//   Marker({
//     required this.index,
//     required this.position,
//     required this.positionOffset,
//     required this.isVisible,
//   });
// }
// //  FloatingActionButton(
// //           onPressed: () {
// //             setState(() {
// //               if (_controller.value.isPlaying) {
// //                 _controller.pause();
// //               } else {
// //                 _controller.play();
// //               }
// //             });
// //           },
// //           child: Icon(
// //             _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
// //           ),
// //         ),
// //         // FloatingActionButton(onPressed: () {
// //   setState(() {
// //     markers.clear();
// //   });
// // }),
// //    Expanded(
// //   child: DraggableScrollableSheet(
// //     initialChildSize: 0.5,
// //     minChildSize: 0.1,
// //     maxChildSize: 0.6,
// //     builder:
// //         (BuildContext context, ScrollController scrollController) {
// //       return BottomSheetWidget(
// //           reviewLists: reviewList, controller: _controller);
// //     },
// //   ),
// // ),
