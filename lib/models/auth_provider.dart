import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_vendor_app_provider/controllers/auth_controller.dart';

class AuthProvider extends ChangeNotifier {
  final AuthController _authController = AuthController();
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  Uint8List? _image;
  Uint8List? get image => _image;



  Future<String> signUpUsers(String email, String fullName, String phoneNumber,
      String password) async {
    _isLoading = true;
    notifyListeners();

    String res = await _authController.signUpUsers(
        email, fullName, phoneNumber, password,image);

    _isLoading = false;
    notifyListeners();

    return res;
  }

  Future<String> loginUsers(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    String res = await _authController.loginUsers(email, password);

    _isLoading = false;
    notifyListeners();

    return res;
  }

  selectGalleryImage() async {
    Uint8List? img =
        await _authController.pickProfileImage(ImageSource.gallery);
    if (img != null) {
      _image = img;
      notifyListeners();
    } else {
      return null;
    }
  }

  selectCameraImage() async {
    Uint8List img = await _authController.pickProfileImage(ImageSource.camera);
     // ignore: unnecessary_null_comparison
     if (img != null) {
      _image = img;
      notifyListeners();
    } else {
      return null;
    }
  }
}
