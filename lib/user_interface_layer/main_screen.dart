import 'package:diplom/business_logic_layer/main_screen_cubit.dart';
import 'package:diplom/user_interface_layer/widgets/project_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final MainScreenCubit _cubit;

  @override
  void initState() {
    _cubit = BlocProvider.of<MainScreenCubit>(context);
    _cubit.getProjects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainScreenCubit, MainScreenState>(
      bloc: _cubit,
      builder: (context, state) {
        switch (state.status) {
          case MainScreenStatus.loading:
            return Container();
          case MainScreenStatus.failure:
            return Container();
          case MainScreenStatus.data:
            return SingleChildScrollView(
              child: Column(
                children: state.projectList!.map((e) => ProjectWidget(project: e)).toList(),
              ),
            );
          default:
            return Container();
        }
      },
    );
  }
}
