import 'package:diplom/business_logic_layer/create_screen_cubit.dart';
import 'package:diplom/business_logic_layer/profile_screen_cubit.dart';
import 'package:diplom/user_interface_layer/widgets/custom_text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  late final CreateScreenCubit _cubit;
  late final ProfileScreenCubit _userCubit;
  final _formKey = GlobalKey<FormState>();
  final MapController _mapController = MapController();

  @override
  void initState() {
    _userCubit = BlocProvider.of<ProfileScreenCubit>(context);
    _cubit = BlocProvider.of<CreateScreenCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Project Screen'),
        centerTitle: true,
      ),
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
                        CustomTextForm(label: "Name", controller: _cubit.state.nameController),
                        const SizedBox(height: 15),
                        CustomTextForm(
                          label: "Date",
                          controller: _cubit.state.dataController,
                          textInputType: TextInputType.number,
                        ),
                        const SizedBox(height: 15),
                        CustomTextForm(label: "Information", controller: _cubit.state.informationController),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.width * 0.66,
                            child: FlutterMap(
                              mapController: _mapController,
                              options: MapOptions(
                                center: LatLng(56.3261885,44.0026886),
                                zoom: 16.0,
                              ),
                              layers: [
                                TileLayerOptions(
                                  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                  subdomains: ['a', 'b', 'c'],
                                  attributionBuilder: (_) {
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        const SizedBox(width: 100),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context).size.width * 0.66 * 0.5 - 15,
                                          ),
                                          child: const Icon(
                                            Icons.location_searching,
                                            size: 30,
                                            color: Colors.red,
                                          ),
                                        ),
                                        Row(
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
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
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
                          child: const Text("Create project"),
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
