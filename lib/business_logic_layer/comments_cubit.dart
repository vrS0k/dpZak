import 'package:diplom/data_layer/models/comment_model.dart';
import 'package:diplom/data_layer/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../user_interface_layer/widgets/dialog_widget.dart';

enum CommentsStatus { loading, data, failure }

class CommentsState {
  CommentsState({required this.status, this.comments});

  final List<CommentModel>? comments;
  final CommentsStatus status;
}

class CommentsCubit extends Cubit<CommentsState> {
  CommentsCubit({required this.firebaseRepository}) : super(CommentsState(status: CommentsStatus.loading));

  final FirebaseRepository firebaseRepository;

  Future<void> getComments(String projectId) async {
    try {
      List<CommentModel> list = await firebaseRepository.getComments(projectId);
      emit(CommentsState(status: CommentsStatus.data, comments: list));
    } catch (e) {
      emit(CommentsState(status: CommentsStatus.failure));
    }
  }

  Future<void> addComment({
    required String comment,
    required String grade,
    required String projectId,
    required String authorSurname,
    required String authorName,
    required String authorUid,
    required BuildContext context,
  }) async {
    String result;
    try {
      await firebaseRepository.addComment(
        comment: comment,
        grade: grade,
        projectId: projectId,
        authorSurname: authorSurname,
        authorName: authorName,
        authorUid: authorUid,
      );
      FocusScope.of(context).unfocus();
      result = 'Комментарий добавлен';
      getComments(projectId);
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
