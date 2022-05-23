import 'package:diplom/business_logic_layer/create_screen_cubit.dart';
import 'package:diplom/user_interface_layer/widgets/custom_text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  late final CreateScreenCubit _cubit;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _cubit = BlocProvider.of<CreateScreenCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextForm(label: "Name", controller: _cubit.state.nameController),
              const SizedBox(height: 15),
              CustomTextForm(label: "Date", controller: _cubit.state.dataController),
              const SizedBox(height: 15),
              CustomTextForm(label: "Information", controller: _cubit.state.informationController),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _cubit.addProject(
                      name: _cubit.state.nameController.text,
                      date: _cubit.state.dataController.text,
                      info: _cubit.state.informationController.text,
                      context: context,
                    );
                  }
                },
                child: const Text("Create project"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
