import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:poultry_assistant/screens/home/cards/schedule_management.dart';
import 'package:url_launcher/url_launcher.dart';

import '../cards/coming_schedule.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  Future<void> launchUrlStart({required String url}) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,),
          children: [
            //schedule management
            GestureDetector(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ScheduleManagement()));
              },
              child: Card(
                color: Colors.deepPurple.shade200,
                margin: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      height: 75, width: 75,
                      "assets/syringe.svg",
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('Schedule Management',style: TextStyle(color: Colors.grey.shade800,fontSize: 16,fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
            ),

            //coming schedule
            GestureDetector(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  const ComingSchedule()));
              },
              child: Card(
                color: Colors.orange.shade300,
                margin: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      height: 75, width: 75,
                      "assets/syringe.svg",
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('Coming Schedule',style: TextStyle(color: Colors.grey.shade800,fontSize: 16,fontWeight: FontWeight.bold),)
                  ],
                ),

              ),
            ),

            //breed
            GestureDetector(
              onTap: (){

              },
              child: Card(
                color: Colors.blueGrey.shade300,
                margin: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      height: 75, width: 75,
                      "assets/syringe.svg",
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('Breeds',style: TextStyle(color: Colors.grey.shade800,fontSize: 16,fontWeight: FontWeight.bold),)
                  ],
                ),

              ),
            ),

            //disease
            GestureDetector(
              onTap: (){

              },
              child: Card(
                color: Colors.green.shade200,
                margin: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      height: 75, width: 75,
                      "assets/syringe.svg",
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('Disease',style: TextStyle(color: Colors.grey.shade800,fontSize: 16,fontWeight: FontWeight.bold),)
                  ],
                ),

              ),
            ),

            //daily care
            GestureDetector(
              onTap: (){

              },
              child: Card(
                color: Colors.blue.shade200,
                margin: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      height: 75, width: 75,
                      "assets/syringe.svg",
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('Daily Care',style: TextStyle(color: Colors.grey.shade800,fontSize: 16,fontWeight: FontWeight.bold),)
                  ],
                ),

              ),
            ),

            //in progress
            GestureDetector(
              onTap: (){

              },
              child: Card(
                color: Colors.red.shade200,
                margin: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      height: 75, width: 75,
                      "assets/syringe.svg",
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('In Progress',style: TextStyle(color: Colors.grey.shade800,fontSize: 16,fontWeight: FontWeight.bold),)
                  ],
                ),

              ),
            ),
          ],
        )
      ),
    );
  }
}
