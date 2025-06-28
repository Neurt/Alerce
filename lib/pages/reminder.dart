import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:alerce1/colour.dart';
import 'package:alerce1/class/todo.dart';
import 'package:alerce1/layout/todo_item.dart';

class ReminderPage extends StatefulWidget {
  @override
  _ReminderPageState createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  final TextEditingController _todoController = TextEditingController();
  List<ToDo> _todoList = [];
  List<ToDo> _foundToDo = [];

  Future<void> _updateTodoInFirebase(ToDo todo) async {
    var uri = Uri.parse(
        'https://flutter-chat-app-39efc-default-rtdb.asia-southeast1.firebasedatabase.app/todoapp/${todo.id}.json');

    try {
      await http.patch(
        uri,
        body: json.encode({'isDone': todo.isDone}),
      );
    } catch (e) {
      print('Error updating todo in Firebase: $e');
    }
  }

  void _deleteTodoInFirebase(String id) async {
    var uri = Uri.parse(
        'https://flutter-chat-app-39efc-default-rtdb.asia-southeast1.firebasedatabase.app/todoapp/$id.json');

    try {
      await http.delete(uri);
    } catch (e) {
      print('Error deleting todo: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _loadLocalTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainPeach,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            child: Column(
              children: [
                _buildSearchBox(),
                const SizedBox(height: 20,),
                Expanded(
                  child: ListView.builder(
                    itemCount: _todoList.length,
                    itemBuilder: (context, index) {
                      var todoItem = _todoList[index];
                      return ToDoItem(
                        todo: todoItem,
                        onToDoChanged: _handleToDoChange,
                        onDeleteItem: _deleteToDoItem,
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                    left: 20,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _todoController,
                    decoration: InputDecoration(
                      hintText: 'Add a new todo item',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  bottom: 20,
                  right: 20,
                ),
                child: ElevatedButton(
                  child: Text(
                    '+',
                    style: TextStyle(
                      fontSize: 40,
                    ),
                  ),
                  onPressed: () {
                    _addToDoItem(_todoController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainBlue,
                    minimumSize: Size(60, 60),
                    elevation: 10,
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
      _updateTodoInLocalStorage();
      _updateTodoInFirebase(todo); // Add this line to update Firebase
    });
  }

  void _deleteToDoItem(String id) async {
    ToDo todoToDelete = _todoList.firstWhere((item) => item.id == id);

    setState(() {
      _todoList.removeWhere((item) => item.id == id);
      _updateTodoInLocalStorage();
    });

    await _updateTodoInFirebase(todoToDelete);
    _deleteTodoInFirebase(id);
  }

  void _addToDoItem(String toDo) async {
    if (toDo.isNotEmpty) {
      ToDo newTodo = ToDo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        todoText: toDo,
        isDone: false,
      );

      setState(() {
        _todoList.add(newTodo);
        _todoController.clear();
        _updateTodoInLocalStorage();
      });

      await _addTodoToFirebase(newTodo);
    }
  }

  Future<void> _addTodoToFirebase(ToDo newTodo) async {
    var uri = Uri.parse(
        'https://flutter-chat-app-39efc-default-rtdb.asia-southeast1.firebasedatabase.app/todoapp.json');

    try {
      var response = await http.post(
        uri,
        body: json.encode(newTodo.toJson()),
      );

      if (response.statusCode == 200) {
        newTodo.id = json.decode(response.body)['name'];
        setState(() {
          _updateTodoInLocalStorage();
        });
      } else {
        throw Exception('Failed to add todo');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void _updateTodoInLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
      'todos',
      json.encode(_todoList.map((todo) => todo.toJson()).toList()),
    );
  }

  void _loadLocalTodos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedTodos = prefs.getString('todos');
    if (savedTodos != null) {
      List<dynamic> decodedTodos = json.decode(savedTodos);
      List<ToDo> loadedTodos =
          decodedTodos.map((todo) => ToDo.fromJson(todo)).toList();
      setState(() {
        _todoList = loadedTodos;
      });
    }
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: mainBlue,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 40,
            width: 40,
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: mainGrey),
        ),
      ),
    );
  }

  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = _todoList;
    } else {
      results = _todoList
          .where((item) => item.todoText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundToDo = results;
    });
  }
}

void main() {
  runApp(MaterialApp(
    home: ReminderPage(),
  ));
}
