// ignore_for_file: avoid_print

import 'dart:io';

import 'package:chat_app_flutter/core/utils/error/exception/my_exception.dart';
import 'package:chat_app_flutter/features/data/datasources/firebase_service.dart';
import 'package:chat_app_flutter/features/domain/models/status_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

abstract class StatusRemoteDataSource {
  Future<void> uploadStatus(
      {required String username,
      required String profilePicture,
      required File statusImage,
      required List<String> uidOnAppContact,
      required String caption});

  Stream<List<StatusModel>> getStatus();
}

class StatusRemoteDataSourceImpl extends StatusRemoteDataSource {
  final firestore = FirebaseService.firestore;
  final auth = FirebaseService.auth;
  final firebaseStorage = FirebaseService.storage;

  StatusRemoteDataSourceImpl();

  //The uploadStatus method is a function that is used to upload a user's status to a Firebase Firestore database.
  @override
  Future<void> uploadStatus(
      {required String username,
      required String profilePicture,
      required File statusImage,
      required List<String> uidOnAppContact,
      required String caption}) async {
    try {
      // It first generates a unique status ID using the uuid package and gets the user ID from the Firebase authentication instance.
      var statusId = const Uuid().v1();
      String uid = auth.currentUser!.uid;

      //The method first generates a unique status ID using the Uuid library, and then gets the user ID of the currently logged-in user
      var imageUrl = await _storeFileToFirebase(
        'status/$statusId/$uid',
        statusImage,
      );

      List<String> statusImageUrls = [];
      //queries Firestore to see if the user has already uploaded a status.
      var statusesSnapshot = await firestore
          .collection("status")
          .where("uid", isEqualTo: auth.currentUser!.uid)
          .get();

      //If the user has previously uploaded a status, the method retrieves the existing status data from Firestore, adds the new photo URL to the photoUrl
      // field, and updates the Firestore document with current time uploaded.
      if (statusesSnapshot.docs.isNotEmpty) {
        StatusModel status =
            StatusModel.fromMap(statusesSnapshot.docs[0].data());
        statusImageUrls = status.photoUrl;
        statusImageUrls.add(imageUrl);
        await firestore
            .collection("status")
            .doc(statusesSnapshot.docs[0].id)
            .update({
          'photoUrl': statusImageUrls,
          "createdAt": DateTime.now().millisecondsSinceEpoch
        });
        return;
      }
      //If the user has not uploaded a status before, the method creates a new StatusModel object and adds it to Firestore.
      else {
        statusImageUrls = [imageUrl];
      }

      StatusModel status = StatusModel(
          uid: uid,
          username: username,
          photoUrl: statusImageUrls,
          createdAt: DateTime.now(),
          profilePicture: profilePicture,
          statusId: statusId,
          idOnAppUser: uidOnAppContact,
          caption: caption);

      await firestore.collection("status").doc(statusId).set(status.toMap());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  //This is method uploads a file to Firebase Storage and returns the download URL of the uploaded file.
  Future<String> _storeFileToFirebase(String path, File file) async {
    //First, the method creates an UploadTask object using the putFile method of the Firebase Storage reference. The path parameter is used as
    // the path of the file in Firebase Storage, and the file parameter is used as the actual file to be uploaded
    UploadTask uploadTask = firebaseStorage.ref().child(path).putFile(file);
    //Next, the method waits for the upload to complete by awaiting the UploadTask object. The result of the upload is a TaskSnapshot object,
    // which contains information about the uploaded file, such as its download URL.
    TaskSnapshot snapshot = await uploadTask;
    //Finally, the method gets the download URL of the uploaded file by calling the getDownloadURL method on the TaskSnapshot object, and returns it as a String.
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  //The getStatus function appears to be a method of a class that retrieves a list of status updates from a Firestore collection.
  @override
  Stream<List<StatusModel>> getStatus() async* {
    try {
      final List<StatusModel> statusData = [];
      //queries documents based on the createdAt field value, selecting only documents that were created within the past 24 hours.
      // The query sorts the documents in descending order based on the createdAt field value.
      final Query<Map<String, dynamic>> query = firestore
          .collection('status')
          .where('createdAt',
              isGreaterThan: DateTime.now()
                  .subtract(const Duration(hours: 24))
                  .millisecondsSinceEpoch)
          .orderBy('createdAt', descending: true);

      print("query $query");
      //The method then listens to changes to the query using snapshots() and retrieves any new or updated documents matching the query criteria.
      await for (QuerySnapshot<Map<String, dynamic>> statusesSnapshot
          in query.snapshots()) {
        print("statusesSnapshot $statusesSnapshot");
        //For each snapshot, it creates a new list of StatusModel objects by iterating through each document in the snapshot and converting its data to a StatusModel object.
        for (var doc in statusesSnapshot.docs) {
          print("status $doc");
          final StatusModel tempStatus = StatusModel.fromMap(doc.data());
          statusData.add(tempStatus);
        }
        //Finally, it yields the list of StatusModel objects as a stream.
        yield statusData.toList();
      }
    } catch (e) {
      if (kDebugMode) print(e.toString());
      throw ServerException(e.toString());
    }
  }
}
