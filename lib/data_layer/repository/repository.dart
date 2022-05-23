import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diplom/data_layer/models/project_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseRepository {
  CollectionReference categories = FirebaseFirestore.instance.collection('projects');
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

  Future<List<ProjectModel>> getProject() async {
    try {
      List<ProjectModel> list = [];
      await categories.get().then(
        (value) {
          for (var element in value.docs) {
            Map mapResponse = element.data() as Map;
            list.add(ProjectModel(
              name: mapResponse["name"],
              date: mapResponse["date"],
              info: mapResponse["info"],
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
        "uid" : uid,
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

  Future<void> addProject({required String name, required String date, required String info}) async {
    try {
      await categories.add({
        "name": name,
        "date": date,
        "info": info,
      });
    } catch (e) {
      log(e.toString());
      throw Exception();
    }
  }
}
