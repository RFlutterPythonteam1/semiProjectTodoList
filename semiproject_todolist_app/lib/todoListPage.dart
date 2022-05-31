import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:semiproject_todolist_app/completePage.dart';
import 'package:semiproject_todolist_app/incompletePage.dart';



class ToDoListPage extends StatefulWidget {
  final String u_id;
  const ToDoListPage({Key? key, required this.u_id}) : super(key: key);

  @override
  State<ToDoListPage> createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> with SingleTickerProviderStateMixin {
  
  // Property
  late TabController controller;
  late String _today = DateFormat.yMMMd().format(DateTime.now());

  // Test Set
  final List<String> items = List.generate(30, (index) => 'Item ${index + 1}');
  
  @override
  void initState() {
    controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          primary : true,
          backgroundColor: Colors.white,
          elevation : 0,
          title: const Text(
            'To Do List',
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

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 30,),
          SizedBox(          
            height: 50,
            child: Text(_today),          
            
          ),
          SizedBox(
            height: 550,
            child: TabBarView(
              controller: controller,
              children: [InComoleteList(u_id: widget.u_id), ConmpleteList(u_id: widget.u_id,)]
              ),
          ),
        ],
      ),
        bottomNavigationBar: TabBar(        
          controller: controller,
          labelColor: Colors.black,
          tabs: const [
            Tab(
              icon: Icon(
                Icons.looks_one,
                color: Color.fromRGBO(123,154,204, 1),
              ),
              text: "미완료",
            ),
            Tab(
              icon: Icon(
                Icons.looks_two,
                color: Colors.black,
              ),
              text: "완료",
            ),

          ]),
     
    );
    
  }
}