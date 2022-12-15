import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ScheduleCreation extends StatefulWidget {
  const ScheduleCreation({Key? key}) : super(key: key);

  @override
  _ScheduleCreationState createState() => _ScheduleCreationState();
}

class _ScheduleCreationState extends State<ScheduleCreation> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
// text fields' controllers
  final TextEditingController _flockNameController = TextEditingController();
  final TextEditingController _breadNameController = TextEditingController();
  final TextEditingController _vaccineNameController = TextEditingController();
  final TextEditingController _vaccinationDateController =
  TextEditingController();
  final TextEditingController _nextVaccinationDateController =
  TextEditingController();
  int testYear = 2012;
  int testMonth = 0;
  int testDay = 0;

  // final TextEditingController _priceController = TextEditingController();

  List<String> item = [
    'IBH-120',
    'ND',
    'IBD(KILLED)',
    'IBD(INTERMEDIATE)',
    'IBD (PLUS)',
    'H5',
    'ND Lasota',
    'Fowl Pox',
    'IB variant',
    'Live Freeze dried',
    'Immune complex',
    'Chicken infectious Anaemia',
    'EDS',
    'Hydro',
    'H9',
    'ND live'
  ];

  final CollectionReference _products =
  FirebaseFirestore.instance.collection('Schedule');
  final email = FirebaseAuth.instance.currentUser!.email;


  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          String? dropdownValue = item.first;
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery
                    .of(ctx)
                    .viewInsets
                    .bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //folk number
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    autofocus: false,
                    decoration: const InputDecoration(
                      labelText: 'Folk Number',
                      hintText: 'Enter Total Folk Number',
                      labelStyle: TextStyle(fontSize: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      errorStyle:
                      TextStyle(color: Colors.redAccent, fontSize: 15),
                    ),
                    controller: _flockNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Email';
                      } else if (!value.contains('@')) {
                        return 'Please Enter Valid Email';
                      }
                      return null;
                    },
                  ),
                ),

                //breed name
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    autofocus: false,
                    decoration: const InputDecoration(
                      labelText: 'Breed Name',
                      hintText: 'Enter Breed Name',
                      labelStyle: TextStyle(fontSize: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      errorStyle:
                      TextStyle(color: Colors.redAccent, fontSize: 15),
                    ),
                    controller: _breadNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Email';
                      } else if (!value.contains('@')) {
                        return 'Please Enter Valid Email';
                      }
                      return null;
                    },
                  ),
                ),

                //vaccination name
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: DropdownButtonFormField(

                    items: item.map(
                            (e) => DropdownMenuItem(value: e, child: Text(e),)
                    ).toList(),
                    onChanged: (val) {
                      setState(() {
                        dropdownValue = val as String;
                        _vaccineNameController.text = dropdownValue!;
                        print(_vaccineNameController.text);
                      });
                    },
                    value: dropdownValue,
                  ),
                ),

                ////vaccination date
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0.0),
                  child: TextFormField(
                    autofocus: false,
                    controller: _vaccinationDateController,
                    decoration: const InputDecoration(
                        hintText: 'Select Vaccination Date',
                        labelText: 'Select Vaccination Date',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        )
                    ),
                    readOnly: true,
                    onTap: () async {
                      var date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2012),
                          lastDate: DateTime(2030)
                      );
                      setState(() {
                        if (date != null) {
                          var myYear = int.parse('${date.year}');
                          assert(myYear is int);
                          testYear = myYear;

                          var myMonth = int.parse('${date.month}');
                          assert(myMonth is int);
                          testMonth = myMonth;

                          var myDay = int.parse('${date.day}');
                          assert(myDay is int);
                          testDay = myDay;

                          _vaccinationDateController.text = "${date
                              .day}/${date.month}/${date.year}";
                        }
                      });
                    },
                  ),
                ),

                //next vaccination date
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    autofocus: false,
                    controller: _nextVaccinationDateController,
                    decoration: const InputDecoration(
                        hintText: 'Next Vaccination Date',
                        labelText: 'Next Vaccination Date',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        )
                    ),
                    readOnly: true,
                    // onChanged: (content) {
                    //   _nextDateController.text = "${date.day} - ${date.month} - ${date.year}";
                    // },
                    onTap: () async {
                      final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(testYear, testMonth, testDay),
                          lastDate: DateTime(2030)
                      );
                      setState(() {
                        if (date != null) {
                          _nextVaccinationDateController.text = "${date
                              .day}/${date.month}/${date.year}";
                        }
                      });
                    },
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Create'),
                  onPressed: () async {
                    final String FlockName = _flockNameController.text;
                    final String BreadName = _breadNameController.text;
                    final String VaccineName = _vaccineNameController.text;
                    final String VaccinattionDate =
                        _vaccinationDateController.text;
                    final String NextVaccinationDate =
                        _nextVaccinationDateController.text;

                    if (FlockName != null) {
                      await _products.add({
                        "user_email": email,
                        "Flock_Name": FlockName,
                        "BreadName": BreadName,
                        "VaccineName": VaccineName,
                        "VaccinattionDate": VaccinattionDate,
                        "NextVaccinationDate": NextVaccinationDate
                      });

                      _flockNameController.text = '';
                      _breadNameController.text = '';
                      _vaccineNameController.text = '';
                      _vaccinationDateController.text = '';
                      _nextVaccinationDateController.text = '';
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _flockNameController.text = documentSnapshot['Flock_Name'];
      _breadNameController.text = documentSnapshot['BreadName'];
      _vaccineNameController.text = documentSnapshot['VaccineName'];
      _vaccinationDateController.text = documentSnapshot['VaccinattionDate'];
      _nextVaccinationDateController.text =
      documentSnapshot['NextVaccinationDate'];
      // _priceController.text = documentSnapshot['price'].toString();
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          String? dropdownValue = item.first;
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery
                    .of(ctx)
                    .viewInsets
                    .bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    autofocus: false,
                    decoration: const InputDecoration(
                      labelText: 'Folk Number',
                      hintText: 'Enter Total Folk Number',
                      labelStyle: TextStyle(fontSize: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      errorStyle:
                      TextStyle(color: Colors.redAccent, fontSize: 15),
                    ),
                    controller: _flockNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Email';
                      } else if (!value.contains('@')) {
                        return 'Please Enter Valid Email';
                      }
                      return null;
                    },
                  ),
                ),
                //breed name
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    autofocus: false,
                    decoration: const InputDecoration(
                      labelText: 'Breed Name',
                      hintText: 'Enter Breed Name',
                      labelStyle: TextStyle(fontSize: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      errorStyle:
                      TextStyle(color: Colors.redAccent, fontSize: 15),
                    ),
                    controller: _breadNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Email';
                      } else if (!value.contains('@')) {
                        return 'Please Enter Valid Email';
                      }
                      return null;
                    },
                  ),
                ),

                //vaccination name
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: DropdownButtonFormField(

                    items: item.map(
                            (e) => DropdownMenuItem(value: e, child: Text(e),)
                    ).toList(),
                    onChanged: (val) {
                      setState(() {
                        dropdownValue = val as String;
                        _vaccineNameController.text = dropdownValue!;
                        print(_vaccineNameController.text);
                      });
                    },
                    value: dropdownValue,
                  ),
                ),

                ////vaccination date
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0.0),
                  child: TextFormField(
                    autofocus: false,
                    controller: _vaccinationDateController,
                    decoration: const InputDecoration(
                        hintText: 'Select Vaccination Date',
                        labelText: 'Select Vaccination Date',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        )
                    ),
                    readOnly: true,
                    onTap: () async {
                      var date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2012),
                          lastDate: DateTime(2030)
                      );
                      setState(() {
                        if (date != null) {
                          var myYear = int.parse('${date.year}');
                          assert(myYear is int);
                          testYear = myYear;

                          var myMonth = int.parse('${date.month}');
                          assert(myMonth is int);
                          testMonth = myMonth;

                          var myDay = int.parse('${date.day}');
                          assert(myDay is int);
                          testDay = myDay;

                          _vaccinationDateController.text = "${date
                              .day}/${date.month}/${date.year}";
                        }
                      });
                    },
                  ),
                ),

                //next vaccination date
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    autofocus: false,
                    controller: _nextVaccinationDateController,
                    decoration: const InputDecoration(
                        hintText: 'Next Vaccination Date',
                        labelText: 'Next Vaccination Date',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        )
                    ),
                    readOnly: true,
                    // onChanged: (content) {
                    //   _nextDateController.text = "${date.day} - ${date.month} - ${date.year}";
                    // },
                    onTap: () async {
                      final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(testYear, testMonth, testDay),
                          lastDate: DateTime(2030)
                      );
                      setState(() {
                        if (date != null) {
                          _nextVaccinationDateController.text = "${date
                              .day}/${date.month}/${date.year}";
                        }
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Update'),
                  onPressed: () async {
                    final String FlockName = _flockNameController.text;
                    final String BreadName = _breadNameController.text;
                    final String VaccineName = _vaccineNameController.text;
                    final String VaccinattionDate =
                        _vaccinationDateController.text;
                    final String NextVaccinationDate =
                        _nextVaccinationDateController.text;
                    final double? price =
                    double.tryParse(_flockNameController.text);
                    if (price != null) {
                      await _products.doc(documentSnapshot!.id).update({
                        "Flock_Name": FlockName,
                        "BreadName": BreadName,
                        "VaccineName": VaccineName,
                        "VaccinattionDate": VaccinattionDate,
                        "NextVaccinationDate": NextVaccinationDate
                      });
                      _flockNameController.text = '';
                      _breadNameController.text = '';
                      _vaccineNameController.text = '';
                      _vaccinationDateController.text = '';
                      _nextVaccinationDateController.text = '';
                      // _priceController.text = '';
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  Future<void> _delete(String productId) async {
    await _products.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a product')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          title: const Text('Manage Schedule'),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('Schedule')
                .where('user_email', isEqualTo: email)
                .get(),
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
                    child: ListTile(
                      //title: Text(documentSnapshot['Flock_Name']),
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
                          )
                        ],
                      ),
                      // subtitle: Text(documentSnapshot['BreadName']),
                      // title: Text(documentSnapshot['VaccineName']),
                      // title: Text(documentSnapshot['VaccinattionDate']),
                      subtitle: Row(
                        children: [
                          const Text('Next Vaccination Date:  ',style: TextStyle(fontWeight: FontWeight.bold),),
                          Text(documentSnapshot['NextVaccinationDate']),
                        ],
                      ),
                      //subtitle: Text(documentSnapshot['price'].toString()),

                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () => _update(documentSnapshot)),
                            IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () => _delete(documentSnapshot.id)),
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
// Add new product
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.deepPurpleAccent,
          onPressed: () => _create(),
          icon: const Icon(Icons.add_box),
          label: const Text("Add Schedule"),
        ),
        );
  }
}
