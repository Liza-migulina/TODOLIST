
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/database.dart';
import 'package:flutter_application_1/util/dialog_box.dart';
import 'package:flutter_application_1/util/todo_tile.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePage> {
final _mybox= Hive.box('mybox');
ToDoDataBase db=ToDoDataBase();
@override
void initState(){
  if (_mybox.get("TODOLIST")==null){
    db.createInitialData();
  } else{
    db.loadData();
  }
  
  super.initState();
}

  final _controller= TextEditingController();

  void checkBoxChanged(bool? value, int index){
    setState(() {
      db.toDoList[index] [1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

void saveNewTask(){
  setState(() {
    db.toDoList.add([ _controller.text, false]);
    _controller.clear();
  });
  Navigator.of(context).pop();
  db.updateDataBase();
}


  void createNewTask (){
    showDialog(
      context: context, 
      builder: (context){
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );

  }

void deleteTask(int index){
  setState(() {
    db.toDoList.removeAt(index);
  });
  db.updateDataBase();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[500],
      appBar: AppBar(
        title: Text('TO DO LIST'),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context,index){
          return ToDoTile(
            taskName: db.toDoList[index][0],
            taskComplete: db.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
            );
        },
            };
          ),
      );
}

}
