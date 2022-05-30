import 'package:flutter/material.dart';
import 'package:semiproject_todolist_app/todolist.dart';

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
  listEdit(BuildContext context) {
    // var url = Uri.parse(
    //   'http://localhost:8080/Flutter/student_delete_return_flutter.jsp?'
    // );

    // return true;
  }

  listDelete(BuildContext context) {

  }
}
