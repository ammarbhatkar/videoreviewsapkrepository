// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures, use_build_context_synchronously, must_be_immutable

import 'dart:typed_data';

import 'package:Video_Review/pdfreviews_screens/add_marker_on_pdf.dart';
import 'package:Video_Review/pdfreviews_screens/newpdfscreen.dart';
import 'package:Video_Review/pdfreviews_screens/pdf_services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pdf_image_renderer/pdf_image_renderer.dart';

class PdfViewer extends StatefulWidget {
  final String pdf;
  String? currentEmail;
  PdfViewer({
    super.key,
    required this.pdf,
    this.currentEmail,
  });

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  final PdfFireStoreService fireStoreService = PdfFireStoreService();
  int? count;
  int pageIndex = 0;
  PdfImageRendererPdf? pdf;
  bool open = false;
  List<Uint8List> pageImages = [];
  bool cropped = false;
  Uint8List? image;
  PdfImageRendererPageSize? size;
  int asyncTasks = 0;
  String? projectId;
  String? titleP;
  String? imageUrl;
  String? email;

  @override
  void initState() {
    super.initState();
    openPdf(path: widget.pdf);
  }

  Future<void> openPdf({required String path}) async {
    if (pdf != null) {
      await pdf!.close();
    }
    pdf = PdfImageRendererPdf(path: path);
    await pdf!.open();
    count = await pdf!.getPageCount();

    for (int i = 0; i < count!; i++) {
      final image = await renderPage(pageIndex: i);
      pageImages.add(image!);
      // Do something with the 'image' if needed
    }

    setState(() {
      open = true;
    });
  }

  Future<Uint8List?> renderPage({required int? pageIndex}) async {
    size = await pdf!.getPageSize(pageIndex: pageIndex ?? 0);
    final i = await pdf!.renderPage(
      pageIndex: pageIndex ?? 0,
      x: cropped ? 100 : 0,
      y: cropped ? 100 : 0,
      width: cropped ? 100 : size!.width,
      height: cropped ? 100 : size!.height,
      scale: 3,
      background: Colors.white,
    );

    return i;
  }

  Future<void> closePdf() async {
    if (pdf != null) {
      await pdf!.close();
      setState(() {
        pdf = null;
        open = false;
      });
    }
  }

  Future<void> openPdfPage({required int pageIndex}) async {
    await pdf!.openPage(pageIndex: pageIndex);
  }

  Future<void> closePdfPage({required int pageIndex}) async {
    await pdf!.closePage(pageIndex: pageIndex);
  }

  Future<void> _addPdfProject() async {
    DocumentReference projectRef = await fireStoreService.addPdfProjects(
        projectId, titleP, imageUrl, widget.currentEmail);
    setState(() {
      projectId = projectRef.id;
    });
    // print("the document id of this project is : $projectId");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 251),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (open == true) ...[
                Expanded(
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 23,
                          crossAxisCount: 2,
                          mainAxisExtent: 200,
                        ),
                        itemCount: count,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                              if (pageImages[index] != null) {
                                await _addPdfProject();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddMarkerOnPdf(
                                            currentUserEmail: email.toString(),
                                            projectId: projectId.toString(),
                                            currentPageImage:
                                                pageImages[index])));
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                width: 1,
                              )),
                              child: pageImages[index] != null
                                  ? Image.memory(
                                      pageImages[index],
                                      fit: BoxFit.contain,
                                    )
                                  : CircularProgressIndicator(),
                            ),
                          );
                        })),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
