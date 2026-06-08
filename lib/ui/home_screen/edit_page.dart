import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/student/student_bloc.dart';
import '../../data/model/student_model.dart';

class EditPage extends StatefulWidget {
  String id;
  String name;
  int rollNo;
  String Class;

  EditPage({
    super.key,
    required this.id,
    required this.rollNo,
    required this.name,
    required this.Class,
  });

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController rollNoController = TextEditingController();
  TextEditingController classController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.name;
    rollNoController.text = widget.rollNo.toString();
    classController.text = widget.Class;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xffffffff)),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff00beff), Color(0xff0042c3)],
            ),
          ),
        ),
        title: Text(
          'Edit Student',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xffffffff),
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            SizedBox(height: 10),
            Text(
              "Enter Your student Name :",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
            ),
            SizedBox(height: 5),
            TextField(
              controller: nameController,

              decoration: InputDecoration(
                hintText: 'Name',
                prefixIcon: Icon(Icons.abc),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Enter Your Student RollNo :",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
            ),
            SizedBox(height: 5),
            TextField(
              controller: rollNoController,
              decoration: InputDecoration(
                hintText: 'Roll No',
                prefixIcon: Icon(Icons.numbers),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            Text(
              "Enter Your Class :",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
            ),
            SizedBox(height: 5),
            TextField(
              controller: classController,
              decoration: InputDecoration(
                hintText: 'Class',
                prefixIcon: Icon(Icons.class_rounded),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: .center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffffffff),
                    foregroundColor: Color(0xff0a50fc),
                    minimumSize: Size(150, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(15),
                      side: BorderSide(color: Color(0xff0a50fc)),
                    ),
                  ),
                  onPressed: () {
                    StudentModel student = StudentModel(
                      id: widget.id,
                      Name: nameController.text.trim(),
                      RollNo: int.parse(rollNoController.text.trim()),
                      Class: classController.text.trim(),
                      isSyncd: false,
                      syncMethod: "update",
                    );
                    context.read<StudentBloc>().add(UpdateStudentEvent(student));
                    Navigator.pop(context);
                  },
                  child: Text('Update Student'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
