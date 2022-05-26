import 'package:diplom/business_logic_layer/main_screen_cubit.dart';
import 'package:diplom/user_interface_layer/widgets/custom_text_form.dart';
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
  final TextEditingController _searchController = TextEditingController();

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
            return Scaffold(
              appBar: AppBar(
                title: const Text('Main Screen'),
                centerTitle: true,
              ),
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextForm(
                      onChanged: (String value){
                        setState(() {});
                      },
                      controller: _searchController,
                      label: 'Поиск',
                    ),
                  ),
                  const Divider(color: Colors.blue, thickness: 1, height: 20),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: state.projectList!
                            .map((e) =>
                                e.name.contains(_searchController.text) ? ProjectWidget(project: e) : const SizedBox())
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            );
          default:
            return Container();
        }
      },
    );
  }
}
