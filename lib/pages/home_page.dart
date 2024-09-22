import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/data/database.dart';
import 'package:todo/utils/dialog_box.dart';
import 'package:todo/utils/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //reference the hive box
  final _myBox = Hive.box('myBox');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {

    //if this is the first time ever opening the app
    if(_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    }else{
      db.loadData();
    }

    super.initState();
  }

  //controllers
  final _controller = TextEditingController();

  //checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  //save new task
  void saveNewTask() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        db.toDoList.add([_controller.text, false]);
        _controller.clear();
      });
    }
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  //create a new task
  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
            controller: _controller,
          );
        });
  }

  //delete task
  void deleteTask(int index){
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        title: Row(
          children: [
            Icon(Icons.star, color: Colors.white,),
            SizedBox(width: 10,),
            Text(
              'A Lot To Do!',
              style: TextStyle(color: Colors.white,),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        backgroundColor: Colors.grey[100],
        child: Icon(
          Icons.add,
          color: Colors.blue,
        ),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            deleteFunction: (context)=>deleteTask(index),
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
          );
        },
      ),
    );
  }
}
