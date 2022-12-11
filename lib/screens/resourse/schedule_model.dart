import 'package:cloud_firestore/cloud_firestore.dart';

class Schedule{
  final String uid;
  final String folkNumber;
  final String breedName;
  final String vaccinationName;
  final dateVaccination;
  final nextDateVaccination;

  const Schedule({
    required this.uid,
    required this.folkNumber,
    required this.breedName,
    required this.vaccinationName,
    required this.dateVaccination,
    required this.nextDateVaccination
  });

  Map<String, dynamic> toJson() =>{
    "uid": uid,
    "folkNumber": folkNumber,
    "breedName":breedName,
    "vaccinationName": vaccinationName,
    "dateVaccination": dateVaccination,
    "nextDateVaccination":nextDateVaccination,
  };

  static Schedule fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String,dynamic>;
    return Schedule(
      uid: snapshot['uid'],
      folkNumber: snapshot['folkNumber'],
      breedName: snapshot['breedName'],
      vaccinationName: snapshot['vaccinationName'],
      dateVaccination: snapshot['dateVaccination'],
      nextDateVaccination: snapshot['nextDateVaccination'],
    );
  }
}
