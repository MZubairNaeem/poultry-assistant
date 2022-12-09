import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: source);

  if(file != null) {
    print("image selected");
    return await file.readAsBytes();
  }
  print("No image selected");
}