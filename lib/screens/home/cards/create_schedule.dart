import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../resourse/firestore_method.dart';

class CreateSchedule extends StatefulWidget {
  const CreateSchedule({Key? key}) : super(key: key);

  @override
  State<CreateSchedule> createState() => _CreateScheduleState();
}

class _CreateScheduleState extends State<CreateSchedule> {

  final _folkCountController = TextEditingController();
  final _dateController = TextEditingController();
  final _nextDateController = TextEditingController();
  final _breedNameController = TextEditingController();
  final _vaccinationNameController = TextEditingController();

  @override
  void dispose() {
    _breedNameController.dispose();
    _folkCountController.dispose();
    _vaccinationNameController.dispose();
    _nextDateController.dispose();
    _dateController.dispose();
    super.dispose();
  }


  void postImage(String uid) async {
    try {
      String res = await FirestoreMethods().uploadPost(
          uid,
          _folkCountController.text,
          _breedNameController.text,
          _vaccinationNameController.text,
          _dateController.text,
          _nextDateController.text);
      if (res == "success") {
        print('done');
      } else {

      }
    } catch (e) {
      print(e.toString());
    }
  }

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
  //String? selectedVal = "IBH-120";


  @override
  Widget build(BuildContext context) {
    String? dropdownValue = item.first;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text(
          'Create Schedule',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    'Enter Data',
                    style: TextStyle(fontSize: 42, fontWeight: FontWeight.w600),
                  ),
                ),
                //folk name .////////////////////////////////////////////////////
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
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
                    controller: _folkCountController,
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

                //breed name .////////////////////////////////////////////////////
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
                    controller: _breedNameController,
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

                //drop down vaccination selection
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: DropdownButtonFormField(

                    items: item.map(
                            (e) =>  DropdownMenuItem(value: e,child: Text(e),)
                    ).toList(),
                    onChanged: (val){
                      setState(() {
                        dropdownValue = val as String;
                        _vaccinationNameController.text = dropdownValue!;
                        print(_vaccinationNameController.text);
                      });
                    },
                    value: dropdownValue,
                  ),
                ),

                //Select Vaccination Date///////////////////////////////
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    autofocus: false,
                    controller: _dateController,
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
                        if(date != null){
                          _dateController.text = "${date.day} - ${date.month} - ${date.year}";
                        }
                      });
                    },
                  ),
                ),

                //Next Vaccination Date///////////////////////////////
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    autofocus: false,
                    controller: _nextDateController,
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
                          firstDate: DateTime(2012),
                          lastDate: DateTime(2030)
                      );
                      setState(() {
                        if(date != null){
                          _nextDateController.text = "${date.day} - ${date.month} - ${date.year}";
                        }
                      });
                    },
                  ),
                ),


                //submit button
                GestureDetector(
                  onTap: () {

                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.deepPurpleAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          'Submit',
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
        ),
      ),
    );
  }
}
