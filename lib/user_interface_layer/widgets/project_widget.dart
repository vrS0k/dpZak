import 'package:diplom/data_layer/models/project_model.dart';
import 'package:flutter/material.dart';

import '../detail_progect_screen.dart';

class ProjectWidget extends StatelessWidget {
  final ProjectModel project;

  const ProjectWidget({Key? key, required this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => DetailProjectScreen(project: project)));
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                  border: Border.all(color: Colors.green),
                  color: Colors.green),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(project.name, style: const TextStyle(color: Colors.white)),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(project.date, style: const TextStyle(color: Colors.white), textAlign: TextAlign.right,),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
                border: Border.all(color: Colors.green),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(project.info),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
