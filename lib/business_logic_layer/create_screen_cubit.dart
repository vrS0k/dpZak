import 'package:diplom/data_layer/models/screen_status.dart';
import 'package:diplom/data_layer/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../user_interface_layer/widgets/dialog.dart';

class CreateScreenState {
  CreateScreenState({required this.status});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController dataController = TextEditingController();
  final TextEditingController informationController = TextEditingController();
  final ScreenStatus status;
}

class CreateScreenCubit extends Cubit<CreateScreenState> {
  CreateScreenCubit({required this.firebaseRepository}) : super(CreateScreenState(status: ScreenStatus.data));

  final FirebaseRepository firebaseRepository;

  Future<void> addProject({
    required String name,
    required String date,
    required String info,
    required BuildContext context,
  }) async {
    try {
      await firebaseRepository.addProject(name: name, date: date, info: info);
      state.nameController.clear();
      state.dataController.clear();
      state.informationController.clear();
      FocusScope.of(context).unfocus();
      showDialog(
          context: context,
          builder: (_) {
            return const CustomDialog(text: 'Проект добавлен');
          });
    } catch (e) {
      showDialog(
          context: context,
          builder: (_) {
            return const CustomDialog(text: 'Произошла ошибка');
          });
    }
  }
}
