import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:semiproject_todolist_app/todolist.dart';


class AddListPage extends StatefulWidget {
  const AddListPage({Key? key}) : super(key: key);

  @override
  State<AddListPage> createState() => _AddListPageState();
}

class _AddListPageState extends State<AddListPage> {
  late String selectValue;
  late List<String> valueList;

  final tec = TextEditingController();

  @override
  void initState() {
    super.initState();
    valueList = ["공부","문화생활","운동","약속","중요"];
    selectValue = "공부";
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          primary : true,
          backgroundColor: Colors.white,
          elevation : 0,
          title: const Text(
            '추가',
            style: TextStyle(
              color: Color.fromRGBO(123,154,204, 1)
            ),
          ),
          leading: IconButton(
            onPressed: (){
              Navigator.of(context).pop();
            },
            color: Color.fromRGBO(123,154,204, 1),
            icon: Icon(Icons.arrow_back_ios),
          ),

        ),
        
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(height: 100,),
                Row(
                  children: [
                    Container(
                      height: 20 ,
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.3),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      width: 200,
                      child: DropdownButton(
                        isDense: true,
                        value: selectValue,
                        items: valueList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(), 
                        onChanged: (value){
                          setState(() {
                            selectValue = value.toString();
                          });
                        },
                        dropdownColor: Colors.grey,
                        isExpanded: true,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: tec,
                  decoration: InputDecoration(
                    labelText: '내용을 입력하세요',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 0)
                    )
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: 
                   ButtonStyle(
                      side: MaterialStateProperty.all(BorderSide(width: 5,color: Color.fromRGBO(123,154,204, 1),))  ,
                      minimumSize: MaterialStateProperty.all(Size(400, 40)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),
                        ),
                       
                      ),
                      backgroundColor: MaterialStateProperty.all( Color.fromRGBO(123,154,204,1)),
                    ),
                  onPressed: () {
                    sendContent();
                    Navigator.pop(context);
                  },
                  child: const Text('전송'),
                  
                  
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // -- functions

  sendContent() async{
    if(tec.text.trim().isNotEmpty){
      
      String u_id = TodoList.userId;
      String category = selectValue;
      String t_content = tec.text;
      
      var url = Uri.parse('http://localhost:8080/Flutter/todolist_insert_return_flutter.jsp?u_id=$u_id&category=$category&t_content=$t_content');
      var response = await http.get(url);

      setState(() {
        var dataConvetedJSON =  json.decode(utf8.decode(response.bodyBytes));
        var result = dataConvetedJSON['result'];
        if(result  == "OK") _showDialog(context);
        else errorSnackBar(context);
      });
    }else{
      emptySnackBar(); 
    }
  }

  //DB 입력 성공
  _showDialog(BuildContext context){
    showDialog(context: context, 
    builder: (BuildContext context){
      return AlertDialog(
        title:  const Text('입력 결과'),
        content: const Text('입력이 완료 되었습니다.'),
        actions: [
          TextButton(
            onPressed:(){
              Navigator.of(context).pop();
              
            }, 
            child: const Text('OK'),
          )
        ],
      );
    }
    );
  }
  
  //DB 입력 실패
  errorSnackBar(BuildContext context){
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('입력 에러가 발생했습니다.'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      )
    );
  }

  //textfield 입력 X
  emptySnackBar(){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        
        content: const Text('다시는 내용을 비우지 말아주세요'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.redAccent,
      )
    );
  }
}