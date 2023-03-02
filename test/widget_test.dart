// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nojoum/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}

// // Init SDK
//             Client client = Client();

//             client
//                     .setEndpoint('http://192.168.1.4/v1') // Your API Endpoint
//                     .setProject('613c91ce0a808')
//                     .setSelfSigned(status: true) // Your project ID
//                 ;
//             Functions functions = Functions(client);
//             Account account = Account(client);

//             // Future result = account.createSession(
//             //   email: 'erfanhayatbakhsh@gmail.com',
//             //   password: 'hayat1209',
//             // );

//             // result.then((response) {
//             //   print(response);
//             // }).catchError((error) {
//             //   print(error.response);
//             // });
//             Future result = functions.listExecutions(
//               functionId: '6194c98bb4407',
//             );
//             ExecutionList ec;
//             // ec.executions.forEach((element) {
//             //   print(element.stderr);
//             // });
//             result.then((response) {
//               ec = response;
//               // print(response);
//               print(ec.sum);
//               for (var element in ec.executions) {
//                 print(element.status);
//                 print(element.stdout);
//                 print(element.status);
//               }
//             }).catchError((error) {
//               print(error.response);
//             });
//             // Future result2 = functions.createExecution(
//             //   functionId: '6194c98bb4407',
//             // );
//             // Execution ec;
//             // result2.then((response) {
//             //   // print(response);
//             //   // print(response.stderr);
//             //   // print(response.sdtout);
//             // }).catchError((error) {
//             //   print(error.response);
//             // });
