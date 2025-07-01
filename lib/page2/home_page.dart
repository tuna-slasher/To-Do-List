import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stateless_and_statefull/Utilities/ToDo_Tile.dart';
import 'package:stateless_and_statefull/Utilities/diolog_box.dart';
import 'package:stateless_and_statefull/data/database.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});
  @override
  State<Homepage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Homepage> {
  final _mybox = Hive.box('mybox');
  ToDoDatabase db = ToDoDatabase();
  @override
  void initState() {
    if (_mybox.get("TODOLIST") == null) {
      db.createinitialdata();
    } else {
      db.loadData();
    }
    super.initState();
  }

  final _controller = TextEditingController();

  void checkboxchanged(bool? value, int index) {
    setState(() {
      db.toDolist[index][1] = !db.toDolist[index][1];
    });
    db.updatedatabase();
  }

  void saveNewTask() {
    setState(() {
      db.toDolist.add([_controller.text, false]);
      _controller.clear();
      Navigator.of(context).pop();
    });
    db.updatedatabase();
  }

  void creatnewtask() {
    showDialog(
      context: context,
      builder: (context) {
        return DiologBox(
          controller: _controller,
          onsave: saveNewTask,
          oncancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      db.toDolist.removeAt(index);
    });
    db.updatedatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Center(
          child: Text("TO DO", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: creatnewtask,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.toDolist.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskname: db.toDolist[index][0],
            taskCompleted: db.toDolist[index][1],
            onchanged: (value) => checkboxchanged(value, index),
            deleteFunction: () => deleteTask(index),
          );
        },
      ),
    );
  }
}
