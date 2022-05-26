import 'dart:developer';
import 'package:diplom/business_logic_layer/user_screen_cubit.dart';
import 'package:diplom/user_interface_layer/widgets/project_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UserScreen extends StatefulWidget {
  final String uid;

  const UserScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late final UserScreenCubit _cubit;

  @override
  void initState() {
    _cubit = BlocProvider.of<UserScreenCubit>(context);
    _cubit.getUserData(uid: widget.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserScreenCubit, UserScreenState>(
      bloc: _cubit,
      builder: (context, state) {
        if (state.userData != null) {
          return Scaffold(
            appBar: AppBar(
              title: Text(state.userData!.surname + " " + state.userData!.name),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        const Text("Фамилия : ", style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(state.userData!.surname),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        const Text("Имя : ", style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(state.userData!.name),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        const Text("Отчество : ", style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(state.userData!.patronymic),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        const Text("Адрес : ", style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(state.userData!.address),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        const Text("Телефон : ", style: TextStyle(fontWeight: FontWeight.bold)),
                        GestureDetector(
                          onTap: () {
                            var url = "tel:${state.userData!.phone}";
                            try {
                              launchUrlString(url);
                            } catch (e) {
                              log(e.toString());
                            }
                          },
                          child: Text(
                            state.userData!.phone,
                            style: const TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(color: Colors.blue, thickness: 1),
                  const Text('Проекты : ', style: TextStyle(fontWeight: FontWeight.bold)),
                  ...state.projects!.map((e) => ProjectWidget(project: e)).toList(),
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(),
          );
        }
      },
    );
  }
}
