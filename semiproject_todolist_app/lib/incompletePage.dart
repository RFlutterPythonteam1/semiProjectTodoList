import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:semiproject_todolist_app/listeditingpage.dart';
import 'package:semiproject_todolist_app/todolist.dart';

class InComoleteList extends StatefulWidget {
  final String u_id;

  const InComoleteList({Key? key, required this.u_id}) : super(key: key);

  @override
  State<InComoleteList> createState() => _InComoleteListState();
}

class _InComoleteListState extends State<InComoleteList> {
  // Property
  late List data;
  late int t_id;

  @override
  void initState() {
    data = [];
    t_id = -1;
    getJSONData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return ListEditinPage();
          }),
        ).then((value) => getJSONData());
      },
      child: Scaffold(
        body: data.isEmpty
            ? Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 30,
                  ),
                  Text("데이터 준비중...."),
                ],
              ))
            : ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) => Dismissible(
                    key: Key(data[index]['id']),
                    onDismissed: (direction) => _onDismissed(direction, index),
                    confirmDismiss: (direction) =>
                        _confirmDismiss(direction, context, index),
                    background: _buildBackground,
                    secondaryBackground: _buildSecondBackground,
                    child: _buildListItem(index))),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, '/addListPage').then((value) => getJSONData());
            },
            backgroundColor:Color.fromRGBO(123, 154, 204, 1) ,
            child: const Icon(
              Icons.add,
              color: Colors.black,
            ),
            ),
      ),
    );
  }

  // --- Function ---
  _onDismissed(DismissDirection direction, int index) {
    // if (direction == DismissDirection.endToStart) {

    // }
    // if (direction == DismissDirection.startToEnd) {

    // }
  }

  Future<bool> _confirmDismiss(
      DismissDirection direction, BuildContext context, int index) {
    if (direction == DismissDirection.endToStart) {
      return showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text('삭제 알림'),
              content: Text('${data[index]['content']} \n삭제하시겠습니까?'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    return Navigator.of(context).pop(false);
                  },
                  child: const Text('취소'),
                ),
                ElevatedButton(
                  onPressed: () {
                    deleteJSONData(index);
                    return Navigator.of(context).pop(true);
                  },
                  child: const Text('삭제'),
                ),
              ],
            );
          }).then((value) => Future.value(value));
    } else if (direction == DismissDirection.startToEnd) {
      return showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text('완료처리 하시겠습니까?'),
              content: Text('${data[index]['content']} \n완료처리 합니다'),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    return Navigator.of(context).pop(false);
                  },
                  child: const Text('취소'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setJSONData(index, 1);
                    return Navigator.of(context).pop(true);
                  },
                  child: const Text('완료'),
                ),
              ],
            );
          }).then((value) => Future.value(value));
    }
    return Future.value(false);
  }

  GestureDetector _buildListItem(int index) {
    return GestureDetector(
      onTap: () {
        TodoList.content = data[index]['content'];
        TodoList.category = data[index]['category'];
        TodoList.listId = int.parse(data[index]['id']);
        Navigator.pushNamed(context, "/listEditingPage")
            .then((value) => getJSONData());
      },
      child: Card(
        margin: const EdgeInsets.all(8),
        elevation: 8,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Color.fromRGBO(123, 154, 204, 1),
            child: Text(data[index]['category']),
          ),
          title: Text(
            data[index]['content'],
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }

  Container get _buildSecondBackground => Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Colors.red,
        alignment: Alignment.centerRight,
        child: const Icon(
          Icons.delete,
          size: 36,
          color: Colors.white,
        ),
      );

  Container get _buildBackground => Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Colors.green,
        alignment: Alignment.centerLeft,
        child: const Icon(
          Icons.save,
          size: 36,
          color: Colors.white,
        ),
      );

  Future<bool> getJSONData() async {
    // Future, async, await 는 한 세트로
    // 비동기 함수로 생성
    var url = Uri.parse(
        'http://localhost:8080/Flutter/todolist_query_flutter.jsp?u_id=${widget.u_id}&t_state=0'); // web만 post방식을 사용 나머지는 get방식 사용 - 자체 암호화를 위해
    var response = await http.get(url); // 데이터를 가져와서 빌드가 끝날때까지 대기

    setState(() {
      // 화면 구성이 바뀌어야 쓴다
      data.clear();
      var dataConvertedJSON =
          json.decode(utf8.decode(response.bodyBytes)); // utf-8 타입으로 하나씩 변환
      List result = dataConvertedJSON['results'];
      data.addAll(result);
    });
    //print(result);
    print(data);
    return true; // return을 하지만 쓰지않는다
  }

  Future<bool> setJSONData(int index, int comNum) async {
    t_id = int.parse(data[index]['id']);
    var url = Uri.parse(
        'http://localhost:8080/Flutter/todolist_update_status_flutter.jsp?t_id=$t_id&t_state=$comNum'); // web만 post방식을 사용 나머지는 get방식 사용 - 자체 암호화를 위해
    var response2 = await http.get(url); // 데이터를 가져와서 빌드가 끝날때까지 대기
    print(url);
    getJSONData();

    return true; // return을 하지만 쓰지않는다
  }

  Future<bool> deleteJSONData(int index) async {
    t_id = int.parse(data[index]['id']);
    var url = Uri.parse(
        'http://localhost:8080/Flutter/list_delete.jsp?listId=$t_id'); // web만 post방식을 사용 나머지는 get방식 사용 - 자체 암호화를 위해
    var response2 = await http.get(url); // 데이터를 가져와서 빌드가 끝날때까지 대기
    print(url);
    getJSONData();

    return true; // return을 하지만 쓰지않는다
  }
} // End