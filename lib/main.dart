import 'package:flutter/material.dart';
import 'components/todolist.dart';
import 'package:provider/provider.dart';
import 'components/provider.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(
          create: (BuildContext context) => TodoListProvider(),
          child: new TodolistView()),
     
    );
  }
}
