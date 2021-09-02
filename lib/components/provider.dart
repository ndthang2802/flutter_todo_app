import 'package:flutter/material.dart';
import 'todo.dart';

class TodoListProvider extends ChangeNotifier {
  List<Todo> todos = <Todo>[
    Todo(name: 'test1', done: false),
    Todo(name: 'test2', done: false),
    Todo(name: 'test3', done: false),
  ];
  List<int> selectedTodos = <int>[];
  bool doneAll = false;
  void selected(int index) {
    if (selectedTodos.contains(index)) {
      selectedTodos.remove(index);
    } else
      selectedTodos.add(index);
    notifyListeners();
  }

  void SelectedAll() {
    if (todos.length == selectedTodos.length) {
      selectedTodos = <int>[];
    } else {
      selectedTodos = <int>[];
      selectedTodos = [for (var i = 0; i < todos.length; i++) i];
    }
    notifyListeners();
  }

  void markDoneAll() {
    if (doneAll) {
      for (final item in todos) {
        item.done = false;
      }
      doneAll = false;
    } else {
      for (final item in todos) {
        item.done = true;
      }
      doneAll = true;
    }
    notifyListeners();
  }

  void deleteAllSelected() {
    for (final index in selectedTodos) {
      todos.removeAt(index);
    }
    selectedTodos = <int>[];
    notifyListeners();
  }

  void deleteAll() {
    selectedTodos = <int>[];
    todos = <Todo>[];
    notifyListeners();
  }

  void addTodo(Todo item) {
    todos.add(item);
    notifyListeners();
  }

  void removeTodo(int index) {
    todos.removeAt(index);
    notifyListeners();
  }

  void markTodoDone(int index) {
    todos[index].done = !todos[index].done;
    notifyListeners();
  }

  List<Todo> getListTodo() {
    return todos;
  }

  int getListTodoLength() {
    return todos.length;
  }
}
