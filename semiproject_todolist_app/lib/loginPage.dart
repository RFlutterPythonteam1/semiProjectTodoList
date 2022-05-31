import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:semiproject_todolist_app/todoListPage.dart';
import 'package:semiproject_todolist_app/todolist.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController idcontroller;
  late TextEditingController pwcontroller;
  late List userId;
  late String id;
  late String pw;
  late List data;

  @override
  void initState() {
    super.initState();
    idcontroller = TextEditingController();
    pwcontroller = TextEditingController();
<<<<<<< HEAD
    id = " ";
    pw = " ";
    data=[];
    userId =[];
  
=======
    id = '';
    pw = '';
    userId = [];
    // getJSONData();
>>>>>>> 76917fa279ae1de11477264cfc717295c36edb8d
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To do List'),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 30,
          letterSpacing: 13,
          fontWeight: FontWeight.bold,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 150,
              ),
              const Text(
                "Log In",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  letterSpacing: 10,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: EdgeInsets.all(30.0),
                child: TextField(
                  controller: idcontroller,
                  decoration: InputDecoration(
                    labelText: 'ID를 입력해주세요.',
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(30.0),
                child: TextField(
                  controller: pwcontroller,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'PW를 입력해주세요.',
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    getJSONData();
                  });
                },
                child: const Text('로그인'),
              ),
            ],
          ),
        ),
      ),
    );
  }

//function

<<<<<<< HEAD
    Future<bool> getJSONData() async {
      var url = Uri.parse(
          'http://localhost:8080/Flutter/sami_todolist_login.jsp?id=${idcontroller.text}&pw=${pwcontroller.text}');
      var response = await http.get(url);

      print(url);
      setState(() {
        var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
        List result = dataConvertedJSON['results'];
        data.addAll(result);

        data[0]["id"];
        if (idcontroller.text != result[0]["id"]) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "id를 다시 확인해주세요.",
              ),
              duration: Duration(seconds: 1),
              backgroundColor: Colors.red,
=======
  Future<bool> getJSONData() async {
    var url = Uri.parse(
        'http://localhost:8080/Flutter/sami_todolist_login.jsp?id=${idcontroller.text}');
    var response = await http.get(url);

    setState(() {
      var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
      List result = dataConvertedJSON['results'];
      if (result.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "id를 다시 확인해주세요.",
>>>>>>> 76917fa279ae1de11477264cfc717295c36edb8d
            ),
            duration: Duration(seconds: 1),
            backgroundColor: Colors.red,
          ),
        );
      } else if (pwcontroller.text != result[0]["pw"]){

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "pw를 다시 확인해주세요.",
              ),
              duration: Duration(seconds: 1),
              backgroundColor: Colors.red,
            ),
          );
        

      } else {
                  showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Log in'),
                  content: const Text('로그인이 완료되었습니다.'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          TodoList.userId = idcontroller.text;
                          Navigator.of(context).pop();
                           Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return ToDoListPage(u_id: idcontroller.text);
                            }),
                          ).then((value) => getJSONData());
                        },
                        child: const Text('확인'))
                  ],
                );
              });
      }
    });
    return true;
  }
}//end


    