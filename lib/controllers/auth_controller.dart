import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  pickProfileImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? _image = await _picker.pickImage(source: source);
    if (_image != null) {
      return await _image.readAsBytes();
    } else {
      print("image select nhi ki");
    }
  }

  _uploadProfileImageToStorge(Uint8List image) async {
    print("profilecategorybannewali ha");
    Reference ref =
        _storage.ref().child('profilePics').child(_auth.currentUser!.uid);
    UploadTask uploadTask = ref.putData(image);
    TaskSnapshot snapShopt = await uploadTask;
    String downloadUrl = await snapShopt.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> signUpUsers(String email, String fullName, String phoneNumber,
      String password, Uint8List? image) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty &&
          fullName.isNotEmpty &&
          phoneNumber.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        try {
          UserCredential cred = await _auth.createUserWithEmailAndPassword(
              email: email, password: password);

          String profilePicUrl = await _uploadProfileImageToStorge(image);

          await _firestore.collection('buyers').doc(cred.user!.uid).set({
            'email': email,
            'fullName': fullName,
            'phoneNumber': phoneNumber,
            'buyersId': cred.user!.uid,
            'address': '',
            'profilePicture': profilePicUrl
          });
          res = 'success';
        } on FirebaseAuthException catch (e) {
          if (e.code == 'email-already-in-use') {
            res = 'The email address is already in use by another account.';
          } else {
            res = e.message ?? res;
          }
        }
      } else {
        res = "Please fields must not be empty";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> loginUsers(String email, String password) async {
    String res = "Something went wrong";
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "You Are Now Logged In";
      } else {
        res = "Please fields must not be empty";
      }
    } on FirebaseAuthException catch (e) {
      res = e.code;
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
