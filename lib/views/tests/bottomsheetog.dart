// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:video_player/video_player.dart';
// import 'package:videodemo/views/video_view.dart';

// class BottomSheetWidget extends StatefulWidget {
//   final List<ReviewModel> reviewLists;
//   final VideoPlayerController controller;

//   BottomSheetWidget({
//     Key? key,
//     required this.reviewLists,
//     required this.controller,
//   }) : super(key: key);

//   @override
//   _BottomSheetWidgetState createState() => _BottomSheetWidgetState();
// }

// class _BottomSheetWidgetState extends State<BottomSheetWidget> {
//   String formatTime(Duration duration) {
//     String twoDigits(int n) {
//       if (n >= 10) return "$n ";
//       return "0$n";
//     }

//     String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
//     String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
//     return "$twoDigitMinutes:$twoDigitSeconds";
//   }

//   @override
//   Widget build(BuildContext context) {
//     print("Review List Length: ${widget.reviewLists.length}");
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         SizedBox(height: 14),
//         Center(
//           child: Divider(
//             thickness: 2,
//             color: Colors.black,
//             indent: 110, // Adjust as needed
//             endIndent: 110,
//           ),
//         ),
//         SizedBox(height: 17),
//         Padding(
//           padding: const EdgeInsets.only(left: 20, bottom: 27),
//           child: Text(
//             "Feedback List",
//             style: GoogleFonts.openSans(
//               fontSize: 16,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//         ),
//         Expanded(
//           child: ListView.builder(
//             itemCount: widget.reviewLists.length,
//             itemBuilder: (context, index) {
//               final obj = widget.reviewLists[index];
//               final review = obj.review;
//               final position = obj.order;
//               final timeStamp = obj.time;
//               print("Review: $review");
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   GestureDetector(
//                     onTap: () async {
//                       await widget.controller.seekTo(timeStamp);
//                       Future.delayed(const Duration(milliseconds: 10), () {
//                         widget.controller.pause();
//                         Navigator.of(context).pop();
//                       });
//                     },
//                     child: Container(
//                       color: Colors.transparent,
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 20, bottom: 26),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.fromLTRB(0, 0, 14, 0),
//                               child: Container(
//                                   decoration: BoxDecoration(
//                                     color: Color.fromRGBO(208, 98, 98, 1),
//                                     shape: BoxShape.circle,
//                                   ),
//                                   child: Padding(
//                                     padding:
//                                         const EdgeInsets.fromLTRB(18, 9, 18, 8),
//                                     child: Text(
//                                       position.toString(),
//                                       style: GoogleFonts.openSans(
//                                           fontSize: 24,
//                                           fontWeight: FontWeight.w700,
//                                           color: Colors.white),
//                                     ),
//                                   )),
//                             ),
//                             Flexible(
//                               child: Container(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.fromLTRB(
//                                           0, 0, 20, 0),
//                                       child: Text(
//                                         review,
//                                         style: GoogleFonts.poppins(
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.w400,
//                                           color: Color.fromRGBO(0, 0, 0, 0.6),
//                                         ),
//                                       ),
//                                     ),
//                                     // /  Text("time:"),
//                                     SizedBox(
//                                       height: 8,
//                                     ),
//                                     Row(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.end,
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Container(
//                                           decoration: BoxDecoration(
//                                             border: Border.all(
//                                               width: 1,
//                                               color: Color.fromRGBO(
//                                                   126, 100, 237, 1),
//                                             ),
//                                             borderRadius:
//                                                 BorderRadius.circular(2),
//                                           ),
//                                           child: Padding(
//                                             padding: const EdgeInsets.fromLTRB(
//                                                 16, 4, 16, 4),
//                                             child: Text(
//                                               formatTime(timeStamp),
//                                               style: GoogleFonts.poppins(
//                                                 fontSize: 8,
//                                                 fontWeight: FontWeight.w700,
//                                                 color: Color.fromRGBO(
//                                                     126, 100, 237, 1),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.fromLTRB(
//                                               0, 0, 20, 0),
//                                           child: Container(
//                                             decoration: BoxDecoration(
//                                               color: Color.fromRGBO(
//                                                   109, 197, 144, 1),
//                                               borderRadius:
//                                                   BorderRadius.circular(10),
//                                             ),
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.fromLTRB(
//                                                       8, 4, 8, 4),
//                                               child: Row(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceEvenly,
//                                                 children: [
//                                                   Padding(
//                                                     padding:
//                                                         const EdgeInsets.only(
//                                                             right: 4),
//                                                     child: Icon(
//                                                       Icons.edit,
//                                                       size: 8,
//                                                       color: Colors.white,
//                                                     ),
//                                                   ),
//                                                   Text(
//                                                     "Mark as Resolved",
//                                                     style: GoogleFonts.openSans(
//                                                       fontSize: 8,
//                                                       fontWeight:
//                                                           FontWeight.w700,
//                                                       color: Colors.white,
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

// class ReviewModel {
//   final Offset position;
//   final Duration time;
//   final String review;
//   final int order;

//   ReviewModel({
//     required this.position,
//     required this.time,
//     required this.review,
//     required this.order,
//   });
// }
