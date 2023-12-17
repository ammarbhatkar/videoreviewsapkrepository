import 'package:Video_Review/firebase_options.dart';
import 'package:Video_Review/main_page.dart';
import 'package:Video_Review/pdfreviews_screens/add_marker_on_pdf.dart';
import 'package:Video_Review/services/firebase_dynamic_links.dart';
import 'package:Video_Review/views/widgets/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // final dir = await getApplicationSupportDirectory();
  //DynamicLinkService().initDynamicLink;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // final Isar isar;
  const MyApp({
    super.key,
    //  required this.isar,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}
