import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomSheetContainer extends StatefulWidget {
  final List<ReviewModel> reviewLists;
  const BottomSheetContainer({super.key, required this.reviewLists});

  @override
  State<BottomSheetContainer> createState() => _BottomSheetContainerState();
}

class _BottomSheetContainerState extends State<BottomSheetContainer> {
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
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: widget.reviewLists.length,
              itemBuilder: (context, index) {
                final obj = widget.reviewLists[index];
                final review = obj.review;
                final order = obj.order;
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
                                color: Color.fromRGBO(208, 98, 98, 1),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Text(
                                      review,
                                      style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Color.fromRGBO(0, 0, 0, 0.6)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 20, 0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Color.fromRGBO(
                                                109, 197, 144, 1),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8, 4, 8, 4),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 4),
                                                  child: Icon(
                                                    Icons.edit,
                                                    size: 8,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  "Mark as Resolved",
                                                  style: GoogleFonts.openSans(
                                                    fontSize: 8,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
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
                  ],
                );
              },
            ),
          )
        ]);
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
