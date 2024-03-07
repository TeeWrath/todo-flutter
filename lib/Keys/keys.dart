import 'package:flutter/material.dart';
import 'package:todolist/Keys/checkable_todo_item.dart';

class Todo {
  const Todo(this.text, this.priority);
  final String text;
  final Priority priority;
}

class Keys extends StatefulWidget {
  const Keys({super.key});

  @override
  State<Keys> createState() => _KeysState();
}

class _KeysState extends State<Keys> {
  var _order = 'asc'; // variable to determine order change

  // List to store all the todos
  final _todo = const [
    Todo("run", Priority.urgent),
    Todo('Read', Priority.low),
    Todo('Sleep', Priority.normal)
  ];

  // getter function to get the ordered list
  List<Todo> get _orderedTodos {
    final sortedTodos = List.of(_todo);
    sortedTodos.sort((a, b) {
      final bComesAfterA = a.text.compareTo(b.text);
      return _order == 'asc' ? bComesAfterA : -bComesAfterA;
    });
    return sortedTodos;
  }

  // function to change the order state
  void _changeOrder() {
    setState(() {
      _order = _order == 'asc' ? 'desc' : 'asc';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
              onPressed: _changeOrder,
              icon: Icon(
                _order == 'asc' ? Icons.arrow_downward : Icons.arrow_upward,
              ),
              label:
                  Text('Sort ${_order == 'asc' ? 'Descending' : 'Ascedning'}')),
        ),
        Expanded(child: Column(
          children: [
            for (final todo in _orderedTodos)
            CheckableTodoItem(
              key: ValueKey(todo.text),
              todo.text,
              todo.priority
            )
          ],
        ))
      ],
    );
  }
}
