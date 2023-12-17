import 'dart:typed_data';

import 'package:Video_Review/collection/project_collection.dart';
import 'package:Video_Review/services/auth_services.dart';
import 'package:Video_Review/services/firebase_dynamic_links.dart';
import 'package:Video_Review/services/firestore_service.dart';
import 'package:Video_Review/views/project_video.dart';
import 'package:Video_Review/views/video_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:io';

import 'package:video_thumbnail/video_thumbnail.dart';

class HomeView extends StatefulWidget {
  // final Isar isar;
  String? activeUser;

  HomeView({
    Key? key,
    this.activeUser,
    // required this.isar,
  }) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String? currentAppUser;
  String? currentEmail;
  String? titleP;
  String? videoPP;
  final FireStoreService fireStoreService = FireStoreService();
  String? projectId;
  List<ProjectColleciton>? projectsList;
  final ImagePicker picker = ImagePicker();
  late XFile? galleryVideo;
  String? linkFetched;
  String? projectIdFetchedFromLink;
  @override
  void initState() {
    super.initState();

    getCurrentUser();
    initDynamicLink();

    // _initDynamicLinks();
    // _readProjects();
  }

  Future<void> initDynamicLink() async {
    final PendingDynamicLinkData? initialLink =
        await FirebaseDynamicLinks.instance.getInitialLink();

    if (initialLink != null) {
      final Uri deepLink = initialLink.link;

      final String path = deepLink.path;
      print("Initial Link: $deepLink");

      final queryParameters = deepLink.queryParameters;
      if (queryParameters.isNotEmpty) {
        String? projectIDExt = queryParameters['projectID'];
        setState(() {
          projectIdFetchedFromLink = projectIDExt;
          fireStoreService.addSharedEmail(projectIDExt!, currentEmail!);
        });
        print("Extracted project Id is:$projectIDExt");
      } else {
        print(" Cant Extract ");
      }
      setState(() {
        linkFetched = deepLink.toString();
      });

      // DynamicLinkService().initDynamicLink(deepLink);
    }
  }

  Future<String> _saveVideo(XFile videoFile) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final videoDirPath = '$path/videosDemo';

    final videoDir = Directory(videoDirPath);
    if (!videoDir.existsSync()) {
      videoDir.createSync(recursive: true);
    }
    final newVideoFilePath = '$videoDirPath/${videoFile.path.split('/').last}';

    await videoFile.saveTo(newVideoFilePath);

    return newVideoFilePath;
  }

  // _addProject(String? videoPath) async {
  //   final projectCollection = widget.isar.projectCollecitons;
  //   final newProject = ProjectColleciton()..videopath = videoPath;
  //   final newprojectId = await widget.isar.writeTxn(() async {
  //     return await projectCollection.put(newProject);
  //   });

  //   setState(() {
  //     projectId = newprojectId;
  //   });
  //   print('Project ID: $projectId');
  // }
  Future<void> _addProject() async {
    DocumentReference projectRef = await fireStoreService.addProjects(
        projectId, titleP, videoPP, currentEmail);

    setState(() {
      projectId = projectRef.id;
    });

    print("The document ID is: $projectId");
  }

  getCurrentUser() async {
    final userIdRef = await AuthMethods().getCurrentUser();
    final currentUser = userIdRef.uid;
    final currentUserEmail = userIdRef.email;
    print("The user info is :$userIdRef");
    print("The mail id of current user is :$currentUserEmail");

    setState(() {
      currentAppUser = currentUser;
      currentEmail = currentUserEmail;
      print("The current user id is:$currentAppUser");
    });
    checKowner();
  } // Your Timestamp instance

  checKowner() {
    final activeUser = currentEmail;
    setState(() {
      widget.activeUser = activeUser;
    });
    print("the current app user for checking owner i s:${widget.activeUser}");
  }

  Widget _buildThumbnailWidget(String videoPath) {
    return FutureBuilder<Uint8List>(
      future: _generateThumbnail(videoPath),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              //width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: MemoryImage(snapshot.data!),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          ); // You can return a placeholder here while the thumbnail is being generated.
        }
      },
    );
  }

  Future<Uint8List> _generateThumbnail(String videoPath) async {
    final thumbnail = await VideoThumbnail.thumbnailData(
      video: videoPath,
      imageFormat: ImageFormat.PNG,
      maxWidth: 128,
      quality: 100,
    );
    return thumbnail!;
  }

  String _formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return DateFormat.MMMd().format(dateTime);
  }

  // void createDynamicLink() async {
  //   DynamicLinkService.instance.createDynamicLink();
  // }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 251),
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
                      "My Videos",
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
                          "Click on any of the video to review and drop feedback pins. ",
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
                        print("Th error fr snapshot is : $Error");
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        return GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 20,
                                  crossAxisSpacing: 23,
                                  crossAxisCount: 2,
                                  mainAxisExtent: 168
                                  //childAspectRatio: 150 / 178,
                                  ),
                          itemCount:
                              (snapshot.data?.docs.reversed.length ?? 0) + 1,
                          itemBuilder: (context, index) {
                            if (index <
                                (snapshot.data?.docs.reversed.length ?? 0)) {
                              final obj = snapshot.data?.docs[index];
                              final title = obj?['title'];
                              final videopath = obj?['videoPath'];

                              final projectID = obj?.id;
                              final date = obj?['date'];
                              final formattedDate = _formatTimestamp(date);
                              print(" the Date is  === = == :$date");
                              final thumbnail =
                                  _buildThumbnailWidget(videopath.toString());
                              //it was videopath!

                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProjectVideo(
                                        projectTitle: title,
                                        projectID: projectID,
                                        activeUser: widget.activeUser,
                                        // isar: widget.isar,
                                        videoPath: videopath,
                                      ),
                                    ),
                                  );
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
                                          child: thumbnail,
                                        ),
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
                                            "Last Reviewed: $formattedDate",
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
                                  galleryVideo = await picker.pickVideo(
                                      source: ImageSource.gallery);
                                  if (galleryVideo != null) {
                                    final newPath =
                                        await _saveVideo(galleryVideo!);
                                    await _addProject();
                                    print("projject id : $newPath");
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (builder) => VideoView(
                                          //addProject: _addProject(newPath),
                                          projectID: projectId,
                                          videoPath: newPath,

                                          //addProject: _addProject(newPath),
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            16, 16, 0, 39),
                                        child: Icon(
                                          Icons.add_circle,
                                          size: 40,
                                          color:
                                              Color.fromRGBO(255, 255, 255, 1),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            16, 0, 0, 0),
                                        child: Text(
                                          "Select New",
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
                                            "to start reviewing",
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
                    )),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // _readProjects() async {
  //   widget.isar.projectCollecitons
  //       .where()
  //       .watch(fireImmediately: true)
  //       .listen((projects) {
  //     setState(() {
  //       projectsList = projects;
  //     });
  //   });
  // }
}
