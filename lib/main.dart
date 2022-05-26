import 'package:diplom/business_logic_layer/comments_cubit.dart';
import 'package:diplom/business_logic_layer/create_screen_cubit.dart';
import 'package:diplom/business_logic_layer/main_screen_cubit.dart';
import 'package:diplom/business_logic_layer/members_cubit.dart';
import 'package:diplom/business_logic_layer/profile_screen_cubit.dart';
import 'package:diplom/business_logic_layer/user_screen_cubit.dart';
import 'package:diplom/data_layer/repository/repository.dart';
import 'package:diplom/user_interface_layer/create_screen.dart';
import 'package:diplom/user_interface_layer/main_screen.dart';
import 'package:diplom/user_interface_layer/profile_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final FirebaseRepository _fire = FirebaseRepository();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<MembersCubit>(create: (context) => MembersCubit(firebaseRepository: _fire)),
        BlocProvider<CommentsCubit>(create: (context) => CommentsCubit(firebaseRepository: _fire)),
        BlocProvider<UserScreenCubit>(create: (context) => UserScreenCubit(firebaseRepository: _fire)),
        BlocProvider<ProfileScreenCubit>(create: (context) => ProfileScreenCubit(firebaseRepository: _fire)),
        BlocProvider<MainScreenCubit>(create: (context) => MainScreenCubit(firebaseRepository: _fire)),
        BlocProvider<CreateScreenCubit>(create: (context) => CreateScreenCubit(firebaseRepository: _fire)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const MainScreen(),
    const CreateScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Main",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.create),
                label: "Create",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile",
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
