import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List toDoList = [];
  final _mybox = Hive.box('mybox');

  void createInitialData() {
    toDoList = [
      ["Make tutorial", false],
      ["Do Excercise", false],
    ];
  }

  void loadData() {
    toDoList = _mybox.get("TODOLIST");
  }

  void updateDataBase() {
    _mybox.put("TODOLIST", toDoList);
  }
}
