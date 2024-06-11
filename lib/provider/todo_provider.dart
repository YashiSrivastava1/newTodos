import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/todo.dart';
import 'package:new_todo/todo_item.dart';
import 'notifierProvider.dart';

final todoListProvider = StateProvider<List<ToDo>>((ref) {
  return ToDo.todoList();
});
