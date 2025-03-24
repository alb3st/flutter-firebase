import 'package:flutter/material.dart';

class StorageServices with ChangeNotifier {
  //firebase storage
  final firebaseStorage = FirebaseStorage.instance;

  //images are stored in firebase as download URLs
  List<String> _imageURLs = [];

  //loading status
  bool _isLoading = false;

  //uploading status
  bool _isUploading = false;

  /*
  getters
  */
  List<String> get imageURLs => _imageURLs;
  bool get isLoading => _isLoading;
  bool get isUploading => _isUploading;

  /*
  read images
  */
  Future<void> fetchImages() async {
    //start loading
    _isLoading = true;

    //get the list under the directory: uploaded_images/
    final ListResult result =
        await firebaseStorage.ref('uploaded_images/').listAll();

    //get the download URLs for each image
    final urls =
        await Future.wait(result.items.map((ref) => ref.getDownloadURL()));

    //upload URLs
    _imageURLs = urls;

    //loading finished
    _isLoading = false;

    //update UI
    notifyListeners();
  }

  /*
  delete images
  */

  /*
  upload images
  */
}
