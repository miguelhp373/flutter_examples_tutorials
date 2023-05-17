import 'package:flutter/material.dart';
import 'package:rest_call_api_http_methods/views/home_page.dart';
import 'package:rest_call_api_http_methods/views/users/users_details.dart';

void main() => runApp(const StartApp());

class StartApp extends StatelessWidget {
  const StartApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      //home: HomePage(),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/user-details': (context) => UsersDetails(),
      },
    );
  }
}
