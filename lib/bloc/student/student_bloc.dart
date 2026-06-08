import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../data/model/student_model.dart';
import '../../data/repository/student_repository.dart';
part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  final StudentRepository studentRepository;
  StudentBloc(this.studentRepository) : super(StudentInitial()) {
    on<StudentEvent>((event, emit) {
      emit(StudentLoading());
    });
    on<DeleteStudentEvent>((event, emit) async {
      await studentRepository.deleteStudent(event.id);
      emit(StudentLoaded(await studentRepository.getAllTask()));
    });
    on<AddStudentEvent>((event, emit) async {
      await studentRepository.addStudent(event.student);
      emit(StudentLoaded(await studentRepository.getAllTask()));
    });
    on<UpdateStudentEvent>((event, emit) async {
      await studentRepository.updateStudent(event.student);
      emit(StudentLoaded(await studentRepository.getAllTask()));
    });
    on<StudentLoadingEvent>((event, emit) async {
      try{
        List<StudentModel> students = await studentRepository.getAllTask();
        emit(StudentLoaded(students));
      }catch(e){
        emit(StudentError(e.toString()));
      }
    });
    on<SyncIntoFirebase>((event,emit) async{
      await studentRepository.syncData();
      emit(StudentLoaded(await studentRepository.getAllTask()));
    });
  }
}
