import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/student/student_bloc.dart';
import '../../data/model/student_model.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({super.key});

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  TextEditingController nameController = TextEditingController();
  TextEditingController rollNoController = TextEditingController();
  TextEditingController classController = TextEditingController();
  final createStudent = GlobalKey<FormState>();
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
          'Add Student',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xffffffff),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: EdgeInsets.all(15),
          child: Form(
            key: createStudent,
            child: Column(
              crossAxisAlignment: .start,
              children: [
                SizedBox(height: 10),
                Text(
                  "Enter Your student Name :",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
                SizedBox(height: 5),
                TextFormField(
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "Name is Required";
                    }
                  },
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'Name',
                    prefixIcon: Icon(Icons.abc),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),          ),
                SizedBox(height: 10),
                Text(
                  "Enter Your Student RollNo :",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
                SizedBox(height: 5),
                TextFormField(
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "Roll Number is Required";
                    }
                  },
                  controller: rollNoController,
                  decoration: InputDecoration(
                    hintText: 'Roll No',
                    prefixIcon: Icon(Icons.numbers),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),            keyboardType: TextInputType.number,
                ),
                SizedBox(height: 10),
                Text(
                  "Enter Your Class :",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
                SizedBox(height: 5),
                TextFormField(
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "Class is Required";
                    }
                  },                controller: classController,
                  decoration: InputDecoration(
                    hintText: 'Class',
                    prefixIcon: Icon(Icons.class_rounded),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),          ),
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
                          if(createStudent.currentState!.validate()) {
                            StudentModel student = StudentModel(
                              id: DateTime
                                  .timestamp()
                                  .microsecondsSinceEpoch
                                  .toString(),
                              Name: nameController.text.trim(),
                              RollNo: int.parse(rollNoController.text.trim()),
                              Class: classController.text.trim(),
                              syncMethod: "add",
                            );
                            context.read<StudentBloc>().add(
                                AddStudentEvent(student));
                            Navigator.pop(context);
                          }
                      },
                      child: Text('Add Student'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
