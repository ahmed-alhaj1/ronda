import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ronda/models/user.dart';
import 'package:ronda/services/user_service.dart';
import 'package:ronda/utils/constants.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:file_picker/file_picker.dart';

class EditProfileViewModel extends ChangeNotifier {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool validate = false;
  bool loading = false;
  UserService userService = UserService();
  final picker = ImagePicker();
  UserModel? user;
  String? country;
  String? username;
  String? bio;
  File? image;
  //File? webimage;
  String? imgLink;
  //#####################################
  // experienc
  //ExpModel? expmodel;
  String? place, position, pdescription;
  Timestamp? startYear, endYear;
  File _file = File("zz");
  //File _file = File("zz");
  Uint8List webImage = Uint8List(10);

//#######################################
// education
//type EducationReturnValue
// university(insutition) major, startdate, enddate, degree
//

//######################################
//# business document
//#1- name
//#2- insurance if any
//#3- certificate
//#4- licenses
//#5- address

  //String? name, insurance_url, cert_url, license_url, address;
  //final insuranceDoc = ImagePicker();
  //final certificateDoc = ImagePicker();
  //final license = ImagePicker();

  //setBusinessName(String value )
  //#####################################

  setUser(UserModel val) {
    user = val;
    notifyListeners();
  }

  setImage(UserModel user) {
    imgLink = user.photoUrl;
  }

  setCountry(String val) {
    print('SetCountry $val');
    country = val;
    notifyListeners();
  }

  setBio(String val) {
    print('SetBio$val');
    bio = val;
    notifyListeners();
  }

  setUsername(String val) {
    print('SetUsername$val');
    username = val;
    notifyListeners();
  }

  editProfile(BuildContext context) async {
    FormState form = formKey.currentState!;
    form.save();
    if (!form.validate()) {
      validate = true;
      notifyListeners();
      showInSnackBar(
          'Please fix the errors in red before submitting.', context);
    } else {
      try {
        loading = true;
        notifyListeners();
        bool success = await userService.updateProfile(
          //  user: user,
          image: image,
          username: username,
          bio: bio,
          country: country,
        );
        print(success);
        if (success) {
          clear();
          Navigator.pop(context);
        }
      } catch (e) {
        loading = false;
        notifyListeners();
        print(e);
      }
      loading = false;
      notifyListeners();
    }
  }

  pickImage({bool camera = false, BuildContext? context}) async {
    loading = true;
    notifyListeners();
    try {
      if (kIsWeb) {
        FilePickerResult? res = await FilePicker.platform.pickFiles(
            type: FileType.custom, allowedExtensions: ['jpg', 'png']);
        if (res != null) {
          PlatformFile file = res.files.first;
          //imgLink = file != null ? '' : file.path.toString();
          image = File(file.path.toString());
          webImage = file.bytes!;
        }
      } else if (Platform.isAndroid) {
        XFile? pickedFile = await picker.pickImage(
          source: camera ? ImageSource.camera : ImageSource.gallery,
        );

        if (pickedFile != null) {
          var f = await pickedFile.readAsBytes();
          //_file = File("a");
          webImage = f;
        }
        /*
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: Constants.lightAccent,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            minimumAspectRatio: 1.0,
          ),
        ],
      );*/
        image = File(pickedFile!.path);
        loading = false;
        notifyListeners();
      }
    } catch (e) {
      loading = false;
      notifyListeners();
      showInSnackBar('Cancelled', context);
    }
  }

  clear() {
    image = null;
    notifyListeners();
  }

  void showInSnackBar(String value, context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
  }
}
