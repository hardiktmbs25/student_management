import '../firebase/student_live_data.dart';
import '../local/student_local_data.dart';
import '../model/student_model.dart';


class StudentRepository {
  final StudentLocalData local;
  final StudentLiveData liveData;
  StudentRepository({required this.local,required this.liveData});
  Future<List<StudentModel>> getAllTask() async {
    try{
      List<StudentModel> students = await local.getData();
      return students;
    }catch(e){
      print(e.toString());
      return [];
    }
  }
  Future<void> addStudent(StudentModel student) async{
    try{
      await local.addData(student);
    }catch(e){
      print(e.toString());
    }
  }
  Future<void> updateStudent(StudentModel student) async{
    try{
      await local.updateData(student);
    }catch(e){
      print(e.toString());
    }
  }
  Future<void> deleteStudent(String id) async{
    try{
      await local.deleteData(id);
      await liveData.deleteData(id);
    }catch(e){
      print(e.toString());
    }
  }
  Future<void> syncData() async{
    try{
      List<StudentModel> students = await local.getData();
      for(final student in students){
        if(student.isSyncd ==false){
          if(student.syncMethod == "add"){
            student.isSyncd = true;
            student.syncMethod="none";
            await liveData.addData(student);
            await local.updateData(student);
          }
          if(student.syncMethod == "update"){
            student.isSyncd = true;
            student.syncMethod="none";
            await liveData.updateData(student);
            await local.updateData(student);
          }
        }
      }
    }catch(e){
      print(e.toString());
    }
  }

}