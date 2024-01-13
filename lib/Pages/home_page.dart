import 'dart:ffi';

import "package:flutter/material.dart";
import 'package:project/Constants/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:project/Models/todo.dart';
import 'package:project/Widgets/app_bar.dart';
import 'package:project/Widgets/app_bar.dart';
import 'package:project/Widgets/todo_container.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<String> myTodos = [
  ];
  List<int> tt = [0, 1, 2, 3, 4, 5];
  List<Todo> myTo = [];
  // bool isLoading = false;
  String temp = "";
  String temp2 = "";
  void fetchData() async {
    try {
      http.Response response = await http.get(Uri.parse(api));
      // var data = response.body;
      var data = jsonDecode((response.body));
      // print(data.runtimeType);
      // print(data);
      // data.forEach((todo) {
      //   Todo t = Todo(
      //     id: todo['id'],
      //     title: todo['title'],
      //     desc: todo['desc'],
      //   );
      //   print(t.desc);
      //   myTodos.add(t);
      // });

      for (int i = 0; i <= 3; i++) {
        Todo t = Todo(
          id: data[i]['id'],
          title: data[i]['title'],
          desc: data[i]['desc'],
        );
        // print(t.title);
        myTo.add(t);
      }
      print(myTo[1].title);
      // for (var todo in data) {
      //   Todo t = Todo(
      //     id: todo['id'],
      //     title: todo['title'],
      //     desc: todo['desc'],
      //   );
      //   print(t.desc);
      //   myTodos.add(t);
      // }
      // print(data);
      // print(myTodos[0]);
      // setState(() {
      //   isLoading = false;
      // });
    } catch (e) {
      print("error is $e");
    }
  }

  void delete_todo(String e) {
    setState(() {
      myTodos.removeWhere((str) {
        return str == e;
      });
      
    });
  }

  void addTodo(String newTodo) {
    setState(() {
      myTodos.add(newTodo);
    });
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

Future<void> _showAddProductDialog(BuildContext context) async {
    TextEditingController _productNameController = TextEditingController();

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Product'),
          content: TextField(
            controller: _productNameController,
            decoration: InputDecoration(labelText: 'Product Name'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Add the new product to the list and close the dialog
                String newProduct = _productNameController.text.trim();
                if (newProduct.isNotEmpty) {
                  addTodo(newProduct);
                }
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF001133),
        appBar: customAppBar(()=>_showAddProductDialog(context)),
        body: ListView(
          children: myTodos.map((e) {
            return TodoContainer(
              // id: e.id,

              onPress: () => delete_todo(e),
              title: e,
              // desc: e,
            );
          }).toList(),
        ));
  }
}

AppBar customAppBar(VoidCallback onAddPressed) {
  return AppBar(
    title: Text('Todo List'),
    actions: [
      IconButton(
        icon: Icon(Icons.add),
        onPressed: onAddPressed,
      ),
    ],
  );
}


