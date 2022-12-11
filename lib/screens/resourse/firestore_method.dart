
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:poultry_assistant/screens/resourse/schedule_model.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser!.uid;

  //upload post
  Future<String> uploadSchedule(
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
      Schedule schedule = Schedule(
          uid: uid,
          folkNumber: folkNumber,
          breedName: breedName,
          vaccinationName: vaccinationName,
          dateVaccination: dateVaccination,
          nextDateVaccination: nextDateVaccination,
      );
      _firestore.collection('Schedule').doc(postId).set(
        schedule.toJson(),
      );
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}