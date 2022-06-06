// // This is a basic Flutter widget test.
// //
// // To perform an interaction with a widget in your test, use the WidgetTester
// // utility that Flutter provides. For example, you can send tap and scroll
// // gestures. You can also use WidgetTester to find child widgets in the widget
// // tree, read text, and verify that the values of widget properties are correct.
// import 'package:diplom/business_logic_layer/profile_screen_cubit.dart';
// import 'package:diplom/firebase_options.dart';
// import 'package:diplom/main.dart';
// import 'package:diplom/user_interface_layer/profile_screen.dart';
// import 'package:diplom/user_interface_layer/widgets/custom_text_form.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:path/path.dart';
//
//
// import 'package:flutter_test/flutter_test.dart';
//
// void main() {
//
//   testWidgets('Widget тест', (WidgetTester tester) async {
//
//     debugPrint("...test #1");
//
//     // WidgetsFlutterBinding.ensureInitialized();
//     //
//     // debugPrint("wait");
//     //
//     // Firebase.initializeApp(
//     //   options: DefaultFirebaseOptions.currentPlatform,
//     // );
//     //
//     // FirebaseMessaging.instance.getToken();
//     await tester.pumpWidget(const MyApp());
//     Finder s=find.text('2022');
//     debugPrint("wait22 \n $s");
//     //expect(find.text('2022'),findsOneWidget);
//     expect(find.text('2023'),findsNothing );
//     Finder s1=find.text('2023');
//     debugPrint("wait33 \n $s1");
//   });
// }
