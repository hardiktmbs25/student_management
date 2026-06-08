import 'package:hive/hive.dart';
import '../model/student_model.dart';

class StudentLocalData {

  Future<void> addData(StudentModel student) async{
      final box = await Hive.openBox("student");
      box.put(student.id, student.toJson());
  }
   Future<List<StudentModel>> getData() async {
    final box = await Hive.openBox("student");
    List<StudentModel> data = box.values.map((k)=>StudentModel.fromJson(Map<String,dynamic>.from(k))).toList();
    return data;
  }
   Future<void> deleteData(String id) async {
    final box = await Hive.openBox("student");
    box.delete(id);
  }
  Future<void> updateData(StudentModel student1) async{
    final box = await Hive.openBox("student");
    box.put(student1.id,student1.toJson());
  }
}