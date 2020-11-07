import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class StorageService extends ChangeNotifier {
  StorageService();
  
  static Future<dynamic> loadImage(BuildContext context, String image) async {
    return await FirebaseStorage.instance.ref().child(image).getDownloadURL();
  }

  Future<ImageProvider> getNetworkImage(context, String imageName) async {
    ImageProvider image;
    await loadImage(context, imageName).then((value) {
      image = NetworkImage(value.toString());
    });
    return image;
  }
}
