import 'package:final_project/utility/dialogbox.dart';
import 'package:final_project/utility/todo.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox= Hive.openBox("myBox");
  final _controller = TextEditingController();

  List toDoList = [
    ["Pay Rent", false],
    ["Pay Bills", false],
    ["Pay Fee", false],
    ["Pay Insurance", false],
  ];
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      toDoList[index][1]=!toDoList[index][1];
    });

  }
  void saveNewTask() {
    setState(() {
      toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
  }
  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller ,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
      },
    );
  }
  void deleteTask(int index) {
    setState(() {
      toDoList.removeAt(index);
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.green[200],
      appBar: AppBar(
        title: Text('To-Do'),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(taskName: toDoList[index][0], taskCompleted: toDoList[index][1], onChanged: (value) => checkBoxChanged(value, index),
          deleteFunction: (context) => deleteTask(index),);
        },


          ),
      );
  }
}
