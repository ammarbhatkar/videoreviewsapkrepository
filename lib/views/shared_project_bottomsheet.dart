// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:Video_Review/services/firestore_service.dart';
import 'package:flutter/material.dart';

class SharedBottomSheet extends StatefulWidget {
  final String projectId;
  const SharedBottomSheet({
    super.key,
    required this.projectId,
  });

  @override
  State<SharedBottomSheet> createState() => _SharedBottomSheetState();
}

class _SharedBottomSheetState extends State<SharedBottomSheet> {
  final FireStoreService fireStoreService = FireStoreService();
  final TextEditingController _sharedEmailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        //      color: Colors.red,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          Expanded(
              child: StreamBuilder(
            stream: fireStoreService.getEmailsOfProject(widget.projectId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: (snapshot.data?.docs.reversed.length ?? 0) + 1,
                itemBuilder: (context, index) {
                  if (index < (snapshot.data?.docs.reversed.length ?? 0)) {
                    final obj = snapshot.data?.docs[index];
                    final emailObj = obj?['email'];

                    print("the email fecthed is :$emailObj");
                    //    final projectId = obj?['projectId'];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Text(emailObj),
                      ),
                    );
                  } else {
                    return Center(
                      child: ElevatedButton(
                        style: ButtonStyle(),
                        onPressed: () {
                          _showAddDialoForShareButton();
                        },
                        child: Text("Add"),
                      ),
                    );
                  }
                },
              );
            },
          )),
        ],
      ),
    );
  }

  _showAddDialoForShareButton() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: TextField(
              controller: _sharedEmailController,
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  _addEmailToFireStore();
                },
                child: Text("Confrim"),
              ),
            ],
          );
        });
  }

  _addEmailToFireStore() async {
    await fireStoreService.addSharedEmail(
        widget.projectId, _sharedEmailController.text);
    Navigator.of(context).pop();
  }

  // _fetchEmailsOfProject() {
  //   fireStoreService.getEmailsOfProject(widget.projectId).listen((snapshot) { });
  // }
}
