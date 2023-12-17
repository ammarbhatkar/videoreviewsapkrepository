// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, must_be_immutable, avoid_print

import 'package:Video_Review/pdfreviews_screens/pdf_home.dart';

import 'package:Video_Review/pdfreviews_screens/pdf_services/firestore_service.dart';
import 'package:Video_Review/pdfreviews_screens/screens_from_firebase/fetched_pdf_bottom_sheet.dart';
import 'package:Video_Review/services/firebase_dynamic_links.dart';
import 'package:Video_Review/utilities/diaogs/generic_dialog.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

class FetchedPdf extends StatefulWidget {
  // final Uint8List currentPageImage;
  final String imageUrl;
  String? projectId;
  String? currentUserEmail;
  String? title;
  double? ownerDeviceWidth;

  double? ownerDeviceHeight;
  String? dynamicLink;
  FetchedPdf({
    Key? key,
    this.ownerDeviceHeight,
    this.ownerDeviceWidth,
    // required this.currentPageImage,
    this.projectId,
    this.currentUserEmail,
    this.title,
    this.dynamicLink,
    required this.imageUrl,
  }) : super(key: key);

  @override
  State<FetchedPdf> createState() => _FetchedPdfState();
}

class _FetchedPdfState extends State<FetchedPdf> {
  double? imagePositiondx;
  double? imagePositiondy;
  final GlobalKey imageKey = GlobalKey();
  double? projectDeviceWidth;
  String? dynamicLink;
  double? projectDeviceHeight;
  bool isLoading = false;
  double? fetchedImageHeight;
  double? fetchedImageWidth;
  final PdfFireStoreService fireStoreService = PdfFireStoreService();
  bool isImageLoaded = false;
  double? fetchedContainerHeight;
  double? fetchedContainerWidth;
  late final TextEditingController _textController;

  List<Marker> markers = [];

  @override
  void initState() {
    super.initState();
    // print("the dynamic link coming is :${widget.dynamicLink}");
    _textController = TextEditingController();
    // print(widget.projectId);
    // print("the fethed width :${widget.ownerDeviceWidth}");

    //  print("the fethed height :${widget.ownerDeviceHeight}");
    _fetchMarkers();
    fetchDimensionsForProject();
    // ...

    WidgetsBinding.instance.addPostFrameCallback((_) {
      RenderBox renderBox =
          imageKey.currentContext!.findRenderObject() as RenderBox;
      Offset position = renderBox.localToGlobal(Offset.zero);
      setState(() {
        imagePositiondx = position.dx;
        imagePositiondy = position.dy;
        print("image positionx : $imagePositiondx");
        print("image positionY : $imagePositiondy");
      });

      print("Image position: $position");
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    // _readMarkers();

    super.dispose();
  }

  _fetchMarkers() async {
    fireStoreService
        .getmarkersForProjects(widget.projectId ?? "")
        .listen((snapshot) {
      setState(() {
        markers = snapshot.docs.map((doc) {
          return Marker(
            index: doc['order'] ?? 0,
            //positionOffset: Offset(doc['dx'] ?? 0.0, doc['dy'] ?? 0.0),
            positonDx: doc['dxInpixel'],
            positionDY: doc['dyInpixel'],
            isVisible: true,
          );
        }).toList();
      });
    });
  }

  fetchDimensionsForProject() {
    fireStoreService.getProjects(widget.projectId ?? "").listen((snapshot) {
      setState(() {
        if (snapshot.docs.isNotEmpty) {
          final projectData =
              snapshot.docs.first.data() as Map<String, dynamic>?;
          projectDeviceWidth = projectData?['currentDeviceWidth'] ?? 0.0;
          projectDeviceHeight = projectData?['currentDeviceHeight'] ?? 0.0;
          fetchedContainerHeight = projectData?['containerHeight'] ?? 0;

          fetchedContainerWidth = projectData?['containerWidth'] ?? 0;
          print("fetched container heigt i s:$fetchedContainerHeight");

          print("fetched container width s:$fetchedContainerWidth");
          print("Fetched project width: $projectDeviceWidth");
          print("Fetched project height: $projectDeviceHeight");
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    print("the device width is :$deviceWidth");
    double deviceHeight = MediaQuery.of(context).size.height;
    print("the device height is : $deviceHeight");

    double containerHeight = MediaQuery.of(context).size.height * 0.6;
    print("the container height is : $containerHeight");
    double containerWidth = MediaQuery.of(context).size.width;
    print("the container  is : $containerWidth");
    // double imageHeight = containerHeight;
    // print("the image height is :$imageHeight");
    // double imageWidth = containerWidth;
    // print("the image width is :$imageWidth");
    double imageWidth = MediaQuery.of(context).size.width * 0.8;
    double imageHeight = MediaQuery.of(context).size.height * 0.5;

    print(" the calculated width of image is :$imageWidth");
    print("the calculated height of image is : $imageHeight");
    print("the calculated width is = ${deviceWidth * 0.07}");

    print("the calculated height is = ${deviceWidth * 0.07}");

    double markerWidth = imageWidth * 0.1;

    double markerHeight = imageHeight * 0.1;

    // print("this is moin bhai height :$imageHeight");
    // print("this is moin height :$imageWidth");
    double dynamicSize = deviceWidth * 0.1;

    // deviceWidth / (projectDeviceWidth ?? 0) * 30
    double offsetX = containerWidth * 0.005; // 0.5% of the screen width
    double offsetY = containerHeight * 0.005;
    double markerSizeRatio =
        0.07; // Adjust this value according to your preference

    double markerSize = containerWidth * 0.0625;
    print("the marker size is ${markerSize} this is new");

    double subtractingSize = markerSize * 0.5;
    print("the subtracting size is $subtractingSize");

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(33, 37, 50, 1),
      body: Container(
        child: Column(
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
                          padding: const EdgeInsets.only(
                              left: 18, top: 17, bottom: 18),
                          child: Text(
                            widget.title ?? "",
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
                          if (value == 'delete') {
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
                                          widget.projectId!,
                                          widget.imageUrl);

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PdfHomeView()));
                                    },
                                    child: Text("Yes"),
                                  )
                                ],
                              ),
                            );
                          } else if (value == 'share') {
                            if (widget.dynamicLink != null) {
                              // Use the existing dynamic link
                              String message =
                                  "Please find the review of video.\n\n"
                                  "Click on the link below to access the feedback along with the annotated screens.\n\n"
                                  "${widget.dynamicLink}\n\n"
                                  "Reviewed using BugSmash: The fastest app to mark & share issues and feedback !";

                              // Share the message
                              Share.share(message);
                            } else {
                              // Dynamic link is null, generate a new one
                              GenericDialog.showLoadingDialog(
                                  context, "Generating Link");

                              DynamicLinkService()
                                  .createDynamicLinkForProject(widget.projectId)
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
                                } else {
                                  // Handle the case where the dynamic link couldn't be generated
                                  // You can show an error message or take appropriate action
                                  print("Error generating dynamic link");
                                }
                              });
                            }
                          }
                        },
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<String>>[
                          const PopupMenuItem<String>(
                            value: 'share',
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.040),
            Container(
              child: Stack(
                children: [
                  Container(
                    height: containerHeight,
                    width: containerWidth,
                    //height: 493,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(15, 18, 27, 1),
                    ),

                    child: Image.network(
                      widget.imageUrl,
                      key: imageKey,
                      fit: BoxFit.contain,
                    ),
                  ),
                  for (var marker in markers)
                    if (marker.isVisible)
                      Positioned(
                        left: marker.positonDx *
                                containerWidth /
                                fetchedContainerWidth! -
                            subtractingSize,
                        top: marker.positionDY *
                                containerHeight /
                                fetchedContainerHeight! -
                            subtractingSize,
                        child: Container(
                          height: markerSize,
                          width: markerSize,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(208, 98, 98, 1),
                            //  border: Border.all(width: 2, color: Colors.white),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '${marker.index}',
                              style: GoogleFonts.openSans(
                                fontSize: 10,
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

            // ),

            SizedBox(height: MediaQuery.sizeOf(context).height * 0.040),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Container(
                  height: MediaQuery.sizeOf(context).height * 0.18,
                  //  height: MediaQuery.sizeOf(context).height * 0.170,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(15, 18, 27, 1),
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0, bottom: 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            //  final result =
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
                                    child: PdfBottomSheet(
                                        projectId: widget.projectId!));
                              },
                            );
                          },
                          child: SvgPicture.asset('assets/icon/chat.svg'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.040),
          ],
        ),
      ),
    );
  }
}

class Marker {
  final int index;
  // final Offset positionOffset;
  final double positonDx;
  final double positionDY;
  bool isVisible;
  Marker({
    required this.index,
    // required this.positionOffset,
    required this.positonDx,
    required this.positionDY,
    required this.isVisible,
  });
}
