import 'package:diplom/business_logic_layer/comments_cubit.dart';
import 'package:diplom/business_logic_layer/profile_screen_cubit.dart';
import 'package:diplom/data_layer/models/project_model.dart';
import 'package:diplom/user_interface_layer/user_screen.dart';
import 'package:diplom/user_interface_layer/widgets/custom_text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailProjectScreen extends StatefulWidget {
  final ProjectModel project;

  const DetailProjectScreen({Key? key, required this.project}) : super(key: key);

  @override
  State<DetailProjectScreen> createState() => _DetailProjectScreenState();
}

class _DetailProjectScreenState extends State<DetailProjectScreen> {
  late final ProfileScreenCubit _userCubit;
  late final CommentsCubit _commentsCubit;
  TextEditingController commentController = TextEditingController();
  TextEditingController gradeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _userCubit = BlocProvider.of<ProfileScreenCubit>(context);
    _commentsCubit = BlocProvider.of<CommentsCubit>(context);
    _commentsCubit.getComments(widget.project.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.project.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => UserScreen(
                      uid: widget.project.authorUid,
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    color: Colors.blue.withOpacity(0.2),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("Автор : " + widget.project.authorSurname + " " + widget.project.name),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  const Text(
                    "Название : ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(widget.project.name),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  const Text(
                    "Дата проведения : ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(widget.project.date),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  const Text(
                    "Информация : ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(child: Text(widget.project.info)),
                ],
              ),
            ),
            const Divider(color: Colors.blue, thickness: 1),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Комментарии : ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            BlocBuilder<ProfileScreenCubit, ProfileScreenState>(
              bloc: _userCubit,
              builder: (context, state) {
                if (state.userData != null) {
                  return BlocBuilder<CommentsCubit, CommentsState>(
                    bloc: _commentsCubit,
                    builder: (context, state) {
                      if (state.status == CommentsStatus.data) {
                        return Column(children: [
                          state.comments!.isEmpty
                              ? const Text('Комментариев нету')
                              : Column(
                                  children: state.comments!
                                      .map((e) => Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: const BorderRadius.all(Radius.circular(15)),
                                                border: Border.all(color: Colors.blue),
                                              ),
                                              width: MediaQuery.of(context).size.width,
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                            builder: (_) => UserScreen(
                                                              uid: e.authorUid,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: const BorderRadius.all(Radius.circular(30)),
                                                          color: Colors.blue.withOpacity(0.2),
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(10.0),
                                                          child: Text(e.authorSurname + " " + e.authorName),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 15),
                                                    Text(e.comment),
                                                    const SizedBox(height: 15),
                                                    Text('Оценка - ' + e.grade + '/10'),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                ),
                          const Divider(
                            color: Colors.blue,
                            thickness: 1,
                            height: 30,
                          ),
                          Form(
                            key: _formKey,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    const Text('Оставить комментарий'),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CustomTextForm(
                                        label: "Коммантарий",
                                        controller: commentController,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CustomTextForm(
                                        label: "Оценка (цифра от 1 до 10)",
                                        controller: gradeController,
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          _commentsCubit.addComment(
                                            comment: commentController.text,
                                            grade: gradeController.text,
                                            projectId: widget.project.id,
                                            authorSurname: _userCubit.state.userData!.surname,
                                            authorName: _userCubit.state.userData!.name,
                                            authorUid: _userCubit.state.userData!.uid,
                                            context: context,
                                          );
                                        }
                                      },
                                      child: const Text("Добавить"),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ]);
                      } else {
                        return Container();
                      }
                    },
                  );
                } else {
                  return const Text(
                    "Комментарии доступны только авторизованным пользователям",
                    textAlign: TextAlign.center,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
