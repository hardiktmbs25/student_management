part of 'student_bloc.dart';

@immutable
sealed class StudentState {}

final class StudentInitial extends StudentState {}
class StudentLoading extends StudentState {}
class StudentLoaded extends StudentState {
  List<StudentModel> students;
  StudentLoaded(this.students);
}
class StudentError extends StudentState {
  String error;
  StudentError(this.error);
}

