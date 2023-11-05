import 'package:hive/hive.dart';

class ToDoDataBase{
  List toDoList=[];
  final _myBox= Hive.box('my box');

  void creatInitiData(){
    toDoList =[
      ["make totoril",false],
      ["do exrsesx",false]
    ];
  }

  void loadData(){
    toDoList= _myBox.get("TODOLIST");
  }
  void updataDataBase(){
    _myBox.put("TODOLIST", toDoList);
  }
}