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
    valueList = ["공부", "문화생활", "운동", "약속", "중요"];
    selectValue = "공부";
    super.initState();
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
            '수정 및 삭제',
            style: TextStyle(
              color:Color.fromRGBO(123,154,204, 1),
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 200,
                      height: 20,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.3,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: DropdownButton(
                        isDense: true,
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
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: contentCon,
                  decoration: const InputDecoration(
                      hintText: "입력해주세요",
                      labelText: "리스트 내용을 입력해주세요",
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        width: 1,
                      )),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        width: 2,
                        color: Colors.blue,
                      ))),
                ),
                SizedBox(
                  height:30,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (contentCon.text.trim().isEmpty) {
                      errorSnackBar(context);
                    } else {
                      _showDialog2(context, "수정");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      primary: Color.fromRGBO(123,154,204, 1),
                      minimumSize: const Size(400, 40)),
                  child: const Text(
                    "수정하기",
                  ),
                ),
                 SizedBox(
                  height:0,
                ),
                ElevatedButton(
                  onPressed: () {
                    _showDialog2(context, "삭제");
                  },
                  style: ElevatedButton.styleFrom(
                      
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      primary: Color.fromRGBO(123,154,204, 1),
                      minimumSize: const Size(400, 40)),
                      
                  child: const Text(
                    "삭제하기",
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
  Future<bool> listEdit(BuildContext context) async {
    var url = Uri.parse(
        'http://localhost:8080/Flutter/list_update.jsp?category=$selectValue&content=${contentCon.text}&listId=${TodoList.listId}');

    var response = await http.get(url);

    setState(() {
      var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));

      result = dataConvertedJSON["result"];

      if (result == "OK") {
        _showDialog(context, "수정이");
      } else if (result == "ERROR") {
        errorSnackBar(context);
      }
    });

    return true;
  }

  Future<bool> listDelete(BuildContext context) async {
    var url = Uri.parse(
        'http://localhost:8080/Flutter/list_delete.jsp?listId=${TodoList.listId}');

    var response = await http.get(url);

    setState(() {
      var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));

      result = dataConvertedJSON["result"];

      if (result == "OK") {
        _showDialog(context, "삭제가");
      } else if (result == "ERROR") {
        errorSnackBar(context);
      }
    });

    return true;
  }

  _showDialog(BuildContext context, String todo) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('결과'),
            content: Text('$todo 완료 되었습니다.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              )
            ],
          );
        });
  }

  _showDialog2(BuildContext context, String todo) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('리스트 $todo하기'),
            content: Text('$todo 하시겠습니까?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  todo == "수정" ? listEdit(context) : listDelete(context);
                },
                child: const Text('네'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('아니요'),
              ),
            ],
          );
        });
  }

  errorSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('내용을 입력해주세요'),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.red,
    ));
  }
}
