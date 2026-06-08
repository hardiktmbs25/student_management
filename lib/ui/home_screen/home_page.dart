import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/student/student_bloc.dart';
import 'add_student.dart';
import 'edit_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<StudentBloc>().add(StudentLoadingEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding:EdgeInsets.only(bottom: 40,right: 20),
        child: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return AddStudent();
                },
              ),
            );
          },
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xffffffff)),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff00beff), Color(0xff0043c3)],
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Text(
              'View Student',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xffffffff),
              ),
            ),
            IconButton(
              onPressed: () {
                context.read<StudentBloc>().add(SyncIntoFirebase());
                context.read<StudentBloc>().add(StudentLoadingEvent());
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Data Sync Successfully")));
              },
              icon: Icon(Icons.sync),
            ),
          ],
        ),
      ),
      body: BlocBuilder<StudentBloc, StudentState>(
        builder: (context, state) {
          if (state is StudentLoading) {
            return Column(
              mainAxisAlignment: .center,
              children: [
                Center(child: CircularProgressIndicator()),
                TextButton(
                  onPressed: () {
                    context.read<StudentBloc>().add(StudentLoadingEvent());
                  },
                  child: Text("retry"),
                ),
              ],
            );
          }
          if (state is StudentLoaded) {
            return state.students.length ==0 ? Center(child: Text("No Data Added"),) :ListView.builder(
              itemCount: state.students.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onLongPress: () {
                    deleteConformation(state.students[index].id);
                  },
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return EditPage(
                            id: state.students[index].id,
                            name: state.students[index].Name,
                            Class: state.students[index].Class,
                            rollNo: state.students[index].RollNo,
                          );
                        },
                      ),
                    );
                  },
                  trailing:
                      Icon(state.students[index].isSyncd?Icons.cloud:Icons.cloud_off,color: state.students[index].isSyncd?Color(
                          0xff08ba01):Color(0xfffd0000),),
                  leading: CircleAvatar(child: Icon(Icons.person)),
                  title: Text(state.students[index].Name),
                  subtitle: Column(
                    children: [
                      Row(
                        children: [
                          Text("Class: ",style: TextStyle(color: Color(0xff000000),fontWeight: FontWeight.w600),),
                          Text(state.students[index].Class),
                          SizedBox(width: 7,),
                          Text("Roll No: ",style: TextStyle(color: Color(0xff000000),fontWeight: FontWeight.w600)),
                          Text(state.students[index].RollNo.toString()),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return Column(
            children: [
              Text("Data Does Not Loaded"),
              TextButton(
                onPressed: () {
                  context.read<StudentBloc>().add(StudentLoadingEvent());
                },
                child: Text("retry"),
              ),
            ],
          );
        },
      ),
    );
  }

  void deleteConformation(String id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Delete Student"),
          content: Text("Are you sure you want to delete this student?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                context.read<StudentBloc>().add(DeleteStudentEvent(id));
                Navigator.pop(context);
              },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}
