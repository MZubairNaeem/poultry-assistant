
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:poultry_assistant/screens/resourse/schedule_model.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //upload post
  Future<String> uploadPost(
      String uid,
      String folkNumber,
      String breedName,
      String vaccinationName,
      String dateVaccination,
      String nextDateVaccination,
      ) async {
    String res = "Some error Occur";
    try {
      String postId = const Uuid().v1();
      Post post = Post(
          uid: uid,
          folkNumber: folkNumber,
          breedName: breedName,
          vaccinationName: vaccinationName,
          dateVaccination: dateVaccination,
          nextDateVaccination: nextDateVaccination,
      );
      _firestore.collection('posts').doc(postId).set(
        post.toJson(),
      );
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}