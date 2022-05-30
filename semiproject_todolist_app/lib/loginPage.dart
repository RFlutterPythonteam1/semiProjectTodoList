import 'package:flutter/material.dart';


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
        title: const Text('To do List'),
      ),
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [  
          SizedBox(
            height: 150,),
            Text("Log In",
             style: TextStyle(
                      color : Colors.black,
                      fontSize :30,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 10,
                      ),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                  
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextField(
                  decoration: InputDecoration(
                    labelText: 'ID를 입력해주세요.',
                  ),
                  keyboardType: TextInputType.text,
                ),
            ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'PW를 입력해주세요.',
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
              ElevatedButton(
                onPressed:(){
                  setState(() {
                  _showAlert(context);
                    
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('다시 입력하세요.'),
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.red,
                  ),
                
                );
                },
                 child: const Text('로그인'),
                 ),
          ],
        ),
      ),
    );
  }
//function




}//end