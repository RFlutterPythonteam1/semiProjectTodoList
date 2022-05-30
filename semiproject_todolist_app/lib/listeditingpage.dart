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
    return Scaffold(
      appBar: AppBar(
        title: const Text("ToDo List 수정하기"),
      ),
      body: Center(
        child: Column(
          children: [
            DropdownButton(
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
            ),
            TextField(
              controller: contentCon,
              decoration: const InputDecoration(
                hintText: "입력해주세요",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                //
              },
              child: const Text(
                "수정",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
