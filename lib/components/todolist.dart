import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'todoitem.dart';
import 'provider.dart';
import 'todo.dart';
import 'circular_menu.dart';
import 'package:badges/badges.dart';

class TodolistView extends StatefulWidget {
  @override
  _TodolistViewState createState() => new _TodolistViewState();
}

class _TodolistViewState extends State<TodolistView> {
  final TextEditingController _todoTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Todo App'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: Column(
          children: [
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: Text('Your tasks',
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(color: Colors.black)),
                ),
                Consumer<TodoListProvider>(
                  builder: (context, todoListProvider, child) {
                    return Badge(
                        badgeColor: Colors.yellowAccent,
                        badgeContent: Text(
                            todoListProvider.getListTodoLength().toString()),
                        child: Icon(
                          Icons.list_outlined,
                          size: 40,
                        ));
                  },
                )
              ],
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Consumer<TodoListProvider>(
                      builder: (context, todoListProvider, child) {
                    return Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 24.0),
                          decoration: ShapeDecoration(
                              shape: CircleBorder(), color: Colors.greenAccent),
                          child: new IconButton(
                            icon: Icon(Icons.check_box_outlined),
                            color: Colors.black87,
                            onPressed: () {
                              todoListProvider.SelectedAll();
                            },
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          todoListProvider.selectedTodos.length.toString() +
                              ' items seleted',
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    );
                  }),
                  Consumer<TodoListProvider>(
                      builder: (context, todoListProvider, child) {
                    return Container(
                      margin: EdgeInsets.only(right: 60.0),
                      decoration: ShapeDecoration(
                          shape: CircleBorder(), color: Colors.greenAccent),
                      child: new IconButton(
                        icon: Icon(Icons.checklist_rtl),
                        color: Colors.blueGrey,
                        onPressed: () {
                          todoListProvider.markDoneAll();
                        },
                      ),
                    );
                  }),
                ],
              ),
            ),
            Expanded(child: Consumer<TodoListProvider>(
              builder: (context, todoListProvider, child) {
                return todoListProvider.getListTodoLength() != 0
                    ? ListView(
                        padding: EdgeInsets.all(8.0),
                        children:
                            todoListProvider.todos.asMap().entries.map((entry) {
                          int idx = entry.key;
                          Todo todo = entry.value;
                          return TodoItem(
                              index: idx,
                              isSelected:
                                  todoListProvider.selectedTodos.contains(idx),
                              todo: todo,
                              markTodoDone: todoListProvider.markTodoDone,
                              removeTodo: todoListProvider.removeTodo,
                              onSelected: todoListProvider.selected);
                        }).toList())
                    : Center(child: Text('You have nothing to do!.....'));
              },
            ))
          ],
        ),
        floatingActionButton: Stack(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(left: 31),
                child: create_CircularMenu()),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () {
                  _showDialog();
                },
                child: Icon(Icons.add),
              ),
            ),
          ],
        ));
  }

  Future<void> _showDialog() async {
    TodoListProvider todolistProvider =
        Provider.of<TodoListProvider>(context, listen: false);
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Add item to list'),
            content: TextField(
              controller: _todoTextController,
              decoration:
                  InputDecoration(labelText: 'Add todo', hintText: 'Add todo'),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    todolistProvider.addTodo(
                        Todo(name: _todoTextController.text, done: false));
                  },
                  child: Text('Add'))
            ],
          );
        });
  }
}
