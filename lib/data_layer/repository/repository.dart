import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diplom/data_layer/models/project_model.dart';

class FirebaseRepository {
  CollectionReference categories = FirebaseFirestore.instance.collection('projects');

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
