// // ignore_for_file: use_build_context_synchronously, prefer_const_constructors, unused_field

// import 'dart:async';
// import 'dart:io';
// import 'package:Video_Review/collection/marker_collection.dart';
// import 'package:Video_Review/services/firestore_service.dart';
// import 'package:Video_Review/views/home_view.dart';
// import 'package:Video_Review/views/widgets/project_bottom_sheet.dart';
// import 'package:Video_Review/views/widgets/shared_project_bottomsheet.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// import 'package:video_player/video_player.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class ProjectTestingCenter extends StatefulWidget {
//   // final XFile? videoPath;
//   // final Project project;
// //  final isarService = IsarService();
//   final String? projectID;
//   final String? videoPath;
//   //final Isar isar;
//   final String? projectTitle;
//   ProjectTestingCenter({
//     Key? key,
//     //required this.isar,
//     this.videoPath,
//     this.projectID,
//     this.projectTitle,
//     //  required this.project,
//   }) : super(key: key);

//   @override
//   State<ProjectTestingCenter> createState() => _ProjectTestingCenterState();
// }

// class _ProjectTestingCenterState extends State<ProjectTestingCenter> {
//   //final FireStoreService fireStoreService = FireStoreService();
//   // late final VideoPlayerController _controller;
//   // late Future<void> initializeVideoPlayer;
//   // late final TextEditingController _textController;
//   TextEditingController _saveFileController = TextEditingController();
//   List<Marker> markers = [];
//   //late List<ReviewModel> reviewList = [];
//   bool isVideoPlaying = false;
//   int duration = 0;
//   final ValueNotifier<double> _sliderValueNotifier = ValueNotifier<double>(0.0);

//   double _currentSliderValue = 0.0;
//   Duration _currentPosition = Duration.zero;

//   @override
//   void dispose() {
//     // _controller.dispose();
//     //   _textController.dispose();

//     super.dispose();
//   }

//   void seekToSeconds(int second) {
//     Duration newDuration = Duration(milliseconds: second);
//     //   _controller.seekTo(newDuration);
//   }

//   // void _addMarker(Duration positionInSeconds, Offset positionOffset) {
//   //   setState(() {
//   //     markers.add(Marker(
//   //       index: markers.length + 1,
//   //       position: positionInSeconds,
//   //       positionOffset: positionOffset,
//   //       isVisible: false,
//   //     ));
//   //     print("tiem when marker is added : $positionInSeconds");
//   //     print("Position Offset: $positionOffset");
//   //   });
//   // }

//   // _readMarker() async {
//   //   final markersCollections = widget.isar.markerCollections;
//   //   final getMarkers = await markersCollections
//   //       .where()
//   //       .filter()
//   //       .projectIdEqualTo(widget.projectID)
//   //       .findAll();
//   //   setState(() {
//   //     markersCollection = getMarkers;
//   //     markers = getMarkers
//   //         .map((marker) => Marker(
//   //               index: marker.order!,
//   //               position: Duration(milliseconds: marker.timeStamp!),
//   //               positionOffset: Offset(marker.dx!, marker.dy!),
//   //               isVisible: false,
//   //             ))
//   //         .toList();
//   //   });
//   // }

//   String formatDuration(Duration d) {
//     final minutes = d.inMinutes.toString().padLeft(2, '0');
//     final seconds = (d.inSeconds % 60).toString().padLeft(2, '0');
//     return '$minutes:$seconds';
//   }

//   // _deleteProject() async {
//   //   final projectCollection = widget.isar.projectCollecitons;
//   //   await widget.isar.writeTxn(() async {
//   //     await projectCollection.delete(widget.projectID!);
//   //   });
//   //   setState(() {});
//   //   Navigator.push(
//   //       context, MaterialPageRoute(builder: (context) => HomeView()));
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromRGBO(33, 37, 50, 1),
//       resizeToAvoidBottomInset: false,
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           SafeArea(
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Color.fromARGB(255, 255, 255, 251),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 18, right: 3),
//                 child: Row(
//                   //   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.of(context).pop();
//                         // Handle the arrow back functionality here
//                       },
//                       child: Icon(
//                         Icons.arrow_back,
//                         size: 20,
//                         color: Color.fromRGBO(0, 0, 0, 0.6),
//                       ),
//                     ),
//                     Center(
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 18),
//                         child: Text(
//                           "testing",
//                           //     widget.projectTitle!,
//                           style: GoogleFonts.openSans(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w700,
//                             color: Colors.black,
//                           ),
//                         ),
//                       ),
//                     ),

//                     PopupMenuButton<String>(
//                       offset: Offset.zero,
//                       onSelected: (value) {
//                         // Handle menu item selection
//                         // You can perform different actions based on the selected value
//                         if (value == 'edit') {
//                           //   showModalBottomSheet(
//                           //     isDismissible: true,
//                           //     shape: RoundedRectangleBorder(
//                           //         borderRadius: BorderRadius.only(
//                           //       topLeft: Radius.circular(20),
//                           //       topRight: Radius.circular(20),
//                           //    ' )),
//                           //     context: context,
//                           //     builder: (context) => SharedBottomSheet(
//                           //  //     projectId: widget.projectID!,
//                           //     ),
//                           //   );
//                           // Handle edit action
//                         } else if (value == 'delete') {
//                           // Handle delete action
//                           showDialog(
//                               context: context,
//                               builder: (context) => AlertDialog(
//                                     title: Text(
//                                         "Are you sure you want to delete ?"),
//                                     actions: [
//                                       TextButton(
//                                         onPressed: () {
//                                           Navigator.of(context).pop();
//                                         },
//                                         child: Text("No"),
//                                       ),
//                                       TextButton(
//                                         onPressed: () async {
//                                           // await fireStoreService.deleteProject(
//                                           //     context, widget.projectID!);
//                                           Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                   builder: (context) =>
//                                                       HomeView()));
//                                         },
//                                         child: Text("Yes"),
//                                       )
//                                     ],
//                                   ));
//                         }
//                       },
//                       itemBuilder: (BuildContext context) =>
//                           <PopupMenuEntry<String>>[
//                         const PopupMenuItem<String>(
//                           value: 'edit',
//                           child: Text('Share'),
//                         ),
//                         const PopupMenuItem<String>(
//                           value: 'delete',
//                           child: Text('Delete'),
//                         ),
//                       ],
//                     ),

//                     // Adjust the width to your requirement
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           //  SizedBox(height: 40),
//           Container(
//             child: Stack(
//               children: [
//                 Container(
//                   height: MediaQuery.sizeOf(context).height * 0.589,
//                   //height: 493,
//                   decoration: BoxDecoration(
//                     color: Color.fromRGBO(15, 18, 27, 1),
//                   ),
// //                   child: FutureBuilder(
// //                     future: initializeVideoPlayer,
// //                     builder: (context, snapshot) {
// //                       if (snapshot.connectionState == ConnectionState.done) {
// //                         return AspectRatio(
// //                           aspectRatio: 16 / 9,
// //                           child: GestureDetector(
// //                             onTapDown: (TapDownDetails details) async {
// //                               // Duration currentPosition =
// //                               //     _controller.value.position;
// //                               // _controller.pause();
// //                               //     int timeStamp = currentPosition.inMilliseconds;
// //                               // setState(() {
// //                               //   isVideoPlaying = false;
// //                               // });
// //                               //     print("this is Current Time :$currentPosition");
// //                               // int seconds = currentPosition.inSeconds;
// //                               // print(
// //                               //     "this are the seconds yo tapped : $seconds");

// //                               // print(
// //                               //     'Details global posiiton :${details.globalPosition}');

// //                               // showDialog(
// //                               //     context: context,
// //                               //     builder: (BuildContext context) {
// //                               //       _textController.clear();
// //                               //       return AlertDialog(
// //                               //           title: Text(
// //                               //             "Review",
// //                               //             style: TextStyle(
// //                               //               fontSize: 20,
// //                               //               fontWeight: FontWeight.w700,
// //                               //             ),
// //                               //           ),
// //                               //           content: TextField(
// //                               //             controller: _textController,
// //                               //             decoration: InputDecoration(
// //                               //                 border: OutlineInputBorder()),
// //                               //           ),
// //                               //           actions: [
// //                               //             TextButton(
// //                               //               onPressed: () async {
// //                               //                 Navigator.of(context).pop();

// //                               //                 // await _controller.play();
// //                               //               },
// //                               //               child: Text(
// //                               //                 'Cancel',
// //                               //                 style: TextStyle(
// //                               //                     color: const Color.fromARGB(
// //                               //                         255, 166, 162, 162),
// //                               //                     fontSize: 18,
// //                               //                     fontWeight: FontWeight.w400),
// //                               //               ),
// //                               //             ),
// //                               //             Container(
// //                               //               height: MediaQuery.of(context)
// //                               //                       .size
// //                               //                       .height /
// //                               //                   22,
// //                               //               decoration: BoxDecoration(
// //                               //                 color: Colors.purple,
// //                               //                 borderRadius:
// //                               //                     BorderRadius.circular(100),
// //                               //               ),
// //                               //               child: TextButton(
// //                               //                 onPressed: () async {
// //                               //                   Navigator.of(context).pop();
// //                               //                   String currentReview =
// //                               //                       _textController.text;
// //                               //                   // ReviewModel model = ReviewModel(
// //                               //                   //   position:
// //                               //                   //       details.globalPosition,
// //                               //                   //   time: currentPosition,
// //                               //                   //   review: currentReview,
// //                               //                   //   order: reviewList.length + 1,
// //                               //                   // );
// //                               //                   setState(() {
// //                               //                     //  reviewList.add(model);
// //                               //                     // _addMarker(currentPosition,
// //                               //                     //     details.globalPosition);
// //                               //                     // Marker lastMarker =
// //                               //                     //     markers.last;
// //                               //                     // lastMarker.isVisible = true;
// //                               //                   });
// //                               //                 },
// //                               //                 child: Text(
// //                               //                   'Done',
// //                               //                   style: TextStyle(
// //                               //                     color: Colors.white,
// //                               //                     fontSize: 14,
// //                               //                     fontWeight: FontWeight.w400,
// //                               //                   ),
// //                               //                 ),
// //                               //               ),
// //                               //             ),
// // //                                        ]);
// //                               //                                });
// //                             },
// //                             child: FittedBox(
// //                               fit: BoxFit.contain,
// //                               child: SizedBox(
// //                                   // width: _controller.value.size.width,
// //                                   // height: _controller.value.size.height,
// //                                   // child: VideoPlayer(_controller),
// //                                   ),
// //                             ),
// //                           ),
// //                         );
// //                       } else {
// //                         return Center(child: CircularProgressIndicator());
// //                       }
// //                     },
// //                   ),
//                 ),
//                 for (var marker in markers)
//                   if (marker.isVisible)
//                     Positioned(
//                       left: marker.positionOffset.dx - 14,
//                       top: marker.positionOffset.dy - 117,
//                       child: Container(
//                         height: 40,
//                         width: 40,
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
//           Stack(children: [
//             Positioned(
//               child: Container(
//                 padding: EdgeInsets.zero,

//                 color: Color.fromRGBO(15, 18, 27, 1),
//                 //  color: Colors.white,
//                 height: 35,
//                 child: SliderTheme(
//                   data: SliderTheme.of(context).copyWith(
//                     thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6.0),
//                     thumbColor: Color.fromRGBO(124, 184, 240, 1),
//                     trackHeight: 2,
//                     activeTrackColor: Color.fromRGBO(124, 184, 240, 1),
//                     inactiveTrackColor: Color.fromRGBO(124, 184, 240, 0.4),
//                     overlayShape: SliderComponentShape.noOverlay,
//                   ),
//                   child: Slider(
//                     value: _currentPosition.inSeconds.toDouble(),
//                     min: 0.0,
//                     //   max: _controller.value.duration.inSeconds.toDouble(),
//                     onChanged: (value) {
//                       setState(() {
//                         _currentSliderValue = value;
//                       });
//                     },
//                     onChangeEnd: (value) {
//                       //   _controller.seekTo(Duration(seconds: value.toInt()));
//                     },
//                   ),
//                 ),
//               ),
//             ),
//             Positioned(
//               left: 8,
//               bottom: 1,
//               child: Text(""
//                   // //  '${formatDuration(_currentPosition)} / ${formatDuration(_controller.value.duration)}',
//                   //   style: GoogleFonts.openSans(
//                   //     fontSize: 7,
//                   //     fontWeight: FontWeight.w300,
//                   //     color: Color.fromRGBO(255, 255, 255, 1),
//                   //   ),
//                   ),
//             ),
//           ]),
//           SizedBox(height: MediaQuery.sizeOf(context).height * 0.024),
//           Padding(
//             padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
//             child: Container(
//               height: MediaQuery.sizeOf(context).height * 0.18,
//               //   height: 100,
//               decoration: BoxDecoration(
//                 color: Color.fromRGBO(15, 18, 27, 1),
//                 border: Border.all(width: 1),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 26, bottom: 26),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   mainAxisSize: MainAxisSize.max,
//                   children: [
//                     GestureDetector(
//                       onTap: () async {
//                         final result = await showModalBottomSheet(
//                           isDismissible: true,
//                           //     isScrollControlled: true,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(20),
//                               topRight: Radius.circular(20),
//                             ),
//                           ),
//                           context: context,
//                           builder: (context) {
//                             return Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(20),
//                                   topRight: Radius.circular(20),
//                                 ),
//                               ),
//                               //    child: ProjectBottomSheet(
//                               //  isarInsatance: widget.isar,
//                               // projectId: widget.projectID,
//                               // controller: _controller,
//                               // ),
//                             );
//                           },
//                         );
//                       },
//                       child: SvgPicture.asset('assets/icon/chat.svg'),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         // setState(() {
//                         //   if (isVideoPlaying) {
//                         //     _controller.pause();
//                         //   } else {
//                         //     _controller.play();
//                         //   }
//                         //   isVideoPlaying = !isVideoPlaying;
//                         // });
//                       },
//                       child: SvgPicture.asset(
//                           //    _controller.value.isPlaying
//                           'assets/icon/motion_photos_paused.svg'
//                           // 'assets/icon/sound_sampler.svg',
//                           ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         // _controller.seekTo(Duration.zero);
//                         // _controller.pause();
//                         // setState(() {
//                         //   isVideoPlaying = false;
//                         // });
//                       },
//                       child: SvgPicture.asset('assets/icon/stop_circle.svg'),
//                     ),
//                   ],
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




// // ignore_for_file: use_build_context_synchronously, prefer_const_constructors, unused_field, prefer_const_constructors_in_immutables

// import 'dart:async';
// import 'dart:io';
// import 'package:Video_Review/services/firestore_service.dart';
// import 'package:Video_Review/views/bottom_sheet_widget.dart';
// import 'package:Video_Review/views/home_view.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';

// import 'package:video_player/video_player.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class VideoView extends StatefulWidget {
//   final String? videoPath;
//   // final Isar isar;
//   final String? projectID;

//   VideoView({
//     Key? key,
//     this.videoPath,
//     //  required this.isar,
//     required this.projectID,
//   }) : super(key: key);

//   @override
//   State<VideoView> createState() => _VideoViewState();
// }

// class _VideoViewState extends State<VideoView> {
//   String? _downloadUrl;
//   final FireStoreService fireStoreService = FireStoreService();
//   // VideoCollection? videoPath;
//   late String projectDateTime;

//   late final VideoPlayerController _controller;
//   late Future<void> initializeVideoPlayer;
//   late final TextEditingController _textController;
//   final TextEditingController _saveFileController = TextEditingController();
//   List<Marker> markers = [];
//   late List<ReviewModel> reviewList = [];
//   bool isVideoPlaying = false;
//   int duration = 0;
//   final ValueNotifier<double> _sliderValueNotifier = ValueNotifier<double>(0.0);

//   double _currentSliderValue = 0.0;
//   Duration _currentPosition = Duration.zero;
//   bool isLoading = false;
//   @override
//   void initState() {
//     super.initState();

//     _controller = VideoPlayerController.file(File(widget.videoPath!));

//     initializeVideoPlayer = _controller.initialize();
//     _textController = TextEditingController();
//     _controller.addListener(() {
//       _sliderValueNotifier.value =
//           _controller.value.position.inMilliseconds.toDouble();
//       setState(() {
//         _currentPosition = _controller.value.position;
//       });
//       if (_controller.value.position == _controller.value.duration) {
//         setState(() {
//           isVideoPlaying = _controller.value.isPlaying;
//         });
//       }
//       Duration currentTime = _controller.value.position;

//       setState(() {
//         duration = currentTime.inMilliseconds;
//       });
//       print("current Time  is this where it will display: $currentTime");
//       for (var marker in markers) {
//         var diff =
//             (marker.position.inMilliseconds - currentTime.inMilliseconds).abs();
//         if (diff < 300) {
//           marker.isVisible = true;
//         } else {
//           marker.isVisible = false;
//         }
//       }
//       if (_controller.value.isPlaying) {
//         Duration currentTime = _controller.value.position;
//         setState(() {
//           duration = currentTime.inMilliseconds;
//         });
//         print("current Time  is this where it will display: $currentTime");
//         for (var marker in markers) {
//           var diff =
//               (marker.position.inMilliseconds - currentTime.inMilliseconds)
//                   .abs();
//           if (diff < 300) {
//             marker.isVisible = true;
//           } else {
//             marker.isVisible = false;
//           }
//         }
//         setState(() {});
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     _textController.dispose();
//     // _readMarkers();

//     super.dispose();
//   }

//   void seekToSeconds(int second) {
//     Duration newDuration = Duration(milliseconds: second);
//     _controller.seekTo(newDuration);
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

//   String formatDuration(Duration d) {
//     final minutes = d.inMinutes.toString().padLeft(2, '0');
//     final seconds = (d.inSeconds % 60).toString().padLeft(2, '0');
//     return '$minutes:$seconds';
//   }

//   DateTime _dateTime() {
//     return DateTime.now();
//   }

//   String _formattedDateTime(DateTime date) {
//     final DateFormat formatter = DateFormat('dd MMM');
//     final String formattedDateTime = formatter.format(date);
//     setState(() {
//       projectDateTime = formattedDateTime;
//       print("goudbd dsa Date is :$projectDateTime");
//     });
//     return formattedDateTime;
//   }

//   _addProjectToFirestore() async {
//     _downloadUrl = await fireStoreService.uploadVideo(widget.videoPath!);
//     await fireStoreService.projectCollection.doc(widget.projectID).update({
//       'title': _saveFileController.text,
//       'videoPath': _downloadUrl,
//       'projectId': widget.projectID,
//     });
//     setState(() {
//       _saveFileController.clear();
//     });
//   }

//   _addMarkersToFireStoreCollection(Offset positionOffset, int timeStamp) async {
//     await fireStoreService.addMarker(
//         widget.projectID.toString(),
//         _textController.text,
//         timeStamp,
//         positionOffset.dx,
//         positionOffset.dy,
//         markers.length);
//     setState(() {
//       print('Project ID: ${widget.projectID}');
//     });
//   }

//   _willpopScopeDialog() async {
//     await showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//                 title: Text("Save your feedback before exiting?"),
//                 actions: [
//                   TextButton(
//                     onPressed: () async {
//                       fireStoreService.deleteProject(
//                           context, widget.projectID!);
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (context) => HomeView()));
//                     },
//                     child: Text(
//                       "No",
//                       style: TextStyle(
//                         color: const Color.fromARGB(255, 148, 146, 146),
//                       ),
//                     ),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       showDialog(
//                           context: context,
//                           builder: (BuildContext context) => AlertDialog(
//                                 title: Text("File name"),
//                                 content: TextFormField(
//                                   controller: _saveFileController,
//                                 ),
//                                 actions: [
//                                   ElevatedButton(
//                                     onPressed: () async {
//                                       if (_saveFileController.text.isNotEmpty) {
//                                         setState(() {
//                                           isLoading = true;
//                                         });
//                                         await _addProjectToFirestore();

//                                         Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     HomeView())).then((_) {
//                                           setState(() {
//                                             isLoading = false;
//                                           });
//                                         });
//                                         if (isLoading)
//                                           CircularProgressIndicator();
//                                       }
//                                     },
//                                     child: Text("Save"),
//                                   )
//                                 ],
//                               ));
//                     },
//                     child: Text("Yes"),
//                   ),
//                 ]));
//   }

//   // _deleteProject() async {
//   //   final projectCollection = widget.isar.projectCollecitons;
//   //   await widget.isar.writeTxn(() async {
//   //     await projectCollection.delete(widget.projectID!);
//   //   });
//   //   setState(() {});
//   //   Navigator.push(context,
//   //       MaterialPageRoute(builder: (context) => HomeView(isar: widget.isar)));
//   // }

//   @override
//   Widget build(BuildContext context) {
//     // final figmaImageHeight = 40; // the value from Figma
//     // final logicalPixelRatio = MediaQuery.of(context).devicePixelRatio;
//     return WillPopScope(
//       onWillPop: () async {
//         return await _willpopScopeDialog();
//       },
//       child: Scaffold(
//         backgroundColor: Color.fromRGBO(33, 37, 50, 1),
//         resizeToAvoidBottomInset: false,
//         body: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             SafeArea(
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Color.fromARGB(255, 255, 255, 251),
//                 ),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Padding(
//                       padding:
//                           const EdgeInsets.only(top: 18, left: 18, bottom: 19),
//                       child: GestureDetector(
//                         onTap: () {
//                           _willpopScopeDialog();
//                         },
//                         child: Icon(
//                           Icons.arrow_back,
//                           size: 20,
//                           color: Color.fromRGBO(0, 0, 0, 0.6),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 17, bottom: 18),
//                       child: Text(
//                         "Add Feedback ",
//                         style: GoogleFonts.openSans(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w700,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),

//                     GestureDetector(
//                       onTap: () {
//                         showDialog(
//                           context: context,
//                           builder: (BuildContext context) => AlertDialog(
//                               title: Text("File name"),
//                               content: TextFormField(
//                                 controller: _saveFileController,
//                               ),
//                               actions: [
//                                 TextButton(
//                                   onPressed: () async {
//                                     Navigator.of(context).pop();
//                                   },
//                                   child: Text("Cancel"),
//                                 ),
//                                 ElevatedButton(
//                                   onPressed: () async {
//                                     if (_saveFileController.text.isNotEmpty) {
//                                       showDialog(
//                                         context: context,
//                                         barrierDismissible: false,
//                                         builder: (BuildContext context) {
//                                           return AlertDialog(
//                                             content: Column(
//                                               mainAxisSize: MainAxisSize.min,
//                                               children: [
//                                                 CircularProgressIndicator(),
//                                                 SizedBox(height: 16),
//                                                 Text("Saving..."),
//                                               ],
//                                             ),
//                                           );
//                                         },
//                                       );

//                                       try {
//                                         final dateio = _dateTime();
//                                         final formatedok =
//                                             _formattedDateTime(dateio);
//                                         print("Date :$formatedok");
//                                         await _addProjectToFirestore();
//                                         Navigator.pushReplacement(
//                                           context,
//                                           MaterialPageRoute(
//                                               builder: (context) => HomeView()),
//                                         );
//                                       } catch (e) {
//                                         print("Error: $e");
//                                         // Handle the error if needed
//                                       } finally {
//                                         Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     HomeView()));
//                                       }
//                                     }
//                                   },
//                                   child: Text("Save"),
//                                 )
//                               ]),
//                         );
//                       },
//                       child: Padding(
//                         padding: const EdgeInsets.only(right: 18),
//                         child: Text("Save",
//                             style: GoogleFonts.openSans(
//                               fontSize: 15,
//                               fontWeight: FontWeight.w700,
//                               color: Colors.black,
//                             )),
//                       ),
//                     ) // Adju// Adjust the width to your requirement
//                   ],
//                 ),
//               ),
//             ),
//             //  SizedBox(height: 40),
//             Container(
//               child: Stack(
//                 children: [
//                   Container(
//                     height: MediaQuery.sizeOf(context).height * 0.6,
//                     //height: 493,
//                     decoration: BoxDecoration(
//                       color: Color.fromRGBO(15, 18, 27, 1),
//                     ),
//                     child: FutureBuilder(
//                       future: initializeVideoPlayer,
//                       builder: (context, snapshot) {
//                         if (snapshot.connectionState == ConnectionState.done) {
//                           return AspectRatio(
//                             aspectRatio: 16 / 9,
//                             child: GestureDetector(
//                               onTapDown: (TapDownDetails details) async {
//                                 Duration currentPosition =
//                                     _controller.value.position;
//                                 _controller.pause();
//                                 int timeStamp = currentPosition.inMilliseconds;
//                                 setState(() {
//                                   isVideoPlaying = false;
//                                 });
//                                 print("this is Current Time :$currentPosition");
//                                 int seconds = currentPosition.inSeconds;
//                                 print(
//                                     "this are the seconds yo tapped : $seconds");
//                                 double positionPercentage =
//                                     details.localPosition.dx /
//                                         _controller.value.size.width;

//                                 print(
//                                     'New Details global posiiton :$positionPercentage');
//                                 print(
//                                     'Details global posiiton :${details.globalPosition}');

//                                 showDialog(
//                                     context: context,
//                                     builder: (BuildContext context) {
//                                       _textController.clear();
//                                       return AlertDialog(
//                                           title: Text(
//                                             "Review",
//                                             style: TextStyle(
//                                               fontSize: 20,
//                                               fontWeight: FontWeight.w700,
//                                             ),
//                                           ),
//                                           content: TextField(
//                                             maxLines: null,
//                                             minLines: null,
//                                             //  expands: true,
//                                             autofocus: true,
//                                             controller: _textController,
//                                             decoration: InputDecoration(
//                                                 border: OutlineInputBorder()),
//                                           ),
//                                           actions: [
//                                             TextButton(
//                                               onPressed: () async {
//                                                 Navigator.of(context).pop();

//                                                 // await _controller.play();
//                                               },
//                                               child: Text(
//                                                 'Cancel',
//                                                 style: TextStyle(
//                                                     color: const Color.fromARGB(
//                                                         255, 166, 162, 162),
//                                                     fontSize: 18,
//                                                     fontWeight:
//                                                         FontWeight.w400),
//                                               ),
//                                             ),
//                                             Container(
//                                               height: MediaQuery.of(context)
//                                                       .size
//                                                       .height /
//                                                   22,
//                                               decoration: BoxDecoration(
//                                                 color: Colors.purple,
//                                                 borderRadius:
//                                                     BorderRadius.circular(100),
//                                               ),
//                                               child: TextButton(
//                                                 onPressed: () async {
//                                                   Navigator.of(context).pop();
//                                                   String currentReview =
//                                                       _textController.text;
//                                                   ReviewModel model =
//                                                       ReviewModel(
//                                                     position:
//                                                         details.globalPosition,
//                                                     time: currentPosition,
//                                                     review: currentReview,
//                                                     order:
//                                                         reviewList.length + 1,
//                                                   );
//                                                   setState(() {
//                                                     reviewList.add(model);
//                                                     _addMarker(currentPosition,
//                                                         details.globalPosition);
//                                                     Marker lastMarker =
//                                                         markers.last;
//                                                     lastMarker.isVisible = true;
//                                                   });
//                                                   _addMarkersToFireStoreCollection(
//                                                       details.globalPosition,
//                                                       timeStamp);
//                                                 },
//                                                 child: Text(
//                                                   'Done',
//                                                   style: TextStyle(
//                                                     color: Colors.white,
//                                                     fontSize: 14,
//                                                     fontWeight: FontWeight.w400,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ]);
//                                     });
//                               },
//                               child: FittedBox(
//                                 fit: BoxFit.contain,
//                                 child: SizedBox(
//                                   width: _controller.value.size.width,
//                                   height: _controller.value.size.height,
//                                   child: VideoPlayer(_controller),
//                                 ),
//                               ),
//                             ),
//                           );
//                         } else {
//                           return Center(child: CircularProgressIndicator());
//                         }
//                       },
//                     ),
//                   ),
//                   for (var marker in markers)
//                     if (marker.isVisible)
//                       Positioned(
//                         left: marker.positionOffset.dx - 14,
//                         top: marker.positionOffset.dy - 117,
//                         child: Container(
//                           height: 40,
//                           width: 40,
//                           decoration: BoxDecoration(
//                             color: Color.fromRGBO(208, 98, 98, 1),
//                             //  border: Border.all(width: 2, color: Colors.white),
//                             shape: BoxShape.circle,
//                           ),
//                           child: Center(
//                             child: Text(
//                               '${marker.index}',
//                               style: GoogleFonts.openSans(
//                                 fontSize: 24,
//                                 fontWeight: FontWeight.w700,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                 ],
//               ),
//             ),
//             Stack(children: [
//               Positioned(
//                 child: Container(
//                   padding: EdgeInsets.zero,

//                   color: Color.fromRGBO(15, 18, 27, 1),
//                   //  color: Colors.white,
//                   height: 38,
//                   child: SliderTheme(
//                     data: SliderTheme.of(context).copyWith(
//                       thumbShape:
//                           RoundSliderThumbShape(enabledThumbRadius: 6.0),
//                       thumbColor: Color.fromRGBO(124, 184, 240, 1),
//                       trackHeight: 2,
//                       activeTrackColor: Color.fromRGBO(124, 184, 240, 1),
//                       inactiveTrackColor: Color.fromRGBO(124, 184, 240, 0.4),
//                       overlayShape: SliderComponentShape.noOverlay,
//                     ),
//                     child: Slider(
//                       value: _currentPosition.inSeconds.toDouble(),
//                       min: 0.0,
//                       max: _controller.value.duration.inSeconds.toDouble(),
//                       onChanged: (value) {
//                         setState(() {
//                           _currentSliderValue = value;
//                         });
//                       },
//                       onChangeEnd: (value) {
//                         _controller.seekTo(Duration(seconds: value.toInt()));
//                       },
//                     ),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 left: 8,
//                 bottom: 1,
//                 child: Text(
//                   '${formatDuration(_currentPosition)} / ${formatDuration(_controller.value.duration)}',
//                   style: GoogleFonts.openSans(
//                     fontSize: 7,
//                     fontWeight: FontWeight.w300,
//                     color: Color.fromRGBO(255, 255, 255, 1),
//                   ),
//                 ),
//               ),
//             ]),
//             SizedBox(height: MediaQuery.sizeOf(context).height * 0.028),
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
//                 child: Container(
//                   //  height: MediaQuery.sizeOf(context).height * 0.170,
//                   decoration: BoxDecoration(
//                     color: Color.fromRGBO(15, 18, 27, 1),
//                     border: Border.all(width: 1),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.only(top: 0, bottom: 0),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       mainAxisSize: MainAxisSize.max,
//                       children: [
//                         GestureDetector(
//                           onTap: () async {
//                             await showModalBottomSheet(
//                               isDismissible: true,
//                               //     isScrollControlled: true,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(20),
//                                   topRight: Radius.circular(20),
//                                 ),
//                               ),
//                               context: context,
//                               builder: (context) {
//                                 return Container(
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.only(
//                                       topLeft: Radius.circular(20),
//                                       topRight: Radius.circular(20),
//                                     ),
//                                   ),
//                                   child: BottomSheetWidget(
//                                     //   isarInsatance: widget.isarInstnce,
//                                     reviewLists: reviewList,
//                                     controller: _controller,
//                                   ),
//                                 );
//                               },
//                             );
//                           },
//                           child: SvgPicture.asset('assets/icon/chat.svg'),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               if (isVideoPlaying) {
//                                 _controller.pause();
//                               } else {
//                                 _controller.play();
//                               }
//                               isVideoPlaying = !isVideoPlaying;
//                             });
//                           },
//                           child: SvgPicture.asset(
//                             _controller.value.isPlaying
//                                 ? 'assets/icon/motion_photos_paused.svg'
//                                 : 'assets/icon/sound_sampler.svg',
//                             height: 40,
//                             width: 39,
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             _controller.seekTo(Duration.zero);
//                             _controller.pause();
//                             setState(() {
//                               isVideoPlaying = false;
//                             });
//                           },
//                           child:
//                               SvgPicture.asset('assets/icon/stop_circle.svg'),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),

//             SizedBox(height: MediaQuery.sizeOf(context).height * 0.028),
//           ],
//         ),
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
