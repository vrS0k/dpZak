import 'package:diplom/business_logic_layer/comments_cubit.dart';
import 'package:diplom/business_logic_layer/members_cubit.dart';
import 'package:diplom/business_logic_layer/profile_screen_cubit.dart';
import 'package:diplom/data_layer/models/project_model.dart';
import 'package:diplom/user_interface_layer/user_screen.dart';
import 'package:diplom/user_interface_layer/widgets/custom_text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailProjectScreen extends StatefulWidget {
  final ProjectModel project;

  const DetailProjectScreen({Key? key, required this.project}) : super(key: key);

  @override
  State<DetailProjectScreen> createState() => _DetailProjectScreenState();
}

class _DetailProjectScreenState extends State<DetailProjectScreen> {
  late final ProfileScreenCubit _userCubit;
  late final CommentsCubit _commentsCubit;
  late final MembersCubit _membersCubit;
  bool thisUser = false;
  TextEditingController commentController = TextEditingController();
  TextEditingController gradeController = TextEditingController();
  final MapController _mapController = MapController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _userCubit = BlocProvider.of<ProfileScreenCubit>(context);
    _commentsCubit = BlocProvider.of<CommentsCubit>(context);
    _membersCubit = BlocProvider.of<MembersCubit>(context);
    _membersCubit.clean();
    _membersCubit.getMembers(widget.project.id);
    thisUser = false;
    _commentsCubit.getComments(widget.project.id);
    SharedPreferences.getInstance().then((value) {
      setState(() {
        List<String> viewList = value.getStringList('items') ?? [];
        if (!viewList.contains(widget.project.id)){
          viewList.add(widget.project.id);
        }
        value.setStringList('items', viewList);
      });
    });
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
                    child: Text("Автор : " + widget.project.authorSurname + " " + widget.project.authorName),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      "Название : ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(child: Text(widget.project.name)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      "Дата проведения : ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(child: Text(widget.project.date)),
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
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width * 0.66,
                child: FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    center: LatLng(double.parse(widget.project.lat), double.parse(widget.project.lng)),
                    zoom: 16.0,
                  ),
                  layers: [
                    TileLayerOptions(
                      urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c'],
                      attributionBuilder: (_) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.add, size: 40),
                              onPressed: () {
                                _mapController.move(
                                  _mapController.center,
                                  _mapController.zoom + 1,
                                );
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 14.0),
                              child: IconButton(
                                icon: const Icon(Icons.minimize, size: 40),
                                onPressed: () {
                                  _mapController.move(
                                    _mapController.center,
                                    _mapController.zoom - 1,
                                  );
                                },
                              ),
                            )
                          ],
                        );
                      },
                    ),
                    MarkerLayerOptions(
                      markers: [
                        Marker(
                          width: 80.0,
                          height: 80.0,
                          point: LatLng(double.parse(widget.project.lat), double.parse(widget.project.lng)),
                          builder: (ctx) => const Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Divider(color: Colors.blue, thickness: 1),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Участники : ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            BlocBuilder<ProfileScreenCubit, ProfileScreenState>(
              bloc: _userCubit,
              builder: (context, state) {
                if (state.userData != null) {
                  return BlocBuilder<MembersCubit, MembersState>(
                    bloc: _membersCubit,
                    builder: (context, state) {
                      if (state.status == MembersStatus.data) {
                        return Wrap(
                          children: [
                            ...state.members!.map((e) {
                              if (e.uid == _userCubit.state.userData!.uid) {
                                Future.delayed(const Duration(microseconds: 100)).then((value) {
                                  setState(() {
                                    thisUser = true;
                                  });
                                });
                              }
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => UserScreen(
                                        uid: e.uid,
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
                                      child: Text(e.surname + " " + e.name),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                            thisUser
                                ? const SizedBox()
                                : Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: ElevatedButton(
                                      onPressed: () {
                                        _membersCubit.addMember(
                                          surname: _userCubit.state.userData!.surname,
                                          name: _userCubit.state.userData!.name,
                                          patronymic: _userCubit.state.userData!.patronymic,
                                          address: _userCubit.state.userData!.address,
                                          phone: _userCubit.state.userData!.phone,
                                          uid: _userCubit.state.userData!.uid,
                                          projectIdList: _userCubit.state.userData!.projectIdList,
                                          projectId: widget.project.id,
                                          context: context,
                                        );
                                      },
                                      child: const Text('Учавствовать'),
                                    ),
                                )
                          ],
                        );
                      } else {
                        return Container();
                      }
                    },
                  );
                } else {
                  return const Text(
                    "Просмотр Участников доступен только авторизованным пользователям",
                    textAlign: TextAlign.center,
                  );
                }
              },
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
                                        textInputType: TextInputType.number,
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
