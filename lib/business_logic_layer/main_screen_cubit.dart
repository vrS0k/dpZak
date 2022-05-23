import 'package:diplom/data_layer/models/project_model.dart';
import 'package:diplom/data_layer/repository/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum MainScreenStatus { loading, data, failure }

class MainScreenState {
  MainScreenState({required this.status, this.projectList});

  final List<ProjectModel>? projectList;
  final MainScreenStatus status;
}

class MainScreenCubit extends Cubit<MainScreenState> {
  MainScreenCubit({required this.firebaseRepository}) : super(MainScreenState(status: MainScreenStatus.loading));

  final FirebaseRepository firebaseRepository;

  Future<void> getProjects () async {
    try{
      List<ProjectModel> list = await firebaseRepository.getProject();
      emit(MainScreenState(status: MainScreenStatus.data, projectList: list));
    } catch (e) {
      emit(MainScreenState(status: MainScreenStatus.failure));
    }
  }
}
