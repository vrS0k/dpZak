import 'package:diplom/business_logic_layer/profile_screen_cubit.dart';
import 'package:diplom/user_interface_layer/widgets/custom_text_form.dart';
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
                          color: authState == AuthState.auth ? Colors.blue : Colors.white,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: authState == AuthState.auth
                                  ? const BorderRadius.only(topRight: Radius.circular(25))
                                  : const BorderRadius.only(bottomRight: Radius.circular(25)),
                              color: authState == AuthState.auth ? Colors.white : Colors.blue,
                            ),
                            child: Center(
                              child: Text(
                                'Вход',
                                style: TextStyle(color: authState == AuthState.auth ? Colors.black : Colors.white),
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
                          color: authState == AuthState.auth ? Colors.white : Colors.blue,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: authState == AuthState.auth
                                  ? const BorderRadius.only(bottomLeft: Radius.circular(25))
                                  : const BorderRadius.only(topLeft: Radius.circular(25)),
                              color: authState == AuthState.auth ? Colors.blue : Colors.white,
                            ),
                            child: Center(
                              child: Text(
                                'Регистрация',
                                style: TextStyle(color: authState == AuthState.auth ? Colors.white : Colors.black),
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
                                  const Padding(
                                    padding: EdgeInsets.all(15.0),
                                    child: Text('Вход', style: TextStyle(fontSize: 30)),
                                  ),
                                  CustomTextForm(label: "Email", controller: emailController),
                                  const SizedBox(height: 15),
                                  CustomTextForm(label: "Пароль", controller: passController),
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
                                    child: const Text("Вход"),
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
                                  const Padding(
                                    padding: EdgeInsets.all(15.0),
                                    child: Text('Регистрация', style: TextStyle(fontSize: 30)),
                                  ),
                                  CustomTextForm(label: "Email", controller: emailController),
                                  const SizedBox(height: 15),
                                  CustomTextForm(label: "Пароль", controller: passController),
                                  const SizedBox(height: 15),
                                  CustomTextForm(label: "Фамилия", controller: surnameController),
                                  const SizedBox(height: 15),
                                  CustomTextForm(label: "Имя", controller: nameController),
                                  const SizedBox(height: 15),
                                  CustomTextForm(label: "Отчество", controller: patronymicController),
                                  const SizedBox(height: 15),
                                  CustomTextForm(label: "Адресс", controller: addressController),
                                  const SizedBox(height: 15),
                                  CustomTextForm(label: "Телефон", controller: phoneController),
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
                                        );
                                      }
                                    },
                                    child: const Text("Регистрация"),
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
          return Container();
        }
      },
    );
  }
}