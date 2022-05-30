import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:semiproject_todolist_app/todolist.dart';
import 'package:http/http.dart' as http;

class ListEditinPage extends StatefulWidget {
  const ListEditinPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ListEditinPage> createState() => _ListEditinPageState();
}

class _ListEditinPageState extends State<ListEditinPage> {
  late TextEditingController categoryCon, contentCon;
  late String selectValue;
  late List valueList;
  late String result;

  @override
  void initState() {
    categoryCon = TextEditingController();
    contentCon = TextEditingController();
    contentCon.text = TodoList.content;
    valueList = ["111", "222", "333"];
    selectValue = "111";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("ToDo List 수정하기"),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 200,
                      child: DropdownButton(
                        value: selectValue,
                        items: valueList.map((value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectValue = value.toString();
                          });
                        },
                        isExpanded: true,
                        dropdownColor: Colors.grey,
                      ),
                    ),
                  ],
                ),
                TextField(
                  controller: contentCon,
                  decoration: const InputDecoration(
                    hintText: "입력해주세요",
                    labelText: "수정할 내용을 입력해주세요",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                      )
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.blue,
                      )
                    )
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    listEdit(context);
                  },
                  child: const Text(
                    "수정",
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    listDelete(context);
                  },
                  child: const Text(
                    "삭제",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // functions
  Future<bool> listEdit(BuildContext context) async{
    var url = Uri.parse(
      'http://localhost:8080/Flutter/list_update.jsp?category=$selectValue&content=${contentCon.text}&listId=${TodoList.listId}'
    );

    var response = await http.get(url);

    setState(() {
      var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));

      result = dataConvertedJSON["result"];

      if(result == "OK"){
        _showDialog(context, "수정이");

      }else if(result == "ERROR"){
        errorSnackBar(context);
      }
    });
    
    return true;
  }

  Future<bool> listDelete(BuildContext context) async{
    var url = Uri.parse(
      'http://localhost:8080/Flutter/list_delete.jsp?listId=${TodoList.listId}'
    );

    var response = await http.get(url);

    setState(() {
      var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));

      result = dataConvertedJSON["result"];

      if(result == "OK"){
        _showDialog(context, "삭제가");

      }else if(result == "ERROR"){
        errorSnackBar(context);
      }
    });
    
    return true;
  }
    _showDialog(BuildContext context, String todo){
    showDialog(context: context, 
    builder: (BuildContext context){
      return AlertDialog(
        title:  const Text('결과'),
        content: Text('$todo 완료 되었습니다.'),
        actions: [
          TextButton(
            onPressed:(){
              Navigator.of(context).pop();
              Navigator.pop(context);
            }, 
            child: const Text('OK'),
          )
        ],
      );
    }
    );
  }

  errorSnackBar(BuildContext context){
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('입력 에러가 발생했습니다.'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      )
    );
  }
}
