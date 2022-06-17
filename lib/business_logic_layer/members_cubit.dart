import 'package:diplom/business_logic_layer/profile_screen_cubit.dart';
import 'package:diplom/data_layer/models/user_model.dart';
import 'package:diplom/data_layer/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../user_interface_layer/widgets/dialog_widget.dart';

enum MembersStatus { loading, data, failure }

class MembersState {
  MembersState({required this.status, this.members});

  final List<UserModel>? members;
  final MembersStatus status;
}

class MembersCubit extends Cubit<MembersState> {
  MembersCubit({required this.firebaseRepository}) : super(MembersState(status: MembersStatus.loading));

  final FirebaseRepository firebaseRepository;

  Future<void> getMembers(String projectId) async {
    try {
      List<UserModel> list = await firebaseRepository.getMembers(projectId);
      emit(MembersState(status: MembersStatus.data, members: list));
    } catch (e) {
      emit(MembersState(status: MembersStatus.failure));
    }
  }

  void clean (){
    emit(MembersState(status: MembersStatus.loading));
  }

  Future<void> addMember({
    required String surname,
    required String name,
    required String patronymic,
    required String address,
    required String phone,
    required String uid,
    required List projectIdList,
    required String projectId,
    required BuildContext context,
  }) async {
    String result;
    try {
      await firebaseRepository.refactorUserData(
        surname: surname,
        name: name,
        patronymic: patronymic,
        address: address,
        phone: phone,
        uid: uid,
        projectId: [...projectIdList, projectId],
      );
      FocusScope.of(context).unfocus();
      result = 'Вы подключились к проекту!';
      getMembers(projectId);
      BlocProvider.of<ProfileScreenCubit>(context).updateUser(uid: uid);
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
