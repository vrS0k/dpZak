import 'package:diplom/data_layer/models/project_model.dart';
import 'package:diplom/data_layer/models/screen_status.dart';
import 'package:diplom/data_layer/repository/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreenState {
  MainScreenState({required this.status, this.projectList});

  final List<ProjectModel>? projectList;
  final ScreenStatus status;
}

class MainScreenCubit extends Cubit<MainScreenState> {
  MainScreenCubit({required this.firebaseRepository}) : super(MainScreenState(status: ScreenStatus.loading));

  final FirebaseRepository firebaseRepository;

  Future<void> getProjects () async {
    try{
      List<ProjectModel> list = await firebaseRepository.getProject();
      emit(MainScreenState(status: ScreenStatus.data, projectList: list));
    } catch (e) {
      emit(MainScreenState(status: ScreenStatus.failure));
    }
  }
}
