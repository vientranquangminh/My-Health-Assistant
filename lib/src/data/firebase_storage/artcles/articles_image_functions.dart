import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:my_health_assistant/src/pages/global_var.dart';

class ArticlesImageFunction {

  static Future<String> uploadImage(File image) async { // to upload adn get download url of image
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('UserImage')
        .child("UserImage/${auth.currentUser?.uid}");
    UploadTask uploadTask = storageReference.putFile(image);

    await Future.value(uploadTask);

    var newUrl = await storageReference.getDownloadURL();

    return newUrl;
  }
}
