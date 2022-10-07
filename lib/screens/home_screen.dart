import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/data/database.dart';

import 'package:todo_app/utils/dialog_box.dart';
import 'package:todo_app/utils/todo_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //reference our box
  final _myBox = Hive.box("myBox");
  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    //check if this is the first time ever time opening
    if(_myBox.get("TODOLIST") == null){
      db.createInitialData();
    } else {
      //this is not the first time lunching the app
      db.loadData();
    }

    super.initState();
  }
  // text controller
  final _controller = TextEditingController();

  //save new task method
  void saveNewTask(){
    setState(() {
      db.toDoList.add([_controller.text,false]);
      _controller.clear();
    });
    db.updateDataBase();
    Navigator.of(context).pop();
  }


  //checkbox method (on tap)
  void checkBoxTap(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  //create a new todo
  void createNewToDo() {
    showDialog(
      context: context,
      builder: (context) => DialogBox(
        controller: _controller,
        onCancel: (){Navigator.of(context).pop();},
        onSave: saveNewTask,
      ),
    );
  }

  //delete existing todo
  void deleteToDo(int index){
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFCACA),
      appBar: AppBar(
        backgroundColor: Color(0xFF372948),
        title: Center(child: const Text("Flutter ToDo App",textAlign: TextAlign.center)),
        elevation: 1,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF372948),
        child: const Icon(Icons.add),
        onPressed: createNewToDo,
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) => checkBoxTap(value, index),
            deleteToDo: (context) => deleteToDo(index),
          );
        },
      ),
    );
  }
}
