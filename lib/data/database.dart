import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List toDoList = [];

  //reference the box
  final _myBox = Hive.box('myBox');

  //creating initial data
  void createInitialData(){
    toDoList = [
      ['Hello There!', false],
      ['Let\'s do some work my friend!', false],
      ['Slide the task to left to delete it', false],
      ['Mark the task check if its done', true],
    ];
  }

  //load data from the database
  void loadData(){
    toDoList = _myBox.get("TODOLIST");
  }

  void updateDataBase() {
    _myBox.put("TODOLIST", toDoList);
  }

}