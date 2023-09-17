import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ronda/models/post.dart';
import 'package:ronda/screens/mainscreen.dart';
import 'package:ronda/services/post_service.dart';
import 'package:ronda/services/user_service.dart';
import 'package:ronda/utils/constants.dart';
import 'package:ronda/utils/firebase.dart';

class PostsViewModel extends ChangeNotifier {
  //Services
  UserService userService = UserService();
  PostService postService = PostService();

  //Keys
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //Variables
  bool loading = false;
  String? username;
  XFile? mediaUrl;
  final picker = ImagePicker();
  String? location;
  Position? position;
  Placemark? placemark;
  String? bio;
  String? description;
  String? email;
  String? commentData;
  String? ownerId;
  String? userId;
  String? type;
  File? userDp;
  String? imgLink;
  bool edit = false;
  String? id;
  Uint8List? webImage; // = Uint8List(10);

  //controllers
  TextEditingController locationTEC = TextEditingController();

  //Setters
  setEdit(bool val) {
    edit = val;
    notifyListeners();
  }

  setPost(PostModel post) {
    if (post != null) {
      description = post.description;
      imgLink = post.mediaUrl;
      location = post.location;
      edit = true;
      edit = false;
      notifyListeners();
    } else {
      edit = false;
      notifyListeners();
    }
  }

  setWebImage(Uint8List? picf) {
    //webImage = //10;
    //(picf!.length);
    webImage = picf;
    notifyListeners();
  }

  setMediaUrl(XFile f) {
    mediaUrl = f;
    notifyListeners();
  }

  setUsername(String val) {
    print('SetName $val');
    username = val;
    notifyListeners();
  }

  setDescription(String val) {
    print('SetDescription $val');
    description = val;
    notifyListeners();
  }

  setLocation(String val) {
    print('SetCountry $val');
    location = val;
    notifyListeners();
  }

  setBio(String val) {
    print('SetBio $val');
    bio = val;
    notifyListeners();
  }

  //Functions
  pickImage({bool camera = false, BuildContext? context}) async {
    loading = true;
    notifyListeners();
    try {
      //XFile? pickedFile = await picker.pickImage(
      //  source: camera ? ImageSource.camera : ImageSource.gallery,
      //);
      if (kIsWeb || Platform.isWindows) {
        print('platform is web ');
        FilePickerResult? res = await FilePicker.platform.pickFiles(
          withData: true,
          type: FileType.custom,
          allowedExtensions: ['jpg', 'png'],
        );
        print('************ things are still okay*************');
        if (res != null) {
          //PlatformFile? file = res.files.first;
          //imgLink = file != null ? '' : file.path.toString();
          //mediaUrl = File(file.path!.toString());
          //setState(() {
          webImage = res.files.first.bytes;
          mediaUrl = XFile('');

          res.files.first.bytes != null
              ? print('byte is fine')
              : print('res is null');

          print('SSSSSSSSSSSSUUUUUUUCCEEEEEESSSSSSSSSSSSSSS');

          notifyListeners();
        } else {
          print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
          print('file picker result null');
        }
      }
      if (Platform.isAndroid) {
        print('platform is andriod');
        XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
        mediaUrl = XFile(pickedFile!.path);
        notifyListeners();
        //imgLink = await postService.SavePost(pickedFile, store.getuser());
      }
      /*
        XFile? pickedFile = await picker.pickImage(
          source: camera ? ImageSource.camera : ImageSource.gallery,
        );

        if (pickedFile != null) {
          var f = await pickedFile.readAsBytes();
          //_file = File("a");
          webImage = f;
        }

        
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
      );
      */
      loading = false;
      notifyListeners();
    } catch (e) {
      loading = false;
      notifyListeners();
      showInSnackBar('Cancelled', context);
    }
  }

  getLocation() async {
    loading = true;
    notifyListeners();
    LocationPermission permission = await Geolocator.checkPermission();
    print(permission);
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      LocationPermission rPermission = await Geolocator.requestPermission();
      print(rPermission);
      await getLocation();
    } else {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemarks = await placemarkFromCoordinates(
          position!.latitude, position!.longitude);
      placemark = placemarks[0];
      location = " ${placemarks[0].locality}, ${placemarks[0].country}";
      locationTEC.text = location!;
      print(location);
    }
    loading = false;
    notifyListeners();
  }

  uploadPosts(BuildContext context) async {
    try {
      loading = true;
      print('things are good ! ###upload post');
      notifyListeners();
      print(mediaUrl!.path);
      await postService.uploadPost(
          mediaUrl!, location!, description!, webImage!);
      print('upload post excuted fine');
      loading = false;
      resetPost();
      notifyListeners();
    } catch (e) {
      print(e);
      loading = false;
      resetPost();
      showInSnackBar('Uploaded successfully!', context);
      notifyListeners();
    }
  }

  uploadProfilePicture(BuildContext context) async {
    if (mediaUrl == null) {
      showInSnackBar('Please select an image', context);
    } else {
      try {
        loading = true;
        notifyListeners();
        await postService.uploadProfilePicture(
            mediaUrl!, firebaseAuth.currentUser!, webImage);
        loading = false;
        Navigator.of(context)
            .pushReplacement(CupertinoPageRoute(builder: (_) => TabScreen()));
        notifyListeners();
      } catch (e) {
        print(e);
        loading = false;
        showInSnackBar('Uploaded successfully!', context);
        notifyListeners();
      }
    }
  }

  resetPost() {
    mediaUrl = null;
    description = null;
    location = null;
    edit = false;
    notifyListeners();
  }

  void showInSnackBar(String value, context) {
    //ScaffoldMessenger.of(context).removeCurrentSnackBar();
    assert(context != null);
    //if (!kIsWeb) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));

    ///}else{
    /// Scaffold.of(context).showSnackBar(new SnackBar(content: new Text('Hello world')));

//    }
  }
}
