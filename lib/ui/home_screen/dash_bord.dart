import 'package:flutter/material.dart';
import 'package:student_management_app/ui/home_screen/add_student.dart';
import 'package:student_management_app/ui/home_screen/home_page.dart';
import '../start_screen/login_screen.dart';

class DashBord extends StatefulWidget {
  const DashBord({super.key});

  @override
  State<DashBord> createState() => _DashBordState();
}

class _DashBordState extends State<DashBord> {
  List<String> images = [
    'assets/images/students.png!f305cw',
    'assets/images/student2.png!f305cw',
    'assets/images/student3.png!f305cw',
    'assets/images/student4.png!f305cw',
    'assets/images/student6.png!f305cw',
    'assets/images/student5.jpg!f305cw',
  ];
  List<String> Name = [
    'Student List',
    'Student Add',
    'Employee List',
    'Employee Add',
    'Firebase List',
    'Firebase Add',
  ];
  List<Widget> pages = [
    HomePage(),
    AddStudent(),
    HomePage(),
    AddStudent(),
    HomePage(),
    AddStudent(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Text(
              'DashBord',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: Color(0xffffffff),
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              icon: Icon(Icons.logout, color: Color(0xffffffff)),
            ),
          ],
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [ Color(0xff0042c3),Color(0xff00beff)],
            ),
          ),
        ),
      ),
      body: GridView.builder(
        padding: EdgeInsets.only(top: 30, left: 10, right: 10),
        itemCount: 6,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 20,
          crossAxisSpacing: 10,
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => pages[index]),
            ).then((_) {
              setState(() {});
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            height: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Color(0xff7e7e7e),blurRadius: 5),
              ],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Color(0xff01124e)),
            ),
            child: Column(
              children: [
                Container(
                  height: 120,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    image: DecorationImage(image: AssetImage(images[index])),
                  ),
                ),
                Spacer(),
                Text(
                  Name[index],
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff01124e),
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
