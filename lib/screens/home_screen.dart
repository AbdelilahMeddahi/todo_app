import 'package:flutter/material.dart';
import 'package:todo_app/utils/dialog_box.dart';
import 'package:todo_app/utils/todo_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // text controller
  final _controller = TextEditingController();

  //save new task method
  void saveNewTask(){
    setState(() {
      toDoList.add([_controller.text,false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
  }

  List toDoList = [
    ["Hello", true],
    ["Hey", false],
    ["Hi", false],
  ];

  //checkbox method (on tap)
  void checkBoxTap(bool? value, int index) {
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
  }

  //create a new ToDo method
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

  //delete ToDo method
  void deleteToDo(int index){
    setState(() {
      toDoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: const Text("ToDO"),
        elevation: 1,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: createNewToDo,
      ),
      body: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: toDoList[index][0],
            taskCompleted: toDoList[index][1],
            onChanged: (value) => checkBoxTap(value, index),
            deleteToDo: (context) => deleteToDo(index),
          );
        },
      ),
    );
  }
}
