import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'todo.dart';
import '/todo_item.dart';
import '../provider/todo_provider.dart';

class Home extends ConsumerStatefulWidget {
  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  List<ToDo> _foundToDo = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _foundToDo = ref.read(todoListProvider);
  }

  @override
  Widget build(BuildContext context) {
    final todosList = ref.watch(todoListProvider);

    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                SizedBox(height: 100),
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50, bottom: 20),
                        child: Text(
                          'Todo List',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      for (ToDo todoo in _foundToDo.reversed)
                        ToDoItem(
                          todo: todoo,
                          onToDoChanged: _handleToDoChange,
                          onDeleteItem: _deleteToDoItem,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Row(children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                      hintText: 'Create a todo',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20, right: 20),
                child: ElevatedButton(
                  child: Text(
                    '+',
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                  onPressed: () {
                    _addToDoItem(_todoController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
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
    });
  }

  void _deleteToDoItem(String id) {
    ref.read(todoListProvider.notifier).update((state) {
      return state.where((item) => item!.id != id).toList();
    });
  }

  void _addToDoItem(String toDo) {
    ref.read(todoListProvider.notifier).update((state) {
      return [
        ...state,
        ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: toDo,
        ),
      ];
    });
    _todoController.clear();
  }

  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = ref.read(todoListProvider);
    } else {
      results = ref
          .read(todoListProvider)
          .where((item) => item!.todoText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundToDo = results;
    });
  }

  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(Icons.search, color: Colors.grey, size: 20),
          prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.grey,
      elevation: 0,
      title: Center(
        child: Text(
          'Todo App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'todo.dart';
// import 'provider/todo_provider.dart';
// import '/todo_item.dart';

// class Home extends ConsumerWidget {
//   Home({Key? key}) : super(key: key);

//   final _todoController = TextEditingController();

//   @override
//   Widget build(BuildContext context, ScopedReader watch) {
//     final todosList = watch(todoListProvider);

//     return Scaffold(
//       backgroundColor: Colors.grey,
//       appBar: _buildAppBar(),
//       body: Stack(
//         children: [
//           Container(
//             padding: EdgeInsets.symmetric(
//               horizontal: 20,
//               vertical: 15,
//             ),
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 100,
//                 ),
//                 searchBox(context),
//                 Expanded(
//                   child: ListView(
//                     children: [
//                       Container(
//                         margin: EdgeInsets.only(
//                           top: 50,
//                           bottom: 20,
//                         ),
//                         child: Text(
//                           'Todo List',
//                           style: TextStyle(
//                             fontSize: 30,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                       for (ToDo todo in todosList.reversed)
//                         ToDoItem(
//                           todo: todo,
//                           onToDoChanged: (todo) => context.read(todoListProvider.notifier).updateToDoStatus(todo),
//                           onDeleteItem: (id) => context.read(todoListProvider.notifier).deleteToDoItem(id),
//                         ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//           Align(
//             alignment: Alignment.topCenter,
//             child: Row(children: [
//               Expanded(
//                 child: Container(
//                   margin: EdgeInsets.only(
//                     bottom: 20,
//                     right: 20,
//                     left: 20,
//                   ),
//                   padding: EdgeInsets.symmetric(
//                     horizontal: 20,
//                     vertical: 5,
//                   ),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     boxShadow: const [
//                       BoxShadow(
//                         color: Colors.grey,
//                         offset: Offset(0.0, 0.0),
//                         blurRadius: 10.0,
//                         spreadRadius: 0.0,
//                       ),
//                     ],
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: TextField(
//                     controller: _todoController,
//                     decoration: InputDecoration(
//                         hintText: 'Create a todo', border: InputBorder.none),
//                   ),
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.only(
//                   bottom: 20,
//                   right: 20,
//                 ),
//                 child: ElevatedButton(
//                   child: Text(
//                     '+',
//                     style: TextStyle(
//                       fontSize: 40,
//                       color: Colors.white,
//                     ),
//                   ),
//                   onPressed: () {
//                     context.read(todoListProvider.notifier).addToDoItem(_todoController.text);
//                     _todoController.clear();
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.black,
//                     minimumSize: Size(60, 60),
//                     elevation: 10,
//                   ),
//                 ),
//               ),
//             ]),
//           ),
//           SizedBox(height: 20,)
//         ],
//       ),
//     );
//   }

//   Widget searchBox(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 15),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: TextField(
//         onChanged: (value) => context.read(todoListProvider.notifier).searchToDoItems(value),
//         decoration: InputDecoration(
//           contentPadding: EdgeInsets.all(0),
//           prefixIcon: Icon(
//             Icons.search,
//             color: Colors.grey,
//             size: 20,
//           ),
//           prefixIconConstraints: BoxConstraints(
//             maxHeight: 20,
//             minWidth: 25,
//           ),
//           border: InputBorder.none,
//           hintText: 'Search',
//           hintStyle: TextStyle(color: Colors.grey),
//         ),
//       ),
//     );
//   }

//   AppBar _buildAppBar() {
//     return AppBar(
//       backgroundColor: Colors.grey,
//       elevation: 0,
//     );
//   }
// }

