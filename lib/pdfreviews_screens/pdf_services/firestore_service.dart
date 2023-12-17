// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class PdfFireStoreService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference projectCollection =
      FirebaseFirestore.instance.collection('pdfprojects');
  final CollectionReference markerCollection =
      FirebaseFirestore.instance.collection('pdfmarkers');

  Future<DocumentReference> addPdfProjects(String? projectId, String? title,
      String? imageUrl, String? currentUserEmail) {
    return projectCollection.add({
      'projectId': projectId,
      'title': title,
      'imageUrl': imageUrl,
      'userEmail': currentUserEmail,
      'date': FieldValue.serverTimestamp(),
    });
  }

  Future<String> saveImageToFirebase(Uint8List image) async {
    Reference ref = _storage.ref().child('images/${DateTime.now()}.png');
    await ref.putData(image);

    String downloadUrl = await ref.getDownloadURL();
    print("the download url is :$downloadUrl");
    return downloadUrl;
  }

  Future<DocumentReference> addMarker(
      String projectId,
      String feedback,
      double dx,
      double dy,
      double dxInpixel,
      double dyInPixel,
      int order,
      bool isResolved) {
    return markerCollection.add({
      'projectId': projectId,
      'feedback': feedback,

      //  'positionOffset': positionOffset,
      'dx': dx,
      'dy': dy,
      'dxInpixel': dxInpixel,
      'dyInpixel': dyInPixel,
      'order': order,
      'isResolved': false,
    });
  }

  Future<void> deleteProject(
      BuildContext context, String projectId, String? imageUrl) async {
    await projectCollection.doc(projectId).delete();
    await deleteMarkersForProject(projectId);
    if (imageUrl != null && imageUrl.isNotEmpty) {
      Reference imageRef = _storage.refFromURL(imageUrl);
      await imageRef.delete();
    }
  }

  Future<void> deleteMarkersForProject(String projectId) async {
    return markerCollection
        .where('projectId', isEqualTo: projectId)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    });
  }

  Stream<QuerySnapshot> getProjectsForUser(String userEmail) async* {
    // Step 1: Fetch projects where the user is the owner (userEmail is the ownerId).
    final ownerProject =
        await projectCollection.where('userEmail', isEqualTo: userEmail).get();

    // Extract project IDs from the user's owned projects.
    final projectIds = ownerProject.docs.map((doc) => doc.id).toList();

    // Step 2: Fetch projects where the user's email is in the 'sharedEmails' list.
    final sharedProject = await projectCollection
        .where('sharedEmails', arrayContains: userEmail)
        .get();

    // Extract project IDs from the shared projects.
    final sharedProjectIds = sharedProject.docs.map((doc) => doc.id).toList();

    // Combine the project IDs from user-owned and shared projects.
    final allProjectIds = [...projectIds, ...sharedProjectIds];

    // Step 3: Check if allProjectIds is not empty before querying Firestore.
    if (allProjectIds.isNotEmpty) {
      // Return a stream of snapshots for projects with the combined project IDs.
      yield* projectCollection
          .where(FieldPath.documentId, whereIn: allProjectIds)
          .snapshots();
    } else {
      // If there are no projects, return an empty stream.
      yield* Stream.empty();
    }
  }

  Stream<QuerySnapshot> getmarkersForProjects(String projectId) {
    return markerCollection
        .where('projectId', isEqualTo: projectId)
        .orderBy('order')
        .snapshots();
  }

  Future<void> addSharedEmail(String projectId, String email) async {
    return await projectCollection.doc(projectId).update({
      'sharedEmails': FieldValue.arrayUnion([email]),
    });
  }

  Stream<QuerySnapshot> getProjects(String projectId) {
    return projectCollection
        .where('projectId', isEqualTo: projectId)
        .snapshots();
  }
}
