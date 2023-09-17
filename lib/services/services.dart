import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:ronda/utils/file_utils.dart';
import 'package:ronda/utils/firebase.dart';

abstract class Service {
  //function to upload images to firebase storage and retrieve the url.
  Future<String> uploadImage(Reference ref, Uint8List? data) async {
    //String ext = FileUtils.getFileExtension(file);
    Reference storageReference = ref.child("${uuid.v4()}.jpg");
    UploadTask uploadTask; // = storageReference.putFile(file);
    if (data != null) {
      //final metadata = SettableMetadata(contentType: storageReference);
      uploadTask = storageReference.putData(data);
      await uploadTask.whenComplete(() => null);
    }

    //await uploadTask.whenComplete(() => null);
    String fileUrl = await storageReference.getDownloadURL();
    //if (fileUrl == null) {
    //  fileUrl = await ref.getDownloadURL();
    //}
    return fileUrl;
  }
}
