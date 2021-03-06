import 'package:diplom/business_logic_layer/profile_screen_cubit.dart';
import 'package:diplom/user_interface_layer/widgets/custom_text_form.dart';
import 'package:diplom/user_interface_layer/widgets/custom_text_form_phone.dart';
import 'package:diplom/user_interface_layer/widgets/profile_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum AuthState { auth, register }

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController patronymicController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  late final ProfileScreenCubit _cubit;
  AuthState authState = AuthState.auth;

  get maskFormatter => null;

  @override
  void initState() {
    _cubit = BlocProvider.of<ProfileScreenCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileScreenCubit, ProfileScreenState>(
      bloc: _cubit,
      builder: (context, state) {
        if (state.user == null) {
          return Column(
            children: [
              SizedBox(
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            authState = AuthState.auth;
                          });
                        },
                        child: Container(
                          color: authState == AuthState.auth
                              ? Colors.green
                              : Colors.white,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: authState == AuthState.auth
                                  ? const BorderRadius.only(
                                      topRight: Radius.circular(25))
                                  : const BorderRadius.only(
                                      bottomRight: Radius.circular(25)),
                              color: authState == AuthState.auth
                                  ? Colors.white
                                  : Colors.green,
                            ),
                            child: Center(
                              child: Text(
                                '????????',
                                style: TextStyle(
                                    color: authState == AuthState.auth
                                        ? Colors.black
                                        : Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            authState = AuthState.register;
                          });
                        },
                        child: Container(
                          color: authState == AuthState.auth
                              ? Colors.white
                              : Colors.green,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: authState == AuthState.auth
                                  ? const BorderRadius.only(
                                      bottomLeft: Radius.circular(25))
                                  : const BorderRadius.only(
                                      topLeft: Radius.circular(25)),
                              color: authState == AuthState.auth
                                  ? Colors.green
                                  : Colors.white,
                            ),
                            child: Center(
                              child: Text(
                                '??????????????????????',
                                style: TextStyle(
                                    color: authState == AuthState.auth
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              authState == AuthState.auth
                  ? Expanded(
                      child: Center(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  MediaQuery.of(context).size.width > 300
                                      ? const Padding(
                                          padding: EdgeInsets.all(15.0),
                                          child: Text('????????',
                                              style: TextStyle(fontSize: 30)),
                                        )
                                      : const SizedBox(),
                                  CustomTextForm(
                                      label: "Email",
                                      controller: emailController),
                                  const SizedBox(height: 15),
                                  CustomTextForm(
                                      label: "????????????",
                                      controller: passController,
                                      pass: true),
                                  ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        _cubit.authFire(
                                          email: emailController.text,
                                          password: passController.text,
                                          context: context,
                                        );
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.green),
                                    child: const Text("????????"),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Expanded(
                      child: Center(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  MediaQuery.of(context).size.width > 300
                                      ? const Padding(
                                          padding: EdgeInsets.all(15.0),
                                          child: Text('??????????????????????',
                                              style: TextStyle(fontSize: 30)),
                                        )
                                      : const SizedBox(),
                                  CustomTextForm(
                                      label: "Email",
                                      controller: emailController),
                                  const SizedBox(height: 15),
                                  CustomTextForm(
                                      label: "????????????",
                                      controller: passController,
                                      pass: true),
                                  const SizedBox(height: 15),
                                  CustomTextForm(
                                      label: "??????????????",
                                      controller: surnameController),
                                  const SizedBox(height: 15),
                                  CustomTextForm(
                                      label: "??????", controller: nameController),
                                  const SizedBox(height: 15),
                                  CustomTextForm(
                                      label: "????????????????",
                                      controller: patronymicController),
                                  const SizedBox(height: 15),
                                  CustomTextForm(
                                      label: "??????????",
                                      controller: addressController),
                                  const SizedBox(height: 15),
                                  CustomTextFormPhone(
                                    label: "??????????????",
                                    controller: phoneController,
                                    textInputType: TextInputType.number,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        _cubit.registerFire(
                                          email: emailController.text,
                                          password: passController.text,
                                          context: context,
                                          surname: surnameController.text,
                                          name: nameController.text,
                                          patronymic: patronymicController.text,
                                          address: addressController.text,
                                          phone: phoneController.text,
                                          projectId: [],
                                        );
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.green),
                                    child: const Text("??????????????????????"),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
            ],
          );
        } else {
          surnameController.text = state.userData!.surname;
          nameController.text = state.userData!.name;
          patronymicController.text = state.userData!.patronymic;
          addressController.text = state.userData!.address;
          phoneController.text = state.userData!.phone;
          return Scaffold(
            appBar: MediaQuery.of(context).size.width > 300
                ? AppBar(
                    backgroundColor: Colors.green,
                    title: const Text('??????????????????'),
                    centerTitle: true,
                  )
                : const PreferredSize(
                    child: SizedBox(), preferredSize: Size(0, 0)),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  ProfileRow(
                      label: '??????????????',
                      controller: surnameController,
                      onTap: refactorUserData),
                  ProfileRow(
                      label: '??????',
                      controller: nameController,
                      onTap: refactorUserData),
                  ProfileRow(
                      label: '????????????????',
                      controller: patronymicController,
                      onTap: refactorUserData),
                  ProfileRow(
                      label: '??????????',
                      maxLines: 3,
                      minLines: 1,
                      maxLength: 65,
                      controller: addressController,
                      onTap: refactorUserData),
                  ProfileRow(
                      label: '??????????????',
                      maxLines: 2,
                      minLines: 1,
                      inputFormatters: [maskFormatter],
                      controller: phoneController,
                      onTap: refactorUserData),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  void refactorUserData() {
    _cubit.refactorUserData(
      surname: surnameController.text,
      name: nameController.text,
      patronymic: patronymicController.text,
      address: addressController.text,
      phone: phoneController.text,
      uid: _cubit.state.userData!.uid,
      projectId: _cubit.state.userData!.projectIdList,
    );
  }
}
