import 'package:diplom/data_layer/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../user_interface_layer/widgets/dialog_widget.dart';

class CreateScreenState {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dataController = TextEditingController();
  final TextEditingController informationController = TextEditingController();
}

class CreateScreenCubit extends Cubit<CreateScreenState> {
  CreateScreenCubit({required this.firebaseRepository}) : super(CreateScreenState());

  final FirebaseRepository firebaseRepository;

  Future<void> addProject({
    required String name,
    required String date,
    required String info,
    required BuildContext context,
  }) async {
    String result;
    try {
      await firebaseRepository.addProject(name: name, date: date, info: info);
      state.nameController.clear();
      state.dataController.clear();
      state.informationController.clear();
      FocusScope.of(context).unfocus();
      result = 'Проект добавлен';
    } catch (e) {
      result = 'Произошла ошибка';
    }
    showDialog(
      context: context,
      builder: (_) {
        return CustomDialog(text: result);
      },
    );
  }
}
