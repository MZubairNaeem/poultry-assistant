import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../ui_logic/image_picker.dart';
import '../../ui_logic/show_snack_bar.dart';

class InProgress extends StatefulWidget {
  const InProgress({Key? key}) : super(key: key);

  @override
  State<InProgress> createState() => _InProgressState();
}

class _InProgressState extends State<InProgress> {
  //Uint8List? _post;
  File? selectedImg;
  String? message = "";
  bool _isLoading = false;


  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text(
              'Select Image',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: const [
                    Icon(Icons.add_a_photo),
                    SizedBox(width: 11),
                    Text(
                      'Camera',
                      style: TextStyle(
                          color: Colors.deepPurpleAccent,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                onPressed: () async {
                  Navigator.of(context).pop();
                  print('0');
                  //File? post = await pickImage(ImageSource.camera);
                  final post = await ImagePicker().getImage(source: ImageSource.gallery);
                  selectedImg = File(post!.path);
                  print('1');
                  setState(() {
                    // selectedImg = post;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: const [
                    Icon(Icons.image_search),
                    SizedBox(width: 10),
                    Text(
                      'Chose Image from gallery',
                      style: TextStyle(
                          color: Colors.deepPurpleAccent,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                onPressed: () async {
                  Navigator.of(context).pop();
                  // final post = await pickImage(ImageSource.gallery);
                  final post = await ImagePicker().getImage(source: ImageSource.gallery);
                  selectedImg = File(post!.path);
                  setState(() {


                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    const Icon(Icons.cancel_outlined),
                    const SizedBox(width: 10),
                    Text(
                      'Cancel',
                      style: TextStyle(
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void clearImage() {
    setState(() {
      selectedImg = null;
    });
  }

  Future uploadToServer() async {
    setState(() {
          _isLoading = true;
        });
    try{
      String url = "https://d18b-119-160-64-197.ap.ngrok.io/insert";
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.files.add(http.MultipartFile('image_path', selectedImg!.readAsBytes().asStream(), selectedImg!.lengthSync(),),);
      var responce = await request.send();
      responce.stream.bytesToString().asStream().listen((event) {
        var parsedJson = jsonDecode(event);
        print(parsedJson);
        print(responce.statusCode);
      });
    }catch(e){

    }
    // final request = http.MultipartRequest(
    //     "POST", Uri.parse("https://1aeb-119-160-64-102.ap.ngrok.io"));
    // final headers = {"Content-type": "multipart/from-data"};
    // request.files.add(
    //     http.MultipartFile('image_path', selectedImg!.readAsBytes().asStream(),
    //         selectedImg!.lengthSync(), filename: selectedImg!
    //             .path
    //             .split("/")
    //             .last)
    // );
    // //request.headers.addAll(headers);
    // final responce = await request.send();
    // http.Response res = await http.Response.fromStream(responce);
    // final resJson = jsonDecode(res.body);
    // message = resJson['messages'
    setState(() {

      _isLoading = false;
      var err = "Server Error! Unable to connect";
      showSnackBar(err,context);
      print(message);

    });


  }

  // uploadImage() async {
  //   String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
  //   Reference referenceRoot = FirebaseStorage.instance.ref();
  //   Reference referenceDir = referenceRoot.child('file/');
  //   Reference referenceImageToUpload = referenceDir.child(uniqueFileName);
  //
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   final metadata = SettableMetadata(
  //     contentType: 'image/jpeg',
  //   );
  //
  //   try {
  //     await referenceImageToUpload.putData(_post!, metadata);
  //     setState(() {
  //       _isLoading = false;
  //     });
  //
  //     Navigator.of(context).pop();
  //     String url = await referenceImageToUpload.getDownloadURL();
  //     print(url);
  //   } catch (e) {
  //     const SnackBar(
  //       backgroundColor: Colors.orangeAccent,
  //       content: Text(
  //         "Failed to Upload! Try Again",
  //         style: TextStyle(fontSize: 16.0, color: Colors.black),
  //       ),
  //     );
  //     print(e.toString());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return selectedImg == null
        ? Scaffold(
      appBar: AppBar(
        title: const Text("Select Image"),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(
                Icons.upload,
                size: 36,
                color: Colors.grey.shade800,
              ),
              onPressed: () => _selectImage(context),
            ),
            Text(
              'Tap to select your post!',
              style: TextStyle(fontSize: 24, color: Colors.grey.shade800),
            )
          ],
        ),
      ),
    )
        : Scaffold(
        appBar: AppBar(
          title: const Text("Image Selected"),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: AspectRatio(
                    aspectRatio: 3 / 4,
                    child: Image.file(selectedImg!)
                    // Container(
                    //   decoration: BoxDecoration(
                    //       shape: BoxShape.rectangle,
                    //       image: DecorationImage(
                    //           image: MemoryImage(selectedImg!),
                    //           fit: BoxFit.fitHeight,
                    //           alignment: FractionalOffset.topCenter)),
                    // ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    //uploadImage();
                    uploadToServer();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.deepPurpleAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: _isLoading
                          ? Center(
                          child: Column(
                            children: const [
                              Text(
                                "Uploading...", style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              LinearProgressIndicator(
                                color: Colors.white,
                              ),
                            ],
                          ))
                          : const Center(
                        child: Text(
                          'Upload Image',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              letterSpacing: 1,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
