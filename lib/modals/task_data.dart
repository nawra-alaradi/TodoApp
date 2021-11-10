import 'package:flutter/foundation.dart';
import 'package:todoey_flutter/modals/task.dart';
import 'dart:collection'; // import this

class TaskData extends ChangeNotifier {
  List<Task> _tasks = [];

  UnmodifiableListView<Task> get tasks => UnmodifiableListView(
      _tasks); // return a read only version of the private list

  int get taskCount => tasks.length;
  void addNewTask(String taskTitle) {
    _tasks.add(Task(name: taskTitle));
    notifyListeners();
  }

  void updateTask(Task task) {
    task.toggleDone();
    notifyListeners();
  }

  void deleteTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }

  void deleteAll() {
    _tasks.clear();
    notifyListeners();
  }
}
