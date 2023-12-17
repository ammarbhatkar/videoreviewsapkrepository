// ignore_for_file: prefer_const_constructors

import 'package:Video_Review/pdfreviews_screens/pdf_services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PdfBottomSheet extends StatefulWidget {
  final String projectId;
  const PdfBottomSheet({
    super.key,
    required this.projectId,
  });

  @override
  State<PdfBottomSheet> createState() => _PdfBottomSheetState();
}

class _PdfBottomSheetState extends State<PdfBottomSheet> {
  bool isResolvedStatus = false;
  final PdfFireStoreService fireStoreService = PdfFireStoreService();
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
            padding: const EdgeInsets.only(left: 0, bottom: 27),
            child: Center(
              child: Text(
                "Feedback List",
                style: GoogleFonts.openSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: fireStoreService.getmarkersForProjects(widget.projectId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                return ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final obj = snapshot.data!.docs[index];

                    final review = obj['feedback'] ?? "";
                    final order = obj['order'] ?? 0;
                    var isResolved = obj['isResolved'];

                    print("the review is :$review");
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 14, 0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: isResolved == false
                                        ? Color.fromRGBO(208, 98, 98, 1)
                                        : Color.fromRGBO(109, 197, 144, 1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(18, 9, 18, 8),
                                    child: Text(
                                      order.toString(),
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
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: Text(
                                          review,
                                          style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.6)),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              setState(() {
                                                isResolvedStatus =
                                                    !isResolvedStatus;
                                                print(
                                                    "statsis is $isResolvedStatus");
                                              });
                                              await _updateMarkerStatus(obj.id);
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 0, 20, 0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: isResolved == false
                                                      ? Color.fromRGBO(
                                                          208, 98, 98, 1)
                                                      : Color.fromRGBO(
                                                          109, 197, 144, 1),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
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
                                                                .only(right: 4),
                                                        child: Icon(
                                                          Icons.edit,
                                                          size: 8,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      Text(
                                                        isResolved == false
                                                            ? "Mark as Resolved"
                                                            : "Mark as Unresolved",
                                                        style: GoogleFonts
                                                            .openSans(
                                                          fontSize: 8,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    );
                  },
                );
              },
            ),
          )
        ]);
  }

  _updateMarkerStatus(String markerId) async {
    await fireStoreService.markerCollection.doc(markerId).update({
      'isResolved': isResolvedStatus,
    });
  }
}

class ReviewModel {
  final Offset position;

  final String review;
  final int order;

  ReviewModel({
    required this.position,
    required this.review,
    required this.order,
  });
}
