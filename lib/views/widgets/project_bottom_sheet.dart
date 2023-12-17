// ignore_for_file: avoid_print, prefer_const_constructors

import 'package:Video_Review/collection/marker_collection.dart';
import 'package:Video_Review/services/firestore_service.dart';
import 'package:Video_Review/utilities/diaogs/generic_dialog.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:isar/isar.dart';
import 'package:video_player/video_player.dart';

class ProjectBottomSheet extends StatefulWidget {
  // final Isar isarInsatance;
  final VideoPlayerController controller;
  final String? projectId;
  ProjectBottomSheet({
    Key? key,
    required this.controller,
    //  required this.isarInsatance,
    this.projectId,
  }) : super(key: key) {
    //print('Project ID in ProjectBottomSheet: $projectId');
  }

  @override
  _ProjectBottomSheetState createState() => _ProjectBottomSheetState();
}

class _ProjectBottomSheetState extends State<ProjectBottomSheet> {
  bool? isResolvedWidget = false;
  final FireStoreService fireStoreService = FireStoreService();
  TextEditingController _editText = TextEditingController();
  List<MarkerCollection>? markersList;

  Duration durationFromTimestamp(int timestamp) {
    return Duration(milliseconds: timestamp);
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));

    return "$minutes:$seconds";
  }

  _readMarkersfromFirStore() async {}
  // _editReviewIsar() async {
  //   final markerCollection = widget.isarInsatance.markerCollections;
  //   await widget.isarInsatance.writeTxn(() async {
  //     final marker = await markerCollection.get(widget.projectId!);

  //     marker!..feedback = _editText.text;
  //     await markerCollection.put(marker);

  //     _readMarker();
  //     if (context.mounted) {
  //       Navigator.of(context).pop();
  //     }
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // print("The bottom SHeet project id :${widget.projectId}");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 14),
        Center(
          child: Divider(
            thickness: 2,
            color: Colors.black,
            indent: 110, // Adjust as needed
            endIndent: 110,
          ),
        ),
        SizedBox(height: 17),
        Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 27),
          child: Text(
            "Feedback List",
            style: GoogleFonts.openSans(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Expanded(
          child: StreamBuilder(
              stream: fireStoreService.getmarkersForProjects(widget.projectId!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  //  print('Connection State: ${snapshot.connectionState}');
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  //print('Error: ${snapshot.error}');
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.data == null) {
                  return Text('No data available');
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final obj = snapshot.data!.docs[index];
                      final review = obj['feedback'] ?? "";
                      final position = obj['order'] ?? 0;
                      final timeStamp = obj['timeStamp'] ?? 0;
                      var isResolved = obj['isResolved'] ?? "";
                      // print("TImesStamp for ppart markers:$timeStamp");
                      // print("Review: $review");
                      // print("the snapshot data is :${snapshot.data}");
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              // Show the loader
                              GenericDialog.showLoadingDialog(context, "",
                                  backgroundColor: Colors.transparent);

                              // Set up a listener to check buffering and seek completion
                              bool buffering = false;
                              bool seekCompleted = false;

                              void listener() {
                                if (widget.controller.value.isBuffering) {
                                  buffering = true;
                                  //   print("Buffering...");
                                } else if (buffering &&
                                    !widget.controller.value.isBuffering) {
                                  // Buffering is complete
                                  buffering = false;
                                  seekCompleted = true;
                                  // print("Buffering complete.");
                                }

                                if (seekCompleted) {
                                  // Do actions after seek completion
                                  widget.controller.removeListener(listener);
                                  GenericDialog.hideDialog(context);
                                  widget.controller.pause();
                                  Navigator.of(context)
                                      .pop(); // Close the bottom sheet
                                  // print(
                                  //     "Seek complete. Button tap time: $timeStamp");
                                }
                              }

                              // Start listening for changes in the video player's state
                              widget.controller.addListener(listener);

                              // Seek to the timestamp
                              await widget.controller
                                  .seekTo(durationFromTimestamp(timeStamp));

                              // Note: The listener will handle actions after seek completion
                            },
                            // onDoubleTap: () async {
                            //   final reviewText = obj
                            //       ?.feedback; // Fetch the review text from the MarkerCollection object
                            //   _editText.text = reviewText ??
                            //       ''; // Set the review text in the TextEditingController
                            //   await showDialog(
                            //       context: context,
                            //       builder: (context) => AlertDialog(
                            //             title: Text("Review"),
                            //             content: TextField(
                            //               controller: _editText,
                            //             ),
                            //             actions: [
                            //               TextButton(
                            //                   onPressed: () async {
                            //                     await _editReviewIsar();
                            //                   },
                            //                   child: Text("Save")),
                            //             ],
                            //           ));
                            // },
                            child: Container(
                              color: Colors.transparent,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, bottom: 26),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 14, 0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: isResolved == false
                                              ? Color.fromRGBO(208, 98, 98, 1)
                                              : Color.fromRGBO(
                                                  109, 197, 144, 1),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              18, 9, 18, 8),
                                          child: Text(
                                            position.toString(),
                                            style: GoogleFonts.openSans(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 0, 20, 0),
                                              child: GestureDetector(
                                                onDoubleTap: () async {
                                                  final TextEditingController
                                                      _editTextController =
                                                      TextEditingController(
                                                          text: review);

                                                  await showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        AlertDialog(
                                                      title:
                                                          Text("Edit Review"),
                                                      content: TextField(
                                                        controller:
                                                            _editTextController,
                                                      ),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () async {
                                                            // Update the Firestore document with the edited review
                                                            await fireStoreService
                                                                .markerCollection
                                                                .doc(obj.id)
                                                                .update({
                                                              'feedback':
                                                                  _editTextController
                                                                      .text,
                                                            });

                                                            // Close the dialog
                                                            Navigator.of(
                                                                    context)
                                                                .pop();

                                                            // Update the UI if needed
                                                            setState(() {
                                                              // Update any relevant state variables or UI elements
                                                            });
                                                          },
                                                          child: Text("Save"),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                                child: Text(
                                                  review.toString(),
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color.fromRGBO(
                                                        0, 0, 0, 0.6),
                                                  ),
                                                ),
                                              ),
                                            ),

                                            // /  Text("time:"),
                                            SizedBox(
                                              height: 8,
                                            ),

                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      width: 1,
                                                      color: Color.fromRGBO(
                                                          126, 100, 237, 1),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(16, 4, 16, 4),
                                                    child: Text(
                                                      formatTime(
                                                        durationFromTimestamp(
                                                          obj['timeStamp'] ?? 0,
                                                        ),
                                                      ),
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize: 8,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Color.fromRGBO(
                                                            126, 100, 237, 1),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () async {
                                                    setState(() {
                                                      isResolvedWidget =
                                                          !isResolvedWidget!;

                                                      // print(
                                                      //     "vlaue of isresolve di s:$isResolvedWidget");
                                                    });
                                                    await _updateMarkerStatus(
                                                        obj.id);
                                                    // setState(() {});
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 0, 20, 0),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: isResolved ==
                                                                false
                                                            ? Color.fromRGBO(
                                                                109,
                                                                197,
                                                                144,
                                                                1)
                                                            : Color.fromRGBO(
                                                                208, 98, 98, 1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                8, 4, 8, 4),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      right: 4),
                                                              child: Icon(
                                                                Icons.edit,
                                                                size: 8,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            Text(
                                                              isResolved == true
                                                                  ? "Mark as Unresolved"
                                                                  : "Mark as resolved",
                                                              style: GoogleFonts
                                                                  .openSans(
                                                                fontSize: 8,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
              }),
        )
      ],
    );
  }

  _updateMarkerStatus(String markerId) async {
    await fireStoreService.markerCollection.doc(markerId).update({
      'isResolved': isResolvedWidget,
    });
  }
}

class ReviewModel {
  final Offset position;
  final Duration time;
  final String review;
  final int order;

  ReviewModel({
    required this.position,
    required this.time,
    required this.review,
    required this.order,
  });
}
