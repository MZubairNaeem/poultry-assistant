import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          children: List.generate(5, (index) {
            return Center(child: SelectCard(choice: choices[index], color: Colors.cyan,));
          })
        ),
      ),
    );
  }
}

class Choice {
  const Choice({ required this.title, required this.icon});

  final String title;
  final IconData icon;

}

const List<Choice> choices = <Choice>[
  Choice( title: 'Schedule Management', icon: Icons.add),
  Choice( title: 'Breeds', icon: Icons.contacts),
  Choice( title: 'Disease', icon: Icons.map),
  Choice( title: 'Daily Care', icon: Icons.phone),
  Choice( title: 'In Progress', icon: Icons.camera_alt),
];


class SelectCard extends StatelessWidget {
  const SelectCard({ Key? key, required this.choice, required this.color,}) : super(key: key);
  final Choice choice;
  final Color color;


  @override
  Widget build(BuildContext context) {
    return Card(
        child: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[
                Container(
                  color: color,
                    child: Icon(
                  choice.icon,
                  size: 50.0,
                )),
                Text(
                  choice.title,
                ),
              ]),
        ));
  }
}
