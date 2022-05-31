import 'package:flutter/material.dart';
import 'package:semiproject_todolist_app/addList_Page.dart';
import 'package:semiproject_todolist_app/listeditingpage.dart';
import 'package:semiproject_todolist_app/loginPage.dart';
import 'package:semiproject_todolist_app/startPage.dart';
import 'package:semiproject_todolist_app/todoListPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (context) => const LoginPage(),
        "/listEditingPage": (context) => const ListEditinPage(),

        "/addListPage": (context) => const AddListPage(),
        "/startPage": (context) => const StartPage(),
        
      },
      initialRoute: "/startPage",
      debugShowCheckedModeBanner: false,
    );
  }
}
