import 'package:flutter/material.dart';

class CreateSchedule extends StatefulWidget {
  const CreateSchedule({Key? key}) : super(key: key);

  @override
  State<CreateSchedule> createState() => _CreateScheduleState();
}

class _CreateScheduleState extends State<CreateSchedule> {


  final _folkCountController = TextEditingController();
  final _breedNameController = TextEditingController();
  final _vaccinationNameController = TextEditingController();

  @override
  void dispose() {
    _breedNameController.dispose();
    _folkCountController.dispose();
    _vaccinationNameController.dispose();
    super.dispose();
  }

  final item = [
    'IBH-120',
    'ND',
    'IBD(KILLED)',
    'IBD(INTERMEDIATE)',
    'IBD (PLUS)',
    'H5',
    'ND Lasota',
    'Fowl Pox',
    'IB varient',
    'Live Freeze dried',
    'Immune complex',
    'Chicken infectious Anaemia',
    'EDS',
    'Hydro',
    'H9',
    'ND live'
  ];
  String? selectedVal = 'Choose Vaccination';


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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                    value: selectedVal,
                    items: item.map(
                            (e) =>  DropdownMenuItem(child: Text(e), value: e,)
                    ).toList(),
                    onChanged: (val){
                      setState(() {
                        selectedVal = val as String;
                      });
                    }
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
    );
  }
}
