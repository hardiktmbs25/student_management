import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/student_model.dart';

class StudentLiveData {
  Future<void> addData(StudentModel student) async{
    await FirebaseFirestore.instance.collection("students").add(student.toJson());
  }
  Future<void> updateData(StudentModel student) async{
    final data = await FirebaseFirestore.instance.collection("students").where("id",isEqualTo: student.id).get();
    if(data.docs.isEmpty){
      await FirebaseFirestore.instance.collection("students").add(student.toJson());
    }else{
      await data.docs.first.reference.update(student.toJson());
    }
  }
  Future<void> deleteData(String id) async{
    final data = await FirebaseFirestore.instance.collection("students").where("id",isEqualTo: id).get();
    if(data.docs.isEmpty){
      print("Already Deleted");


    }else{
      await data.docs.first.reference.delete();
    }
  }
}