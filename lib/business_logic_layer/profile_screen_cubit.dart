import 'package:diplom/data_layer/repository/repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../user_interface_layer/widgets/dialog_widget.dart';

class ProfileScreenState {
  ProfileScreenState({this.user});

  final UserCredential? user;

  ProfileScreenState copyWith({UserCredential? user}) {
    return ProfileScreenState(user: user ?? this.user);
  }
}

class ProfileScreenCubit extends Cubit<ProfileScreenState> {
  ProfileScreenCubit({required this.firebaseRepository}) : super(ProfileScreenState());

  final FirebaseRepository firebaseRepository;

  Future<void> authFire({required String email, required String password, required BuildContext context}) async {
    String errorMessage = "Произошла ошибка";
    try {
      final UserCredential user = await firebaseRepository.authFire(
        email: email,
        password: password,
      );
      emit(state.copyWith(user: user));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        errorMessage = 'Для этого адреса электронной почты не найдено ни одного пользователя.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Для этого пользователя указан неверный пароль.';
      } else {
        errorMessage = e.message.toString();
      }
      showDialog(
        context: context,
        builder: (_) {
          return CustomDialog(text: errorMessage);
        },
      );
    } catch (e) {
      errorMessage = e.toString();
      showDialog(
        context: context,
        builder: (_) {
          return CustomDialog(text: errorMessage);
        },
      );
    }
  }

  Future<void> registerFire({
    required String email,
    required String password,
    required BuildContext context,
    required String surname,
    required String name,
    required String patronymic,
    required String address,
    required String phone,
  }) async {
    String errorMessage = "Произошла ошибка";
    try {
      final UserCredential user = await firebaseRepository.registerFire(
        email: email,
        password: password,
      );
      await firebaseRepository.addUser(
        uid: user.user!.uid,
        surname: surname,
        name: name,
        patronymic: patronymic,
        address: address,
        phone: phone,
      );
      emit(state.copyWith(user: user));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        errorMessage = "Предоставленный пароль слишком слаб.";
      } else if (e.code == 'email-already-in-use') {
        errorMessage = "Учетная запись для этого адреса электронной почты уже существует.";
      } else {
        errorMessage = e.message.toString();
      }
      showDialog(
        context: context,
        builder: (_) {
          return CustomDialog(text: errorMessage);
        },
      );
    } catch (e) {
      errorMessage = e.toString();
      showDialog(
        context: context,
        builder: (_) {
          return CustomDialog(text: errorMessage);
        },
      );
    }
  }
}
