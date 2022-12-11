import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetUser extends StatelessWidget {

  final String documentID;
  const GetUser({super.key, required this.documentID});


  @override
  Widget build(BuildContext context) {

    //get the collection
    CollectionReference users  = FirebaseFirestore.instance.collection('Schedule');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentID).get(),
      builder: ((context, snapshot){
        if (snapshot.connectionState == ConnectionState.done){
          Map<String, dynamic> data = snapshot.data!.data() as Map<String ,dynamic>;
          return Text(
              'Folk No: ${data['folkNumber']},\n'
                  'Breed Name ${data['breedName']},\n'
                  'Vaccination Name ${data['vaccinationName']}\n'
                  'Vaccination Date ${data['dateVaccination']}\n'
                  'Next Vaccination Date ${data['nextDateVaccination']}\n'
          );
        }
        return const Center(child: CircularProgressIndicator());
      }),
    );
  }
}