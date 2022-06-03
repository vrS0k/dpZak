import 'dart:developer';
import 'package:diplom/data_layer/models/project_model.dart';
import 'package:diplom/data_layer/models/user_model.dart';
import 'package:diplom/data_layer/repository/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserScreenState {
  UserScreenState({this.projects, this.userData}); // конструктор класса для создания экземпляра класаа

  final UserModel? userData;
  final List<ProjectModel>? projects; // дженерики обозначение элементов в листе

  UserScreenState copyWith({List<ProjectModel>? projects, UserModel? userData}) {
    return UserScreenState(projects: projects ?? this.projects, userData: userData ?? this.userData);
  }
}

class UserScreenCubit extends Cubit<UserScreenState> {
  UserScreenCubit({required this.firebaseRepository}) : super(UserScreenState());

  final FirebaseRepository firebaseRepository;

  Future<void> getUserData({required String uid}) async {
    try {
      final UserModel userData = await firebaseRepository.getUserData(uid);
      final List<ProjectModel> projects = await firebaseRepository.getProjectsBuUid(uid);
      emit(state.copyWith(projects: projects, userData: userData));
    } catch (e) {
      log(e.toString());
    }
  }
}
