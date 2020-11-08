import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class StorageService extends ChangeNotifier {
  StorageService();

  Future<String> getNetworkImageURL(context, String imageName) async {
    String image;
    await FirebaseStorage.instance
        .ref()
        .child(imageName)
        .getDownloadURL()
        .then((value) {
      image = value.toString();
    });
    return image;
  }
}
