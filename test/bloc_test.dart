// import 'dart:async';
// import 'dart:js';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
// import 'package:diplom/main.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';

// const MessagesCollection = 'messages';

import 'package:diplom/business_logic_layer/comments_cubit.dart';
import 'package:diplom/data_layer/repository/repository.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';

import 'package:bloc_test/bloc_test.dart';


void main() {



  // group(CommentsCubit, () {
  //   late CommentsCubit commentsCubit;
  //
  //   //initialize the testing setup
  //   final FirebaseRepository _fire = FirebaseRepository();
  //   setUp(() {
  //     commentsCubit = CommentsCubit(firebaseRepository: _fire);
  //   });
  //
  //   //dictates what will happen after the test finishes
  //   tearDown(() {
  //     commentsCubit.close();
  //   });
  //
  //   //test the initial state, number: 1
  //   test("Initial state of OperatorCubit is OperatorState(number: 1.0)", () {
  //     var list;
  //     expect(commentsCubit.state, CommentsState(status: CommentsStatus.failure));
  //   });

    //test the cubits
    // blocTest(
    //   "The cubit should emit a state of OperatorState(number: 2.0) when add() is called",
    //   build: () => operatorCubit,
    //   act: (cubit) => operatorCubit.add(),
    //   expect: () => [OperatorState(number: 2.0)],
    // );
    //
    // blocTest(
    //   "The cubit should emit a state of OperatorState(number: 0.0) when substract() is called",
    //   build: () => operatorCubit,
    //   act: (cubit) => operatorCubit.substract(),
    //   expect: () => [OperatorState(number: 0.0)],
    // );
    //
    // blocTest(
    //   "The cubit should emit a state of OperatorState(number: 2.0) when multiply() is called",
    //   build: () => operatorCubit,
    //   act: (cubit) => operatorCubit.multiply(),
    //   expect: () => [OperatorState(number: 2.0)],
    // );
    //
    // blocTest(
    //   "The cubit should emit a state of OperatorState(number: 0.5) when divide() is called",
    //   build: () => operatorCubit,
    //   act: (cubit) => operatorCubit.divide(),
    //   expect: () => [OperatorState(number: 0.5)],
    // );
  // });

//   group(locTest, () {
//     late blocTest blocTest;
//
// //initialize the testing setup
//     setUp(() {
//       operatorCubit = blocTest();
//     });
//
// //dictates what will happen after the test finishes
//     tearDown(() {
//       operatorCubit.close();
//     });
//   });

  // getMockedAndRegisterReportRepository(){
  //   var mockReportRepository = MockReportRepository();
  //   when(mockReportRepository.fetchAlerts()).thenAnswer(
  //           (_) async => <AlertModel>[] );
  //   getIt.registerFactory<ReportsRepository>(() =>mockReportRepository);
  // }

  // class MockResetPasswordCubit extends MockCubit<ResetPasswordState>
  // implements ResetPasswordCubit {}
  //
  // @GenerateMocks([ResetPassword])
  // void main() {
  // late MockResetPassword mockResetPassword;
  // late MockResetPasswordCubit cubit;
  // late ResetPasswordParams params;
  //
  // setUp(() {
  // mockResetPassword = MockResetPassword();
  // cubit = MockResetPasswordCubit();
  // params = const ResetPasswordParams(
  // pin: "1234", password: "hello", confirmPassword: "hello");
  // when(mockResetPassword.call(params))
  //     .thenAnswer((_) async => const Right(ResetPasswordResult.validated));
  // });
  //
  // blocTest<ResetPasswordCubit, ResetPasswordState>(
  // 'when attempt to validate password is made then loading state is emitted',
  // build: () => cubit,
  // act: (cubit) => cubit.attemptPasswordReset(params: params),
  // expect: () => [ResetPasswordLoading(), ResetPasswordLoaded()]);
  // }



  // testWidgets('adds messages', (WidgetTester tester) async {
  //   // Instantiate the mock database.
  //   final firestore = FakeFirebaseFirestore();
  //
  //   // Render the widget.
  //   var child;
  //   await tester.pumpWidget(MaterialApp(
  //       title: 'Создание проекта', home: SafeArea(child: child,)));
  //   // Verify that there is no data.
  //   expect(find.text('Create project!'), findsNothing);
  //
  //   // Tap the Add button.
  //   await tester.tap(find.byType(FloatingActionButton));
  //   // Let the snapshots stream fire a snapshot.
  //   await tester.idle();
  //   // Re-render.
  //   await tester.pump();
  //
  //   // Verify the output.
  //   expect(find.text('Create project'), findsOneWidget);
  // });




  // testWidgets('shows messages', (WidgetTester tester) async {
  //   // Populate the fake database.
  //   final firestore = FakeFirebaseFirestore();
  //   await firestore.collection(MessagesCollection).add({
  //     'name': 'hguk',
  //     'date': 'fgh',
  //     'info': 'fgh',
  //     'authorSurname': 'fgh',
  //     'authorName': 'gyhkj',
  //     'authorUid': 'gjkh',
  //     'lat': 'hkhjk',
  //     'lng': 'hkjk',
  //     'context': context,
  //   });
  //
  //   // Render the widget.
  //   await tester.pumpWidget(MaterialApp(
  //       title: 'Firestore Example', home: SafeArea(child: bottomNavigationBar,)));
  //   // Let the snapshots stream fire a snapshot.
  //   await tester.idle();
  //   // Re-render.
  //   await tester.pump();
  //   // // Verify the output.
  //   expect(find.text('Hello world!'), findsOneWidget);
  //   expect(find.text('Message 1 of 1'), findsOneWidget);
  // });
  //
  // testWidgets('adds messages', (WidgetTester tester) async {
  //   // Instantiate the mock database.
  //   final firestore = FakeFirebaseFirestore();
  //
  //   // Render the widget.
  //   var child;
  //   await tester.pumpWidget(MaterialApp(
  //       title: 'Firestore Example', home: SafeArea(child: child)));
  //   // Verify that there is no data.
  //   expect(find.text('Hello world!'), findsNothing);
  //
  //   // Tap the Add button.
  //   await tester.tap(find.byType(FloatingActionButton));
  //   // Let the snapshots stream fire a snapshot.
  //   await tester.idle();
  //   // Re-render.
  //   await tester.pump();
  //
  //   // Verify the output.
  //   expect(find.text('Hello world!'), findsOneWidget);
  // });



  // testWidgets('shows messages', (WidgetTester tester) async {
  //   // Populate the mock database.
  //   final firestore = MockFirestoreInstance();
  //   await firestore.collection(MessagesCollection).add({
  //     'message': 'Hello world!',
  //     'created_at': FieldValue.serverTimestamp(),
  //   });
  //
  //   // Render the widget.
  //   await tester.pumpWidget(MaterialApp(
  //       title: 'Firestore Example', home: MyHomePage(firestore: firestore)));
  //   // Let the snapshots stream fire a snapshot.
  //   await tester.idle();
  //   // Re-render.
  //   await tester.pump();
  //   // // Verify the output.
  //   expect(find.text('Hello world!'), findsOneWidget);
  //   expect(find.text('Message 1 of 1'), findsOneWidget);
  // });



}
