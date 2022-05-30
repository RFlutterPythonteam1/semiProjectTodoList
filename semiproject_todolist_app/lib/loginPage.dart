import 'package:flutter/material.dart';
import 'package:semiproject_todolist_app/todolist.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "for Test",
        ),
      ),
      body: ElevatedButton(
        onPressed: () {
          TodoList.listId = 1;
          TodoList.userId = "aa";
          TodoList.category = "bb";
          TodoList.content = "cc";
          Navigator.pushNamed(context, "/listEditingPage");
        },
        child: const Text(
          "수정하기",
        ),
      ),
    );
  }
}
