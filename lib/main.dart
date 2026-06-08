import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_management_app/ui/start_screen/login_screen.dart';
import 'bloc/student/student_bloc.dart';
import 'data/firebase/student_live_data.dart';
import 'data/local/student_local_data.dart';
import 'data/repository/student_repository.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [RepositoryProvider<StudentRepository>(create: (context) => StudentRepository(local: StudentLocalData(),liveData: StudentLiveData()))],
      child: MultiBlocProvider(
        providers: [BlocProvider<StudentBloc>(create: (context) => StudentBloc(context.read<StudentRepository>()),)],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
              colorScheme: .fromSeed(seedColor: Colors.blue),
        ),
        home: LoginScreen(),
      ),
    ),
    );
  }
}
