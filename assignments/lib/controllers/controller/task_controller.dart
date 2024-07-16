import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:assignments/models/task_model/task_model.dart';

enum Filter { all, completed, incomplete }

class TaskController extends GetxController {
  var todos = <TaskModel>[].obs;
  var filter = Filter.all.obs;

  updateFilter(Filter v)=>filter.value =v;
  List<TaskModel> get filteredTodos {
    switch (filter.value) {
      case Filter.completed:
        return todos.where((todo) => todo.isDone).toList();
      case Filter.incomplete:
        return todos.where((todo) => !todo.isDone).toList();
      default:
        return todos;
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadToDos();
  }

  void addToDo(TaskModel todo) {
    todos.add(todo);
    saveToDos();
  }

  void updateToDoStatus(String id, bool isDone) {
    var todo = todos.firstWhere((todo) => todo.id == id);
    todo.isDone = isDone;
    todos.refresh();
    saveToDos();
  }
  void updateToDo(TaskModel data,int index) {
    todos[index] = data;
    todos.refresh();
    saveToDos();
  }

  void deleteToDo(String id) {
    todos.removeWhere((todo) => todo.id == id);
    saveToDos();
  }

  void saveToDos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> toDosString =
        todos.map((todo) => jsonEncode(todo.toJson())).toList();
    prefs.setStringList('todos', toDosString);
  }

  void loadToDos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? toDosString = prefs.getStringList('todos');
    if (toDosString != null) {
      todos.assignAll(
        toDosString
            .map((item) => TaskModel.fromJson(jsonDecode(item)))
            .toList(),
      );
    }
  }
}
