import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List toDolist = [];
  final _mybox = Hive.box('mybox');
  void createinitialdata() {
    toDolist = [
      ['wake up', false],
      ['do exercise', false],
    ];
  }

  void loadData() {
    toDolist = _mybox.get('TODOLIST');
  }

  void updatedatabase() {
    _mybox.put('TODOLIST', toDolist);
  }
}
