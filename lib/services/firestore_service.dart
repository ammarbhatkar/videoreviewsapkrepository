// ignore_for_file: avoid_print

import 'dart:io';

import 'package:Video_Review/tet.dart';
import 'package:Video_Review/views/home_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FireStoreService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference projectCollection =
      FirebaseFirestore.instance.collection('project');
  final CollectionReference markerCollection =
      FirebaseFirestore.instance.collection('markers');
  final CollectionReference sharedCollection =
      FirebaseFirestore.instance.collection('sharedProjects');

  Future<DocumentReference> addProjects(String? projectId, String? title,
      String? videoPath, String? currentUserEmail) {
    return projectCollection.add({
      'projectId': projectId,
      'title': title,
      'videoPath': videoPath,
      'userEmail': currentUserEmail,
      'date': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateProject(
      String projectId, String title, String videoPath) async {
    DocumentReference projectRef = projectCollection.doc(projectId);
    await projectRef.update({
      'title': title,
      'videoPath': videoPath,
    });
  }

  Future<void> updateMarkerStatus(String markerId, bool isResolved) async {
    DocumentReference docRed = markerCollection.doc(markerId);
    await docRed.update({
      'isResolved': isResolved,
    });
  }

  Future<void> deleteProject(
      BuildContext context, String projectId, String? videoPath) async {
    await projectCollection.doc(projectId).delete();
    await deleteMarkersForProject(projectId);
    await deleteVideo(videoPath ?? "");
    Navigator.push(context, MaterialPageRoute(builder: (contex) => HomeView()));
  }

  Future<void> deleteMarkersForProject(projectId) async {
    return markerCollection
        .where('projectId', isEqualTo: projectId)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    });
  }

  Future<DocumentReference> addMarker(String projectId, String feedback,
      int timeStamp, double dx, double dy, int order, bool isResolved) {
    return markerCollection.add({
      'projectId': projectId,
      'feedback': feedback,
      'timeStamp': timeStamp,
      'dx': dx,
      'dy': dy,
      'order': order,
      'isResolved': false,
    });
  }

  // Future<void> addSharedEmail(String projectId, String email) {
  //   return sharedCollection.add({
  //     'email': email,
  //     'projectId': projectId,
  //   });
  // }

  Future<void> addSharedEmail(String projectId, String email) {
    return sharedCollection.add({
      'email': email,
      'projectId': projectId,
    }).then((value) {
      // Update the sharedEmails field in the project document
      projectCollection.doc(projectId).update({
        'sharedEmails': FieldValue.arrayUnion([email]),
      });
    });
  }

  Future<String> uploadVideo(String videoPath) async {
    Reference ref = _storage.ref().child('videos/${DateTime.now()}.mp4');
    await ref.putFile(File(videoPath));
    String downloadUrl = await ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> deleteVideo(String videoPath) async {
    try {
      Reference ref = _storage.ref().child(videoPath);
      await ref.delete();
    } catch (error) {
      // print("Error deleting video: $error");
      // Handle error (show a message, log it, etc.)
    }
  }

  // Future<void> saveVideoData(String downloadedUrl) async {
  //   await _firestore.collection('videos').add({
  //     'url': downloadedUrl,
  //     'timeStamp': FieldValue.serverTimestamp(),
  //     'name': "User Video"
  //   });
  // }

  Stream<QuerySnapshot> getProjects(String projectId) {
    return projectCollection
        .where('projectId', isEqualTo: projectId)
        .snapshots();
  }

  // Stream<QuerySnapshot> getProjectsForUSer(String userId) {
  //   return projectCollection.where('userId', isEqualTo: userId).snapshots();
  // }
  // Stream<QuerySnapshot> getProjectsForUSer(String userEmail) async* {
  //   final userProjects =
  //       await projectCollection.where('userEmail', isEqualTo: userEmail).get();

  //   final projectIds = userProjects.docs.map((doc) => doc.id).toList();

  //   final sharedProjects = await projectCollection
  //       .where('sharedEmails', arrayContains: userEmail)
  //       .get();

  //   final sharedProjectIds = sharedProjects.docs.map((doc) => doc.id).toList();

  //   final allProjectIds = [...projectIds, ...sharedProjectIds];

  //   yield* projectCollection
  //       .where(FieldPath.documentId, whereIn: allProjectIds)
  //       .snapshots();
  // }

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

  Stream<QuerySnapshot> displayMarkerFromFirestore(String projectId) {
    return markerCollection
        .where('projectId', isEqualTo: projectId)
        .snapshots();
  }

  Stream<QuerySnapshot> getEmailsOfProject(String projectId) {
    return sharedCollection
        .where('projectId', isEqualTo: projectId)
        .snapshots();
  }

  Future addUser(String userId, Map<String, dynamic> userInfoMap) {
    return _firestore.collection("User").doc(userId).set(userInfoMap);
  }
}
