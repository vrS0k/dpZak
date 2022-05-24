import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diplom/data_layer/models/comment_model.dart';
import 'package:diplom/data_layer/models/project_model.dart';
import 'package:diplom/data_layer/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseRepository {
  CollectionReference comments = FirebaseFirestore.instance.collection('comments');
  CollectionReference projects = FirebaseFirestore.instance.collection('projects');
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<UserCredential> authFire({required String email, required String password}) async {
    try {
      final UserCredential user = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return user;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<UserCredential> registerFire({required String email, required String password}) async {
    try {
      final UserCredential user = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return user;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<void> refactorUserData({
    required String surname,
    required String name,
    required String patronymic,
    required String address,
    required String phone,
    required String uid,
  }) async {
    try {
      await users.where("uid", isEqualTo: uid).get().then(
        (value) {
          for (var element in value.docs) {
            users.doc(element.id).set({
              "uid": uid,
              "surname": surname,
              "name": name,
              "patronymic": patronymic,
              "address": address,
              "phone": phone,
            });
          }
        },
      );
    } catch (e) {
      log(e.toString());
      throw Exception();
    }
  }

  Future<List<ProjectModel>> getProjectsBuUid(String uid) async {
    try {
      List<ProjectModel> projectsList = [];
      await projects.where("uid", isEqualTo: uid).get().then(
            (value) {
          for (var element in value.docs) {
            Map mapResponse = element.data() as Map;
            projectsList.add(ProjectModel(
              name: mapResponse["name"],
              date: mapResponse["date"],
              info: mapResponse["info"],
              authorSurname: mapResponse["authorSurname"],
              authorName: mapResponse["authorName"],
              authorUid: mapResponse["authorUid"],
              id: element.id,
            ));
          }
        },
      );
      return projectsList;
    } catch (e) {
      log(e.toString());
      throw Exception();
    }
  }

  Future<UserModel> getUserData(String uid) async {
    try {
      late UserModel user;
      await users.where("uid", isEqualTo: uid).get().then(
        (value) {
          for (var element in value.docs) {
            Map mapResponse = element.data() as Map;
            user = UserModel(
              surname: mapResponse["surname"],
              name: mapResponse["name"],
              patronymic: mapResponse["patronymic"],
              address: mapResponse["address"],
              phone: mapResponse["phone"],
              uid: mapResponse["uid"],
            );
          }
        },
      );
      return user;
    } catch (e) {
      log(e.toString());
      throw Exception();
    }
  }

  Future<List<ProjectModel>> getAllProjects() async {
    try {
      List<ProjectModel> list = [];
      await projects.get().then(
        (value) {
          for (var element in value.docs) {
            Map mapResponse = element.data() as Map;
            list.add(ProjectModel(
              name: mapResponse["name"],
              date: mapResponse["date"],
              info: mapResponse["info"],
              authorSurname: mapResponse["authorSurname"],
              authorName: mapResponse["authorName"],
              authorUid: mapResponse["authorUid"],
              id: element.id,
            ));
          }
        },
      );
      return list;
    } catch (e) {
      log(e.toString());
      throw Exception();
    }
  }

  Future<void> addUser({
    required String surname,
    required String name,
    required String patronymic,
    required String address,
    required String phone,
    required String uid,
  }) async {
    try {
      await users.add({
        "uid": uid,
        "surname": surname,
        "name": name,
        "patronymic": patronymic,
        "address": address,
        "phone": phone,
      });
    } catch (e) {
      log(e.toString());
      throw Exception();
    }
  }

  Future<void> addProject({
    required String name,
    required String date,
    required String info,
    required String authorSurname,
    required String authorName,
    required String authorUid,
  }) async {
    try {
      await projects.add({
        "name": name,
        "date": date,
        "info": info,
        "authorSurname": authorSurname,
        "authorName": authorName,
        "authorUid": authorUid,
      });
    } catch (e) {
      log(e.toString());
      throw Exception();
    }
  }

  Future<List<CommentModel>> getComments(String projectId) async {
    try {
      List<CommentModel> commentsList = [];
      await comments.where("projectId", isEqualTo: projectId).get().then(
            (value) {
          for (var element in value.docs) {
            Map mapResponse = element.data() as Map;
            commentsList.add(CommentModel(
              projectId: mapResponse["projectId"],
              comment: mapResponse["comment"],
              grade: mapResponse["grade"],
              authorSurname: mapResponse["authorSurname"],
              authorName: mapResponse["authorName"],
              authorUid: mapResponse["authorUid"],
            ));
          }
        },
      );
      return commentsList;
    } catch (e) {
      log(e.toString());
      throw Exception();
    }
  }

  Future<void> addComment({
    required String comment,
    required String grade,
    required String projectId,
    required String authorSurname,
    required String authorName,
    required String authorUid,
  }) async {
    try {
      await comments.add({
        "comment": comment,
        "grade": grade,
        "projectId": projectId,
        "authorSurname": authorSurname,
        "authorName": authorName,
        "authorUid": authorUid,
      });
    } catch (e) {
      log(e.toString());
      throw Exception();
    }
  }
}
