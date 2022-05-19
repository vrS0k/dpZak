import 'package:diplom/business_logic_layer/create_screen_cubit.dart';
import 'package:diplom/data_layer/repository/repository.dart';
import 'package:flutter/material.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final CreateScreenCubit _cubit = CreateScreenCubit(firebaseRepository: FirebaseRepository());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            TextFormField(
              controller: _cubit.state.nameController,
              decoration: InputDecoration(
                labelText: "Name",
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    _cubit.state.nameController.clear();
                  },
                  icon: const Icon(Icons.clear),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: _cubit.state.dataController,
              decoration: InputDecoration(
                labelText: "Date",
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    _cubit.state.dataController.clear();
                  },
                  icon: const Icon(Icons.clear),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextFormField(
              maxLines: 10,
              controller: _cubit.state.informationController,
              decoration: InputDecoration(
                labelText: "Information",
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    _cubit.state.informationController.clear();
                  },
                  icon: const Icon(Icons.clear),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _cubit.addProject(
                  name: _cubit.state.nameController.text,
                  date: _cubit.state.dataController.text,
                  info: _cubit.state.informationController.text,
                  context: context,
                );
              },
              child: const Text("Create project"),
            ),
          ],
        ),
      ),
    );
  }
}
