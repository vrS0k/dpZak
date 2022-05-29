import 'package:diplom/business_logic_layer/main_screen_cubit.dart';
import 'package:diplom/user_interface_layer/widgets/project_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<String> viewList = [];

  @override
  void initState() {
    SharedPreferences.getInstance().then((value) {
      setState(() {
        viewList = value.getStringList('items') ?? [];
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MediaQuery.of(context).size.width > 300
          ? AppBar(
              title: const Text('Notification Screen'),
              centerTitle: true,
            )
          : const PreferredSize(child: SizedBox(), preferredSize: Size(0, 0)),
      body: SingleChildScrollView(
        child: Column(children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'Проекты, которые вы еще не просматривали',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 21),
            ),
          ),
          ...BlocProvider.of<MainScreenCubit>(context)
              .state
              .projectList!
              .map((e) => viewList.contains(e.id) ? const SizedBox(height: 0, width: 0) : ProjectWidget(project: e))
              .toList(),
        ]),
      ),
    );
  }
}
