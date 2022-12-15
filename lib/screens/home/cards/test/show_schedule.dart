import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShowSchedule extends StatefulWidget {
  const ShowSchedule({Key? key}) : super(key: key);

  @override
  _ShowScheduleState createState() => _ShowScheduleState();
}

class _ShowScheduleState extends State<ShowSchedule> {
  final CollectionReference _products =
  FirebaseFirestore.instance.collection('products');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          title: const Text('Coming Schedule'),
          centerTitle: true,
        ),
        body: StreamBuilder(
          stream: _products.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                  streamSnapshot.data!.docs[index];
                  return Card(
                    elevation: 10,
                    color: Colors.grey.shade200,
                    margin: const EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        // tileColor: Colors.deepPurple.shade50,
                        title: Column(
                          children: [
                            Row(
                              children: [
                                const Text('Folk Number: ',style: TextStyle(fontWeight: FontWeight.bold),),
                                Text(documentSnapshot['Flock_Name']),
                              ],
                            ),
                            Row(
                              children: [
                                const Text('Breed Name: ',style: TextStyle(fontWeight: FontWeight.bold),),
                                Text(documentSnapshot['BreadName']),
                              ],
                            ),
                            Row(
                              children: [
                                const Text('Vaccination Name: ',style: TextStyle(fontWeight: FontWeight.bold),),
                                Text(documentSnapshot['VaccineName']),
                              ],
                            ),
                          ],
                        ),

                        subtitle: Row(
                          children: [
                            const Text('Next Vaccination Date:  ',style: TextStyle(fontWeight: FontWeight.bold),),
                            Text(documentSnapshot['NextVaccinationDate']),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
    );
  }
}
