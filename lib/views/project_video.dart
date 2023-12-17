// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, unused_field, prefer_const_constructors_in_immutables,

import 'dart:async';
import 'package:Video_Review/services/firebase_dynamic_links.dart';
import 'package:Video_Review/services/firestore_service.dart';
import 'package:Video_Review/utilities/diaogs/generic_dialog.dart';
import 'package:Video_Review/views/home_view.dart';
import 'package:Video_Review/views/widgets/project_bottom_sheet.dart';
import 'package:Video_Review/views/widgets/shared_project_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

import 'package:video_player/video_player.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProjectVideo extends StatefulWidget {
  // final XFile? videoPath;
  // final Project project;
//  final isarService = IsarService();
  final String? projectID;
  final String? videoPath;
  bool? ownerverified;
  //final Isar isar;
  final String? projectTitle;
  String? activeUser;
  ProjectVideo({
    Key? key,
    //required this.isar,
    this.videoPath,
    this.projectID,
    this.projectTitle,
    this.activeUser,
    //  required this.project,
  }) : super(key: key);

  @override
  State<ProjectVideo> createState() => _ProjectVideoState();
}

class _ProjectVideoState extends State<ProjectVideo> {
  double? projectDeviceWidth;
  String? dynamicLink;
  double? projectDeviceHeight;
  String? userEmail;
  String? projectOwner;
  final FireStoreService fireStoreService = FireStoreService();
  late final VideoPlayerController _controller;
  late Future<void> initializeVideoPlayer;
  late final TextEditingController _textController;
  final TextEditingController _saveFileController = TextEditingController();
  List<Marker> markers = [];
  //late List<ReviewModel> reviewList = [];
  bool isVideoPlaying = false;
  int duration = 0;
  final ValueNotifier<double> _sliderValueNotifier = ValueNotifier<double>(0.0);

  double _currentSliderValue = 0.0;
  Duration _currentPosition = Duration.zero;

  @override
  void initState() {
    super.initState();
    chechkActiveUser();
    print("Project Id from projectVideo:${widget.projectID}");

    print("Project Video Path from projectVideo:${widget.videoPath}");
    //_readMarker();
    _controller =
        VideoPlayerController.networkUrl(Uri.parse(widget.videoPath!));
    print("Video Player State: ${_controller.value}");
    initializeVideoPlayer = _controller.initialize();
    _textController = TextEditingController();
    _controller.addListener(() {
      _sliderValueNotifier.value =
          _controller.value.position.inMilliseconds.toDouble();
      setState(() {
        _currentPosition = _controller.value.position;
      });
      if (_controller.value.position == _controller.value.duration) {
        setState(() {
          isVideoPlaying = _controller.value.isPlaying;
        });
      }
      Duration currentTime = _controller.value.position;

      setState(() {
        duration = currentTime.inMilliseconds;
      });
      print("current Time  is this where it will display: $currentTime");
      for (var marker in markers) {
        var diff =
            (marker.position.inMilliseconds - currentTime.inMilliseconds).abs();
        if (diff < 300) {
          marker.isVisible = true;
        } else {
          marker.isVisible = false;
        }
      }
      if (_controller.value.isPlaying) {
        Duration currentTime = _controller.value.position;
        setState(() {
          duration = currentTime.inMilliseconds;
        });
        print("current Time  is this where it will display: $currentTime");
        for (var marker in markers) {
          var diff =
              (marker.position.inMilliseconds - currentTime.inMilliseconds)
                  .abs();
          if (diff < 300) {
            marker.isVisible = true;
          } else {
            marker.isVisible = false;
          }
        }
        setState(() {});
      }
    });
    _fetchMarkers();
    fetchDimensionsForProject();
  }

  @override
  void dispose() {
    _controller.dispose();
    _textController.dispose();

    super.dispose();
  }

  chechkActiveUser() {
    final activeUSer = widget.activeUser;
    setState(() {
      print("===========:$activeUSer");
    });
  }

  void _fetchMarkers() {
    fireStoreService
        .getmarkersForProjects(widget.projectID!)
        .listen((snapshot) {
      setState(() {
        markers = snapshot.docs.map((doc) {
          // Parse markers from the snapshot
          return Marker(
            index: doc['order'] ?? 0,
            position: Duration(milliseconds: doc['timeStamp'] ?? 0),
            positionOffset: Offset(doc['dx'] ?? 0.0, doc['dy'] ?? 0.0),
            isVisible: false,
          );
        }).toList();
      });
    });
  }

  fetchDimensionsForProject() {
    fireStoreService.getProjects(widget.projectID ?? "").listen((snapshot) {
      setState(() {
        if (snapshot.docs.isNotEmpty) {
          final projectData =
              snapshot.docs.first.data() as Map<String, dynamic>?;
          projectDeviceWidth = projectData?['currentDeviceWidth'] ?? 0.0;
          projectDeviceHeight = projectData?['currentDeviceHeight'] ?? 0.0;
          dynamicLink = projectData?['dynamicLink'] ?? "";
          userEmail = projectData?['userEmail'] ?? "";
          setState(() {
            projectOwner = userEmail;
          });

          print("Fetched owner is :$projectOwner");
          print("Fetched Dynamic Link is : $dynamicLink");
          print("Fetched project width: $projectDeviceWidth");
          print("Fetched project height: $projectDeviceHeight");
        }
      });
      checkingOwnerShip();
    });
  }

  checkingOwnerShip() {
    if (widget.activeUser == projectOwner) {
      setState(() {
        widget.ownerverified = true;
        print("owner verified:${widget.ownerverified}");
      });
    } else if (widget.activeUser != projectOwner) {
      setState(() {
        widget.ownerverified = false;

        print("owner verified:${widget.ownerverified}");
      });
    }
  }

  void seekToSeconds(int second) {
    Duration newDuration = Duration(milliseconds: second);
    _controller.seekTo(newDuration);
  }

  // void _addMarker(Duration positionInSeconds, Offset positionOffset) {
  //   setState(() {
  //     markers.add(Marker(
  //       index: markers.length + 1,
  //       position: positionInSeconds,
  //       positionOffset: positionOffset,
  //       isVisible: false,
  //     ));
  //     print("tiem when marker is added : $positionInSeconds");
  //     print("Position Offset: $positionOffset");
  //   });
  // }

  // _readMarker() async {
  //   final markersCollections = widget.isar.markerCollections;
  //   final getMarkers = await markersCollections
  //       .where()
  //       .filter()
  //       .projectIdEqualTo(widget.projectID)
  //       .findAll();
  //   setState(() {
  //     markersCollection = getMarkers;
  //     markers = getMarkers
  //         .map((marker) => Marker(
  //               index: marker.order!,
  //               position: Duration(milliseconds: marker.timeStamp!),
  //               positionOffset: Offset(marker.dx!, marker.dy!),
  //               isVisible: false,
  //             ))
  //         .toList();
  //   });
  // }

  String formatDuration(Duration d) {
    final minutes = d.inMinutes.toString().padLeft(2, '0');
    final seconds = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  // _deleteProject() async {
  //   final projectCollection = widget.isar.projectCollecitons;
  //   await widget.isar.writeTxn(() async {
  //     await projectCollection.delete(widget.projectID!);
  //   });
  //   setState(() {});
  //   Navigator.push(
  //       context, MaterialPageRoute(builder: (context) => HomeView()));
  // }

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    print("The width is :$deviceWidth");
    print("the height is :$deviceHeight");
    return Scaffold(
      backgroundColor: Color.fromRGBO(33, 37, 50, 1),
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SafeArea(
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 251),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 18, right: 3),
                child: Row(
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        // Handle the arrow back functionality here
                      },
                      child: Icon(
                        Icons.arrow_back,
                        size: 20,
                        color: Color.fromRGBO(0, 0, 0, 0.6),
                      ),
                    ),

                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18),
                        child: Text(
                          widget.projectTitle!,
                          style: GoogleFonts.openSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),

                    PopupMenuButton<String>(
                      onSelected: (value) async {
                        if (widget.ownerverified == true) {
                          // Handle menu item selection
                          // You can perform different actions based on the selected value
                          if (value == 'edit') {
                            // GenericDialog.showLoadingDialog(
                            //     context, "Genrating Link");
                            // DynamicLinkService()
                            //     .createDynamicLinkForProject(widget.projectID)
                            //     .then((value) {
                            //   Share.share(value);
                            // });
                            GenericDialog.showLoadingDialog(
                                context, "Generating Link");

                            DynamicLinkService()
                                .createDynamicLinkForProject(widget.projectID)
                                .then((link) {
                              GenericDialog.hideDialog(context);
                              if (link != null) {
                                // Customize your message
                                String message =
                                    "Please find the review of video.\n\n"
                                    "Click on the link below to access the feedback along with the annotated screens.\n\n"
                                    "$link\n\n"
                                    "Reviewed using BugSmash: The fastest app to mark & share issues and feedback !";

                                // Share the message
                                Share.share(message);
                              }
                            });
                            // showModalBottomSheet(
                            //   isDismissible: true,
                            //   shape: RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.only(
                            //     topLeft: Radius.circular(20),
                            //     topRight: Radius.circular(20),
                            //   )),
                            //   context: context,
                            //   builder: (context) => SharedBottomSheet(
                            //     projectId: widget.projectID!,
                            //   ),
                            // );
                            // Handle edit action
                          } else if (value == 'delete') {
                            // Handle delete action
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title:
                                    Text("Are you sure you want to delete ?"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("No"),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      await fireStoreService.deleteProject(
                                          context,
                                          widget.projectID!,
                                          widget.videoPath!);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeView()));
                                    },
                                    child: Text("Yes"),
                                  )
                                ],
                              ),
                            );
                          }
                        } else {
                          // Display a message or perform any other action if owner is not verified
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text("Permission Denied"),
                              content: Text(
                                  "You do not have permission to perform this action."),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("OK"),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: 'edit',
                          child: Text('Share'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'delete',
                          child: Text('Delete'),
                        ),
                      ],
                    ),

                    // Adjust the width to your requirement
                  ],
                ),
              ),
            ),
          ),
          //  SizedBox(height: 40),
          Container(
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.sizeOf(context).height * 0.589,

                  //height: 493,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(15, 18, 27, 1),
                  ),
                  child: FutureBuilder(
                    future: initializeVideoPlayer,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return AspectRatio(
                          aspectRatio: 16 / 9,
                          child: GestureDetector(
                            onTapDown: (TapDownDetails details) async {
                              Duration currentPosition =
                                  _controller.value.position;
                              _controller.pause();
                              int timeStamp = currentPosition.inMilliseconds;
                              setState(() {
                                isVideoPlaying = false;
                              });
                              print("this is Current Time :$currentPosition");
                              int seconds = currentPosition.inSeconds;
                              print(
                                  "this are the seconds yo tapped : $seconds");

                              print(
                                  'Details global posiiton :${details.globalPosition}');

                              // showDialog(
                              //     context: context,
                              //     builder: (BuildContext context) {
                              //       _textController.clear();
                              //       return AlertDialog(
                              //           title: Text(
                              //             "Review",
                              //             style: TextStyle(
                              //               fontSize: 20,
                              //               fontWeight: FontWeight.w700,
                              //             ),
                              //           ),
                              //           content: TextField(
                              //             controller: _textController,
                              //             decoration: InputDecoration(
                              //                 border: OutlineInputBorder()),
                              //           ),
                              //           actions: [
                              //             TextButton(
                              //               onPressed: () async {
                              //                 Navigator.of(context).pop();

                              //                 // await _controller.play();
                              //               },
                              //               child: Text(
                              //                 'Cancel',
                              //                 style: TextStyle(
                              //                     color: const Color.fromARGB(
                              //                         255, 166, 162, 162),
                              //                     fontSize: 18,
                              //                     fontWeight: FontWeight.w400),
                              //               ),
                              //             ),
                              //             Container(
                              //               height: MediaQuery.of(context)
                              //                       .size
                              //                       .height /
                              //                   22,
                              //               decoration: BoxDecoration(
                              //                 color: Colors.purple,
                              //                 borderRadius:
                              //                     BorderRadius.circular(100),
                              //               ),
                              //               child: TextButton(
                              //                 onPressed: () async {
                              //                   Navigator.of(context).pop();
                              //                   String currentReview =
                              //                       _textController.text;
                              //                   // ReviewModel model = ReviewModel(
                              //                   //   position:
                              //                   //       details.globalPosition,
                              //                   //   time: currentPosition,
                              //                   //   review: currentReview,
                              //                   //   order: reviewList.length + 1,
                              //                   // );
                              //                   setState(() {
                              //                     //  reviewList.add(model);
                              //                     // _addMarker(currentPosition,
                              //                     //     details.globalPosition);
                              //                     // Marker lastMarker =
                              //                     //     markers.last;
                              //                     // lastMarker.isVisible = true;
                              //                   });
                              //                 },
                              //                 child: Text(
                              //                   'Done',
                              //                   style: TextStyle(
                              //                     color: Colors.white,
                              //                     fontSize: 14,
                              //                     fontWeight: FontWeight.w400,
                              //                   ),
                              //                 ),
                              //               ),
                              //             ),
//                                        ]);
                              //                                });
                            },
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: SizedBox(
                                width: _controller.value.size.width,
                                height: _controller.value.size.height,
                                child: VideoPlayer(_controller),
                              ),
                            ),
                          ),
                        );
                      } else if (_controller.value.isBuffering) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
                for (var marker in markers)
                  if (marker.isVisible)
                    Positioned(
                      left: deviceWidth /
                              (projectDeviceWidth ?? 0) *
                              marker.positionOffset.dx -
                          (deviceWidth / 20.5),
                      //left: marker.positionOffset.dx - 14,
                      top: deviceHeight /
                              (projectDeviceHeight ?? 0) *
                              marker.positionOffset.dy -
                          (deviceHeight / 5.53),
                      child: Container(
                        height:
                            deviceWidth / 8, // Adjust the fraction as needed
                        width: deviceWidth / 8,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(208, 98, 98, 1),
                          //  border: Border.all(width: 2, color: Colors.white),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '${marker.index}',
                            style: GoogleFonts.openSans(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
              ],
            ),
          ),
          Stack(children: [
            Positioned(
              child: Container(
                padding: EdgeInsets.zero,

                color: Color.fromRGBO(15, 18, 27, 1),
                //  color: Colors.white,
                height: 35,
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6.0),
                    thumbColor: Color.fromRGBO(124, 184, 240, 1),
                    trackHeight: 2,
                    activeTrackColor: Color.fromRGBO(124, 184, 240, 1),
                    inactiveTrackColor: Color.fromRGBO(124, 184, 240, 0.4),
                    overlayShape: SliderComponentShape.noOverlay,
                  ),
                  child: Slider(
                    value: _currentPosition.inSeconds.toDouble(),
                    min: 0.0,
                    max: _controller.value.duration.inSeconds.toDouble(),
                    onChanged: (value) {
                      setState(() {
                        _currentSliderValue = value;
                      });
                    },
                    onChangeEnd: (value) {
                      _controller.seekTo(Duration(seconds: value.toInt()));
                    },
                  ),
                ),
              ),
            ),
            Positioned(
              left: 8,
              bottom: 1,
              child: Text(
                '${formatDuration(_currentPosition)} / ${formatDuration(_controller.value.duration)}',
                style: GoogleFonts.openSans(
                  fontSize: 7,
                  fontWeight: FontWeight.w300,
                  color: Color.fromRGBO(255, 255, 255, 1),
                ),
              ),
            ),
          ]),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.024),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Container(
              height: MediaQuery.sizeOf(context).height * 0.18,
              //   height: 100,
              decoration: BoxDecoration(
                color: Color.fromRGBO(15, 18, 27, 1),
                border: Border.all(width: 1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 26, bottom: 26),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await showModalBottomSheet(
                          isDismissible: true,
                          //     isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          context: context,
                          builder: (context) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              child: ProjectBottomSheet(
                                //  isarInsatance: widget.isar,
                                projectId: widget.projectID,
                                controller: _controller,
                              ),
                            );
                          },
                        );
                      },
                      child: SvgPicture.asset('assets/icon/chat.svg'),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isVideoPlaying) {
                            _controller.pause();
                          } else {
                            _controller.play();
                          }
                          isVideoPlaying = !isVideoPlaying;
                        });
                      },
                      child: SvgPicture.asset(
                        _controller.value.isPlaying
                            ? 'assets/icon/motion_photos_paused.svg'
                            : 'assets/icon/sound_sampler.svg',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _controller.seekTo(Duration.zero);
                        _controller.pause();
                        setState(() {
                          isVideoPlaying = false;
                        });
                      },
                      child: SvgPicture.asset('assets/icon/stop_circle.svg'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _setProject() async {}
}

class Marker {
  final int index;
  final Duration position;
  final Offset positionOffset;
  bool isVisible;

  Marker({
    required this.index,
    required this.position,
    required this.positionOffset,
    required this.isVisible,
  });
}
//  FloatingActionButton(
//           onPressed: () {
//             setState(() {
//               if (_controller.value.isPlaying) {
//                 _controller.pause();
//               } else {
//                 _controller.play();
//               }
//             });
//           },
//           child: Icon(
//             _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
//           ),
//         ),
//         // FloatingActionButton(onPressed: () {
//   setState(() {
//     markers.clear();
//   });
// }),
//    Expanded(
//   child: DraggableScrollableSheet(
//     initialChildSize: 0.5,
//     minChildSize: 0.1,
//     maxChildSize: 0.6,
//     builder:
//         (BuildContext context, ScrollController scrollController) {
//       return BottomSheetWidget(
//           reviewLists: reviewList, controller: _controller);
//     },
//   ),
// ),
