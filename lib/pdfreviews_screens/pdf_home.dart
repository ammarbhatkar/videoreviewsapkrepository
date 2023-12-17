// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:Video_Review/pdfreviews_screens/pdf_services/firestore_service.dart';
import 'package:Video_Review/pdfreviews_screens/pdf_viewer.dart';
import 'package:Video_Review/pdfreviews_screens/screens_from_firebase/fetched_pdf.dart';
import 'package:Video_Review/services/auth_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:intl/intl.dart';

class PdfHomeView extends StatefulWidget {
  const PdfHomeView({super.key});

  @override
  State<PdfHomeView> createState() => _PdfHomeViewState();
}

class _PdfHomeViewState extends State<PdfHomeView> {
  final PdfFireStoreService fireStoreService = PdfFireStoreService();
  String? currentAppUser;
  String? currentEmail;
  List projectList = [];
  String? projectId;
  String? titleP;
  String? imageUrl;
  String? email;

  String? linkFetched;
  String? projectIdFetchedFromLink;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    initDynamicLink();
  }

  Future<void> initDynamicLink() async {
    final PendingDynamicLinkData? initialLink =
        await FirebaseDynamicLinks.instance.getInitialLink();

    if (initialLink != null) {
      final Uri deepLink = initialLink.link;

//      final String path = deepLink.path;

      final queryParameters = deepLink.queryParameters;
      if (queryParameters.isNotEmpty) {
        String? projectIDExt = queryParameters['projectID'];
        setState(() {
          projectIdFetchedFromLink = projectIDExt;
          fireStoreService.addSharedEmail(projectIDExt!, currentEmail!);
        });
      } else {}
      setState(() {
        linkFetched = deepLink.toString();
      });

      // DynamicLinkService().initDynamicLink(deepLink);
    }
  }

  String _formatTimestamp(Timestamp timestamp) {
    DateTime time = timestamp.toDate();
    return DateFormat.MMMd().format(time);
  }

  Future<void> _addPdfProject() async {
    DocumentReference projectRef = await fireStoreService.addPdfProjects(
        projectId, titleP, imageUrl, currentEmail);
    setState(() {
      projectId = projectRef.id;
    });
  }

  getCurrentUser() async {
    final userIdRef = await AuthMethods().getCurrentUser();
    final currentUser = userIdRef.uid;
    final currentUserEmail = userIdRef.email;

    setState(() {
      currentAppUser = currentUser;
      currentEmail = currentUserEmail;
    });
  } // You

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(right: 24, top: 70, bottom: 24.5),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Image.asset(
                    'assets/images/background.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/icon/appstore.png",
                      height: 50,
                      width: 50,
                    ),
                    SizedBox(height: 19),
                    Text(
                      "My PDF'S",
                      style: GoogleFonts.openSans(
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      width: 300,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 23, 0),
                        child: Text(
                          "Click on any of the pdf to review and drop feedback pins. ",
                          style: GoogleFonts.openSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(0, 0, 0, 0.6),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: fireStoreService
                            .getProjectsForUser(currentEmail ?? ""),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text("Error: ${snapshot.error}"),
                            );
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 23,
                              crossAxisCount: 2,
                              mainAxisExtent: 168,
                            ),
                            itemCount:
                                (snapshot.data?.docs.reversed.length ?? 0) + 1,
                            itemBuilder: (context, index) {
                              if (index <
                                  (snapshot.data?.docs.reversed.length ?? 0)) {
                                final obj = snapshot.data?.docs[index];
                                final title = obj?["title"];
                                final imageUri = obj?["imageUrl"];
                                final projectId = obj?['projectId'];
                                final currentUserEmailF = obj?['userEmail'];
                                final dynamicLink = obj?['dynamicLink'];
                                final ownerDeviceWidth =
                                    obj?['currentDeviceWidth'];

                                final ownerDeviceHeight =
                                    obj?['currentDeviceHeight'];
                                final createdDate = obj?['createdOn'];
                                final createdOn = _formatTimestamp(createdDate);

                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => FetchedPdf(
                                                  dynamicLink: dynamicLink,
                                                  projectId: projectId,
                                                  currentUserEmail:
                                                      currentUserEmailF,
                                                  imageUrl: imageUri,
                                                  title: title,
                                                  ownerDeviceHeight:
                                                      ownerDeviceHeight,
                                                  ownerDeviceWidth:
                                                      ownerDeviceWidth,
                                                )));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 255, 255, 251),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        width: 1,
                                        color: Color.fromRGBO(126, 100, 237, 1),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 79,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),

                                              //color: Colors.black,
                                            ),
                                          ),
                                          // child: buildThumbnail(imageUri)),
                                          SizedBox(height: 14),
                                          Expanded(
                                            child: Text(
                                              title ?? "",
                                              style: GoogleFonts.openSans(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w800,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          SizedBox(height: 2),
                                          Expanded(
                                            child: Text(
                                              "Last Reviewed: $createdOn",
                                              style: GoogleFonts.openSans(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return GestureDetector(
                                  onTap: () async {
                                    final result = await FilePicker.platform
                                        .pickFiles(
                                            type: FileType.custom,
                                            allowedExtensions: ['pdf']);
                                    if (result != null) {
                                      //  await _addPdfProject();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PdfViewer(
                                            currentEmail: currentEmail,
                                            pdf: result.paths[0]!,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  child: Container(
                                    height: 168,
                                    width: 170,
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(126, 100, 237, 1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              16, 16, 0, 30),
                                          child: Icon(
                                            Icons.add_circle,
                                            size: 40,
                                            color: Color.fromRGBO(
                                                255, 255, 255, 1),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              16, 0, 0, 0),
                                          child: Text(
                                            "PDF Review",
                                            style: GoogleFonts.openSans(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w800,
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 1),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                16, 0, 0, 16),
                                            child: Text(
                                              "Select PDF file to review",
                                              style: GoogleFonts.openSans(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 0.6),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                            },
                          );
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
