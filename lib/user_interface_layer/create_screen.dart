import 'package:diplom/business_logic_layer/create_screen_cubit.dart';
import 'package:diplom/business_logic_layer/profile_screen_cubit.dart';
import 'package:diplom/user_interface_layer/widgets/custom_text_form.dart';
import 'package:diplom/user_interface_layer/widgets/custom_text_form_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  State<CreateScreen> createState() => _CreateScreenState(); // _ - приватный класс доступный только в этом файле
}

class _CreateScreenState extends State<CreateScreen> {
  late final CreateScreenCubit _cubit;
  late final ProfileScreenCubit _userCubit;
  final _formKey = GlobalKey<FormState>();
  final MapController _mapController = MapController();

  @override
  void initState() { // метод виджетов выполняется когда создается виджет до постройки
    _userCubit = BlocProvider.of<ProfileScreenCubit>(context);
    _cubit = BlocProvider.of<CreateScreenCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( // виджет экрана у которого есть поля апп бар и боди
      appBar: MediaQuery.of(context).size.width > 300
          ? AppBar(
        backgroundColor: Colors.green,
        title: const Text('Предложение проекта'),
        centerTitle: true,
      )
          : const PreferredSize(
          child: SizedBox(), preferredSize: Size(0, 0)),
      body: BlocBuilder<ProfileScreenCubit, ProfileScreenState>(
          bloc: _userCubit,
          builder: (context, state) {
            if (state.user != null) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 15),
                        CustomTextForm(label: "Название", controller: _cubit.state.nameController),
                        const SizedBox(height: 15),
                        CustomTextFormDate(
                          label: "Дата",
                          controller: _cubit.state.dataController,
                          textInputType: TextInputType.number,
                        ),
                        const SizedBox(height: 15),
                        CustomTextForm(label: "Описание", controller: _cubit.state.informationController),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.width * 0.66,
                            child: FlutterMap(
                              mapController: _mapController,
                              options: MapOptions(
                                center: LatLng(56.3261885,44.0026886),
                                zoom: MediaQuery.of(context).size.width > 300 ? 16.0 : 12,
                              ),
                              layers: [
                                TileLayerOptions(
                                  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                  subdomains: ['a', 'b', 'c'],
                                  attributionBuilder: (_) {
                                    if (MediaQuery.of(context).size.width > 300) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          const SizedBox(width: 100),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.66 *
                                                      0.5 -
                                                  15,
                                            ),
                                            child: const Icon(
                                              Icons.location_searching,
                                              size: 30,
                                              color: Colors.red,
                                            ),
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              IconButton(
                                                icon: const Icon(Icons.add,
                                                    size: 40),
                                                onPressed: () {
                                                  _mapController.move(
                                                    _mapController.center,
                                                    _mapController.zoom + 1,
                                                  );
                                                },
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 14.0),
                                                child: IconButton(
                                                  icon: const Icon(
                                                      Icons.minimize,
                                                      size: 40),
                                                  onPressed: () {
                                                    _mapController.move(
                                                      _mapController.center,
                                                      _mapController.zoom - 1,
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    }
                                    else {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.66 *
                                              0.5 -
                                              15,
                                          right: MediaQuery.of(context).size.width/2 - 35
                                        ),
                                        child: const Icon(
                                          Icons.location_searching,
                                          size: 30,
                                          color: Colors.red,
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _cubit.addProject(
                                name: _cubit.state.nameController.text,
                                date: _cubit.state.dataController.text,
                                info: _cubit.state.informationController.text,
                                authorSurname: _userCubit.state.userData!.surname,
                                authorName: _userCubit.state.userData!.name,
                                authorUid: _userCubit.state.userData!.uid,
                                lat: _mapController.center.latitude.toString(),
                                lng: _mapController.center.longitude.toString(),
                                context: context,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.green),
                          child: const Text("Предложить проект"),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'Страница доступна только авторизованным пользователям',
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
          }),
    );
  }
}
