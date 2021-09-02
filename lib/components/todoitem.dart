import 'package:flutter/material.dart';
import 'todo.dart';

class TodoItem extends StatefulWidget {
  TodoItem(
      {required this.todo,
      required this.index,
      required this.isSelected,
      required this.markTodoDone,
      required this.removeTodo,
      required this.onSelected})
      : super(key: ObjectKey(todo));
  final Todo todo;
  final markTodoDone;
  final removeTodo;
  final onSelected;
  final index;
  final isSelected;

  @override
  _TodoItemState createState() => new _TodoItemState();
}

class _TodoItemState extends State<TodoItem> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: Duration(milliseconds: 300),
    vsync: this,
  );

  void initState() {
    super.initState();
    _controller.repeat(reverse: true);
    _controller.forward();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  TextStyle? _getTextStyle(bool done, bool isSelected) {
    if (!done) {
      return TextStyle(
          color: isSelected ? Colors.green : Colors.black,
          fontWeight: isSelected ? FontWeight.w900 : FontWeight.normal);
    }
    return TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
        position: CurvedAnimation(
          curve: Curves.easeOut,
          parent: _controller,
        ).drive((Tween<Offset>(
          begin: widget.index % 2 == 0 ? Offset(1, 0) : Offset(-1, 0),
          end: Offset(0, 0),
        ))),
        child: Row(children: [
          Expanded(
            child: ListTile(
                onTap: () {
                  widget.onSelected(widget.index);
                },
                leading: widget.isSelected
                    ? Icon(
                        Icons.check,
                        color: Colors.green[400],
                      )
                    : CircleAvatar(
                        backgroundColor: widget.todo.done
                            ? Colors.greenAccent
                            : Colors.redAccent,
                        child: Text(
                          widget.todo.name[0],
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                title: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color:
                            widget.todo.done ? Colors.grey : Colors.lightBlue,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: widget.isSelected
                          ? Colors.lightBlue[50]
                          : Colors.white,
                    ),
                    child: Text(
                      widget.todo.name,
                      style: _getTextStyle(widget.todo.done, widget.isSelected),
                    ))),
          ),
          Container(
            decoration:
                ShapeDecoration(shape: CircleBorder(), color: Colors.lightBlue),
            child: new IconButton(
              icon: Icon(Icons.checklist_rtl),
              color: Colors.white,
              onPressed: () {
                widget.markTodoDone(widget.index);
              },
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            decoration:
                ShapeDecoration(shape: CircleBorder(), color: Colors.redAccent),
            child: new IconButton(
              icon: Icon(Icons.delete),
              color: Colors.white,
              onPressed: () {
                widget.removeTodo(widget.index);
              },
            ),
          ),
        ]));
  }
}
