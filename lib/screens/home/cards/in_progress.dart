import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../ui_logic/image_picker.dart';

class InProgress extends StatefulWidget {
  const InProgress({Key? key}) : super(key: key);

  @override
  State<InProgress> createState() => _InProgressState();
}

class _InProgressState extends State<InProgress> {
  Uint8List? _post;
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
                    SizedBox(width: 10),
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
                  Uint8List? post = await pickImage(ImageSource.camera);
                  print('1');
                  setState(() {
                    _post = post;
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
                  Uint8List? post = await pickImage(ImageSource.gallery);
                  setState(() {
                    _post = post;
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
      _post = null;
    });
  }

  uploadImage() async {
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDir = referenceRoot.child('file/');
    Reference referenceImageToUpload = referenceDir.child(uniqueFileName);

    setState(() {
      _isLoading = true;
    });
    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
    );

    try {
      await referenceImageToUpload.putData(_post!, metadata);
      setState(() {
        _isLoading = false;
      });

      Navigator.of(context).pop();
      String url = await referenceImageToUpload.getDownloadURL();
      print(url);
    } catch (e) {
      const SnackBar(
        backgroundColor: Colors.orangeAccent,
        content: Text(
          "Failed to Upload! Try Again",
          style: TextStyle(fontSize: 16.0, color: Colors.black),
        ),
      );
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return _post == null
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
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                  image: MemoryImage(_post!),
                                  fit: BoxFit.fitHeight,
                                  alignment: FractionalOffset.topCenter)),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        uploadImage();
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
