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
    id = '';
    pw = '';
    userId = [];
    // getJSONData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          primary : true,
          backgroundColor: Color.fromRGBO(252,246,245, 1),
          elevation : 0,
           
          
          leading: IconButton(
            onPressed: (){
              Navigator.of(context).pop();
            },
            color: Color.fromRGBO(123,154,204, 1),
            icon: Icon(Icons.arrow_back_ios),
          ),

        ),
      body: SingleChildScrollView(
        child: Container(
          height: 750,
          color: Color.fromRGBO(252,246,245, 1),
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
                    color: Color.fromRGBO(123,154,204, 1),
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
                      labelText: 'ID??? ??????????????????.',
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
                      labelText: 'PW??? ??????????????????.',
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(123,154,204, 1),
                  ),
                  onPressed: () {
                    setState(() {
                      getJSONData();
                    });
                  },
                  child: const Text('?????????'),
                ),
              ],
            ),
          ),
        ),
      ),
      
    );
  }

//function

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
              "id??? ?????? ??????????????????.",
            ),
            duration: Duration(seconds: 1),
            backgroundColor: Colors.red,
          ),
        );
      } else if (pwcontroller.text != result[0]["pw"]){

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "pw??? ?????? ??????????????????.",
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
                  content: const Text('???????????? ?????????????????????.'),
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
                        child: const Text('??????'))
                  ],
                );
              });
      }
    });
    return true;
  }
}//end


    