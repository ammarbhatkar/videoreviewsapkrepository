// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:isar/isar.dart';
// import 'package:videodemo/collections/project.dart';
// import 'package:videodemo/collections/video_collection.dart';
// import 'package:videodemo/views/video_view.dart';
// import 'package:path_provider/path_provider.dart';
// import 'dart:io';

// class HomeView extends StatefulWidget {
//   final Isar isarInstnce;
//   const HomeView({
//     super.key,
//     required this.isarInstnce,
//   });

//   @override
//   State<HomeView> createState() => _HomeViewState();
// }

// class _HomeViewState extends State<HomeView> {
// //
//   List<Project>? projectsList;
//   List<VideoCollection>? videosCollection;
//   Future<String> _saveVideo(XFile videoFile) async {
//     final directory = await getApplicationDocumentsDirectory();
//     final path = directory.path;
//     final videoDirPath = '$path/videosDemo';

//     final videoDir = Directory(videoDirPath);
//     if (!videoDir.existsSync()) {
//       videoDir.createSync(recursive: true);
//     }
//     final newVideoFilePath = '$videoDirPath/${videoFile.path.split('/').last}';

//     await videoFile.saveTo(newVideoFilePath);

//     return newVideoFilePath;
//   }

//   @override
//   void initState() {
//     super.initState();
//   }

//   final ImagePicker picker = ImagePicker();
//   late XFile? galleryVideo;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromARGB(255, 255, 255, 251),
//       body: SafeArea(
//         child: Stack(children: [
//           Align(
//             alignment: Alignment.centerRight,
//             child: Padding(
//               padding: const EdgeInsets.fromLTRB(0, 70, 24.5, 24),
//               child: 
//             ),
//           ),
//           PositioImage.asset('assets/images/background.png'),ned(
//             top: 20,
//             left: 24,
//             child: Container(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   SvgPicture.asset(
//                     "assets/icon/icon-circle.svg",
//                     height: 50,
//                     width: 50,
//                   ),
//                   SizedBox(height: 19),
//                   Text(
//                     "My Videos",
//                     style: GoogleFonts.openSans(
//                       fontSize: 32,
//                       fontWeight: FontWeight.w800,
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   Container(
//                     width: 300,
//                     child: Padding(
//                       padding: const EdgeInsets.fromLTRB(0, 0, 23, 0),
//                       child: Text(
//                         "Click on any of the video to review and drop feedback pins. ",
//                         style: GoogleFonts.openSans(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w400,
//                           color: Color.fromRGBO(0, 0, 0, 0.6),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   GestureDetector(
//                     //   onTap: () async {
//                     //     galleryVideo =
//                     //         await picker.pickVideo(source: ImageSource.gallery);
//                     //     if (galleryVideo != null) {
//                     //     _saveVideo(galleryVideo!);
//                     //     }

//                     //     Navigator.push(
//                     //         context,
//                     //         MaterialPageRoute(
//                     //             builder: (builder) => VideoView(
//                     //                   videoPath: galleryVideo,
//                     //                 )));
//                     //   },

//                     onTap: () async {
//                       galleryVideo =
//                           await picker.pickVideo(source: ImageSource.gallery);
//                       if (galleryVideo != null) {
//                         final newPath = await _saveVideo(galleryVideo!);

//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (builder) => VideoView(
//                               isarInstnce: widget.isarInstnce,
//                               videoPath: newPath, // Pass the new file path
//                             ),
//                           ),
//                         );
//                       }
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                           color: Color.fromRGBO(126, 100, 237, 1),
//                           borderRadius: BorderRadius.circular(10)),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.fromLTRB(16, 16, 0, 39),
//                             child: Icon(
//                               Icons.add_circle,
//                               size: 40,
//                               color: Color.fromRGBO(255, 255, 255, 1),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
//                             child: Text(
//                               "Select New",
//                               style: GoogleFonts.openSans(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.w800,
//                                 color: Color.fromRGBO(255, 255, 255, 1),
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.fromLTRB(16, 0, 18, 16),
//                             child: Text(
//                               "to start reviewing",
//                               style: GoogleFonts.openSans(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w600,
//                                 color: Color.fromRGBO(255, 255, 255, 0.6),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Container(
//             child: Text("Hello"),
//           )
//         ]),
//       ),
//     );
//   }

//   void _readProjects() async {
//     final projects = widget.isarInstnce.projects;
//     final getProjects = await projects.where().findAll();
//     setState(() {
//       projectsList = getProjects;
//     });
//   }
// }

// // Column(
// //           mainAxisAlignment: MainAxisAlignment.start,
// //           crossAxisAlignment: CrossAxisAlignment.center,
// //           children: [
// //             Padding(
// //               padding: const EdgeInsets.fromLTRB(18, 40, 30, 0),
// //               child: Container(
// //                 child: Text(
// //                   'Click on  " + "  button select video',
// //                   style: TextStyle(
// //                     color: Color.fromARGB(255, 129, 129, 127),
// //                     fontSize: 22,
// //                     fontWeight: FontWeight.w400,
// //                   ),
// //                 ),
// //               ),
// //             ),
// //             GestureDetector(
// //               onTap: () async {
// //                 galleryVideo =
// //                     await picker.pickVideo(source: ImageSource.gallery);
// //                 Navigator.push(
// //                     context,
// //                     MaterialPageRoute(
// //                         builder: (builder) => VideoView(
// //                               videoPath: galleryVideo,
// //                             )));
// //               },
// //               child: Container(
// //                 decoration: BoxDecoration(
// //                   color: Color.fromARGB(255, 187, 2, 249),
// //                   borderRadius: BorderRadius.circular(10),
// //                 ),
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   mainAxisAlignment: MainAxisAlignment.start,
// //                   children: [
// //                     Padding(
// //                       padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
// //                       child: Icon(
// //                         Icons.add_circle,
// //                         color: Colors.white,
// //                       ),
// //                     ),
// //                     Padding(
// //                       padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
// //                       child: Text(
// //                         "Select Video",
// //                         style: TextStyle(
// //                           color: Colors.white,
// //                           fontSize: 16,
// //                           fontWeight: FontWeight.w700,
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
