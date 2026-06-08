part of 'student_bloc.dart';

@immutable
sealed class StudentEvent {}
class AddStudentEvent extends StudentEvent {
  StudentModel student;
  AddStudentEvent(this.student);
}
class UpdateStudentEvent extends StudentEvent {
  StudentModel student;
  UpdateStudentEvent(this.student);
}
class DeleteStudentEvent extends StudentEvent {
  String id;
  DeleteStudentEvent(this.id);
}
class StudentLoadingEvent extends StudentEvent {}
class SyncIntoFirebase extends StudentEvent{}