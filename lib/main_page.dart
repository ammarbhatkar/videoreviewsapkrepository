import 'package:Video_Review/pdfreviews_screens/pdf_home.dart';
import 'package:Video_Review/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
        child: Stack(children: [
          Padding(
            padding: const EdgeInsets.only(right: 24, top: 70, bottom: 24.5),
            child: Align(
              alignment: Alignment.centerRight,
              child: Image.asset(
                'assets/images/background.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          Column(
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
                "Bug Smash",
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
                    "Select What you want to review  ",
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
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 23,
                    crossAxisCount: 2,
                    mainAxisExtent: 168,
                  ),
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        if (index == 0) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PdfHomeView()));
                          // Handle PDF review button press
                          // Perform actions for PDF review
                        } else if (index == 1) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeView()));
                          // Handle video review button press
                          // Perform actions for video review
                        } else if (index == 2) {}
                      },
                      child: Container(
                        height: 168,
                        width: 170,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(126, 100, 237, 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 16, 0, 30),
                              child: Icon(
                                index == 0
                                    ? Icons.picture_as_pdf
                                    : Icons.videocam,
                                size: 40,
                                color: Color.fromRGBO(255, 255, 255, 1),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                              child: Text(
                                index == 0 ? "PDF Review" : "Video Review",
                                style: GoogleFonts.openSans(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 0, 0, 16),
                                child: Text(
                                  index == 0
                                      ? "Select PDF file to review"
                                      : "Select video to start reviewing",
                                  style: GoogleFonts.openSans(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(255, 255, 255, 0.6),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ]),
      )),
    );
  }
}
