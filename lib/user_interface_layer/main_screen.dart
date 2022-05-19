import 'package:diplom/business_logic_layer/create_screen_cubit.dart';
import 'package:diplom/business_logic_layer/main_screen_cubit.dart';
import 'package:diplom/data_layer/models/screen_status.dart';
import 'package:diplom/data_layer/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final MainScreenCubit _cubit = MainScreenCubit(firebaseRepository: FirebaseRepository());

  @override
  void initState() {
    _cubit.getProjects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainScreenCubit, MainScreenState>(
        bloc: _cubit,
        builder: (context, state) {
          switch (state.status) {
            case ScreenStatus.loading:
              return Container();
            case ScreenStatus.failure:
              return Container();
            case ScreenStatus.data:
              return SingleChildScrollView(
                child: Column(
                  children: state.projectList!.map((e) => Text(e.info)).toList(),
                ),
              );
            default:
              return Container();
          }
        });
  }
}
