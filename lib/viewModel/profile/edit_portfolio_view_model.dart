import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ronda/models/user.dart';
import 'package:ronda/services/user_service.dart';
import 'package:ronda/utils/constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:ronda/model/FirmModel.dart';

class EditProfileViewModel extends ChangeNotifier {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool validate = false;
  bool loading = false;
  //
  //UserService userService = UserService();
  //final picker = ImagePicker();
  FirmModel? firm;
  UserModel? user;
  String? country;
  String? username;
  String? bio;
  File? image;
  String? imgLink;
  //#####################################
  // experienc
  //ExpModel? expmodel;
  String? place, position, pdescription;
  Timestamp? startYear, endYear;

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

  String? name, insurance_url, cert_url, license_url, address;
  FilePickerResult? insuranceDoc, licenseDoc, certDoc; //= ImagePicker();
  //File certificateDoc;// = FilePicker().platform.pickFiles();
  //final license = ImagePicker();

  setFirm(FirmModel val) {
    firm = val;
  }

  setInsuranceUrl(String val) {
    insurance_url = val;
  }

  setCertUrl(String val) {
    cert_url = val;
  }

  setLicenseUrl(String val) {
    license_url = val;
  }

  pickFile(BuildContext? context) async {
    FilePickerResult? doc = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'cdr', 'jpg', 'pdf', 'doc'],
    );

    if (doc != null) {
      PlatformFile fl = doc.files.first;
      print("##########File Infor ###############");
      print(fl.name);
      print(fl.bytes);
      print(fl.size);
      print(fl.extension);
      print(fl.path);
      print("#####################################");
    }
  }
}
