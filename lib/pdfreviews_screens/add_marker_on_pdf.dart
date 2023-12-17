// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, must_be_immutable
// checking git
import 'dart:typed_data';

import 'package:Video_Review/pdfreviews_screens/bottom_sheet_container.dart';
import 'package:Video_Review/pdfreviews_screens/pdf_home.dart';
import 'package:Video_Review/pdfreviews_screens/pdf_services/firestore_service.dart';
import 'package:Video_Review/services/firebase_dynamic_links.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:uuid/uuid.dart';

class AddMarkerOnPdf extends StatefulWidget {
  final Uint8List currentPageImage;
  String? projectId;
  String? currentUserEmail;
  String? dynamicLink;
  AddMarkerOnPdf({
    Key? key,
    required this.currentPageImage,
    this.projectId,
    this.dynamicLink,
    this.currentUserEmail,
  }) : super(key: key);

  @override
  State<AddMarkerOnPdf> createState() => _AddMarkerOnPdfState();
}

class _AddMarkerOnPdfState extends State<AddMarkerOnPdf> {
  final GlobalKey imageKey = GlobalKey();
  double? imagePositiondx;
  double? imagePositiondy;
  bool isLoading = false;
  double? deviceWidth;
  double? deviceHeight;
  String? _downloadUrl;
  final PdfFireStoreService fireStoreService = PdfFireStoreService();
  DraggableScrollableController _scrollController =
      DraggableScrollableController();
  late final TextEditingController _textController;

  final TextEditingController _saveFileController = TextEditingController();

  List<Marker> markers = [];
  List<ReviewModel> reviewList = [];
// double dx, double dy
//Offset positionOffset
  _addMarker(double dx, double dy) {
    setState(() {
      markers.add(Marker(
        index: markers.length + 1,
        //     positionOffset: positionOffset,
        dx: dx,
        dy: dy,
        isVisible: false,
      ));
    });
  }

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    createDynamicLink();

    //  print(widget.projectId);

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      RenderBox renderBox =
          imageKey.currentContext!.findRenderObject() as RenderBox;
      Offset position = renderBox.globalToLocal(Offset.zero);
      setState(() {
        imagePositiondx = position.dx;
        imagePositiondy = position.dy;
        print("image positionx : $imagePositiondx");
        print("image positionY : $imagePositiondy");
      });

      //     print("Image position: $position");
    });
  }

  @override
  void didChangeDependencies() {
    _getDeviceDimensions();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _textController.dispose();
    // _readMarkers();

    super.dispose();
  }

  _getDeviceDimensions() {
    double currentDeviceWidth = MediaQuery.of(context).size.width;
    double currentDeviceHeight = MediaQuery.of(context).size.height;
    setState(() {
      deviceWidth = currentDeviceWidth;
      deviceHeight = currentDeviceHeight;
      // print("the current device width is : $deviceWidth");

      // print("the current device height is : $deviceHeight");
    });
  }

  void createDynamicLink() async {
    // print("starting Dl");
    // print(" the dl pi :${widget.projectId}");
    String dynamicLink = await DynamicLinkService()
        .createDynamicLinkForProject(widget.projectId!);
    // print("thecreated dyamic link is: $dynamicLink");
    setState(() {
      widget.dynamicLink = dynamicLink;
    });
    // print("the dynamic link created is :${widget.dynamicLink}");
  }

  _addProjectToFirestore() async {
    _downloadUrl =
        await fireStoreService.saveImageToFirebase(widget.currentPageImage);
    // print("the url of video uploaded is :$_downloadUrl");
    await fireStoreService.projectCollection.doc(widget.projectId).update({
      'title': _saveFileController.text,
      'imageUrl': _downloadUrl,
      'projectId': widget.projectId,
      'currentDeviceWidth': deviceWidth,
      'currentDeviceHeight': deviceHeight,
      'dynamicLink': widget.dynamicLink,
      'createdOn': FieldValue.serverTimestamp(),
    });
    setState(() {
      _saveFileController.clear();
    });
  }

  _addhieghtwidth(double height, double width) async {
    await fireStoreService.projectCollection.doc(widget.projectId).update({
      'containerHeight': height,
      'containerWidth': width,
    });
  }

// double dx, double dy
  _addMarkersToFirestore(
      double dx, double dy, double dxInpixel, double dyInPixel) async {
    await fireStoreService.addMarker(
      widget.projectId!,
      _textController.text,
      // positionOffset.dx,
      // positionOffset.dy,

      dx,
      dy,
      dxInpixel,
      dyInPixel,
      markers.length,
      false,
    );
  }

  _willpopScopeDialog() async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
                title: Text("Save your feedback before exiting?"),
                actions: [
                  TextButton(
                    onPressed: () async {
                      // fireStoreService.deleteProject(
                      //     context, widget.projectID!, widget.videoPath ?? "");
                      await fireStoreService.deleteProject(
                          context, widget.projectId!, _downloadUrl);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PdfHomeView()));
                    },
                    child: Text(
                      "No",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 148, 146, 146),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                title: Text("File name"),
                                content: TextFormField(
                                  controller: _saveFileController,
                                ),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      if (_saveFileController.text.isNotEmpty) {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        await _addProjectToFirestore();

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PdfHomeView())).then((_) {
                                          setState(() {
                                            isLoading = false;
                                          });
                                        });
                                        if (isLoading)
                                          CircularProgressIndicator();
                                      }
                                    },
                                    child: Text("Save"),
                                  )
                                ],
                              ));
                    },
                    child: Text("Yes"),
                  ),
                ]));
  }

  @override
  Widget build(BuildContext context) {
    double currentDeviceWidth = MediaQuery.of(context).size.width;

    double currentDeviceHeight = MediaQuery.of(context).size.height;
    double dynamicSize = currentDeviceWidth * 0.1;
    double offsetX = currentDeviceWidth * 0.005; // 0.5% of the screen width
    double offsetY = currentDeviceHeight * 0.005;

    double containerHeight = MediaQuery.of(context).size.height * 0.6;
    print("the container height is : $containerHeight");
    double containerWidth = MediaQuery.of(context).size.width;
    print("the container  wdth is : $containerWidth");

    // double imageHeight = containerHeight;
    // print("the image height is :$imageHeight");
    // double imageWidth = containerWidth;
    // print("the image width is :$imageWidth");
    double imageWidth = currentDeviceWidth * 0.8;
    double imageHeight = currentDeviceHeight * 0.5;

    print(" the calculated width of image is :$imageWidth");
    print("the calculated height of image is : $imageHeight");

    print("the calculated width is = ${currentDeviceWidth * 0.07}");

    print("the calculated height is = ${currentDeviceWidth * 0.07}");

    double markerSize = currentDeviceWidth * 0.0625;
    print("the marker size is ${markerSize} this is new");
    double subtractingSize = markerSize * 0.5;
    print("the subtracting size is $subtractingSize");
    return WillPopScope(
      onWillPop: () async {
        return await _willpopScopeDialog();
      },
      child: Scaffold(
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            return await _willpopScopeDialog();
                          },
                          child: Icon(
                            Icons.arrow_back,
                            size: 20,
                            color: Color.fromRGBO(0, 0, 0, 0.6),
                          ),
                        ),
                        Text(
                          "Add Feedback ",
                          style: GoogleFonts.openSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                  title: Text("File name"),
                                  content: TextFormField(
                                    controller: _saveFileController,
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () async {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Cancel"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        if (_saveFileController
                                            .text.isNotEmpty) {
                                          showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    CircularProgressIndicator(),
                                                    SizedBox(height: 16),
                                                    Text("Saving..."),
                                                  ],
                                                ),
                                              );
                                            },
                                          );

                                          try {
                                            await _addProjectToFirestore();
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PdfHomeView()),
                                            );
                                          } catch (e) {
                                            // print("Error: $e");
                                            // Handle the error if needed
                                          } finally {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      PdfHomeView(),
                                                ));
                                          }
                                        }
                                      },
                                      child: Text("Save"),
                                    )
                                  ]),
                            );
                            await fireStoreService
                                .saveImageToFirebase(widget.currentPageImage);
                            _addhieghtwidth(containerHeight, containerWidth);
                            // Add your save logic here
                            // For example, you can show a snackbar
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Save button tapped"),
                              ),
                            );
                          },
                          child: GestureDetector(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 17, right: 18, bottom: 18),
                              child: Text(
                                "Save",
                                style: GoogleFonts.openSans(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.040),
              Container(
                child: GestureDetector(
                  onTapDown: (TapDownDetails details) async {
                    Offset localPosition = details.localPosition;
                    double dx =
                        (localPosition.dx - imagePositiondx!) / containerWidth;
                    double dy =
                        (localPosition.dy - imagePositiondy!) / containerHeight;
                    double dxPixel = localPosition.dx;
                    double dyPixel = localPosition.dy;

                    // print("dy is :$dy");
                    // print("the divided oi s:$dx");
                    print("the offsetx is :${localPosition.dx}");
                    print("the offsety is :${localPosition.dy}");

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        _textController.clear();
                        return AlertDialog(
                          title: Text(
                            "Review",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          content: TextField(
                            maxLines: null,
                            minLines: null,
                            autofocus: true,
                            controller: _textController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () async {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  color:
                                      const Color.fromARGB(255, 166, 162, 162),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height / 22,
                              decoration: BoxDecoration(
                                color: Colors.purple,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: TextButton(
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                  String currentReview = _textController.text;
                                  ReviewModel model = ReviewModel(
                                    position: details.localPosition,
                                    review: currentReview,
                                    order: reviewList.length + 1,
                                  );
                                  setState(() {
                                    reviewList.add(model);
                                    _addMarker(dxPixel, dyPixel);
                                    Marker lastMarker = markers.last;
                                    lastMarker.isVisible = true;
                                  });
                                  _addMarkersToFirestore(
                                      dx, dy, dxPixel, dyPixel);
                                },
                                child: Text(
                                  'Done',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Stack(
                    children: [
                      Image.memory(
                        widget.currentPageImage,
                        key: imageKey,
                        height: imageHeight,
                        width: imageWidth,
                        fit: BoxFit.contain,
                      ),
                      for (var marker in markers)
                        if (marker.isVisible)
                          Positioned(
                            left: marker.dx - subtractingSize,
                            top: marker.dy - subtractingSize,
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
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.040),
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
                        children: [
                          GestureDetector(
                            onTap: () async {
                              final result = await showModalBottomSheet(
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
                                    child: BottomSheetContainer(
                                      //   isarInsatance: widget.isarInstnce,
                                      reviewLists: reviewList,
                                    ),
                                  );
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
      ),
    );
  }

  Future<void> saveImageToFirebaseStorage(Uint8List imageBytes) async {
    try {
      final storage = firebase_storage.FirebaseStorage.instance;
      final uniqueFileName =
          'image_${Uuid().v4()}.png'; // Generate a unique filename
      final ref = storage.ref().child(uniqueFileName);
      await ref.putData(imageBytes);
      final downloadURL = await ref.getDownloadURL();
      // print('Image saved to Firebase Storage: $downloadURL');
      // You can now use the downloadURL as needed, e.g., save it to a database.
    } catch (e) {
      // print('Error saving image to Firebase Storage: $e');
    }
  }
}

class Marker {
  final int index;
  // final Offset positionOffset;
  final double dx;
  final double dy;
  bool isVisible;
  Marker({
    required this.index,
    // required this.positionOffset,
    required this.dx,
    required this.dy,
    required this.isVisible,
  });
}
