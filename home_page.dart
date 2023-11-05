import 'package:app1/data/database.dart';
import 'package:app1/util/dilog_box.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../util/Todo_tile.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _myBox= Hive.box('my box');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    if(_myBox.get("TODOLIST") == null){
      db.creatInitiData();
    } else {
      db.loadData();
    }
    super.initState();
  }
  // text controller
  final _controller = TextEditingController();

  void checkBoxChanged(bool? value,int index){
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updataDataBase();
    Navigator.of(context).pop();
  }
  // save new task
  void saveNewTask(){
    setState(() {
      db.toDoList.add([_controller.text,false]);
      _controller.clear();
    });
    db.updataDataBase();
    Navigator.of(context).pop();
  }
  void CreatNewTask(){
    showDialog(context: context, builder:(context){
      return DialogBox(
        controller:_controller ,
        onSave: saveNewTask,
        onCancel: () => Navigator.of(context).pop(),
      );

    },);
  }

  void deletTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updataDataBase();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title:Text("to do "),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: CreatNewTask,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount:  db.toDoList.length,
        itemBuilder: (context,index){
          return ToDoTile(
              taskName:  db.toDoList[index][0],
              taskComplete:  db.toDoList[index][1],
              noChange: (value)=>checkBoxChanged(value,index),
            deleteFunction: (context) =>deletTask(index),
          );
        },
      ),
    );
  }
}
