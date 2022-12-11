import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../resourse/get_user_data.dart';

class ComingSchedule extends StatefulWidget {
  const ComingSchedule({Key? key}) : super(key: key);

  @override
  State<ComingSchedule> createState() => _ComingScheduleState();
}

class _ComingScheduleState extends State<ComingSchedule> {


  //doc user
  List<String> docIDs = [];

  //get docsID
  Future getDocID() async {


    await FirebaseFirestore.instance
        .collection('Schedule')
        .get()
        .then((snapshot) => snapshot.docs.forEach((element) {
      print(element.reference);
      docIDs.add(element.reference.id);
    }));
  }

  // @override
  // void initState() {
  //   getDocID();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Coming Schedule",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                Expanded(child: FutureBuilder(
                  future: getDocID(),
                  builder: (context, snapshot) {
                    return ListView.builder(
                        itemCount: docIDs.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: ListTile(
                              //tileColor: Colors.grey[300],
                              trailing:  IconButton(
                                onPressed: ()  {

                              },
                                icon: const Icon(Icons.delete_sharp)),
                              onLongPress: (){

                              },
                              title: GetUser(documentID: docIDs[index],),
                            ),
                          );
                        });
                  },
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}