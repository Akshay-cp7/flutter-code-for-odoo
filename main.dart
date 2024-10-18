import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Fetch JSON Example',
      home: TodoScreen(),
    );
  }
}

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  String gender = '';
  String name = '';
  String department = '';
  @override
  void initState() {
    super.initState();
    fetchTodo();
  }

  Future<void> fetchTodo() async {
    final response = await http
        .get(Uri.parse('http://localhost:8069/get_total_studentsjs/13'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      setState(() {
        gender = jsonResponse['gender'];
        name = jsonResponse['name'];
        department = jsonResponse['dept'];
      });
    } else {
      throw Exception('Failed to load todo');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo Item'),
      ),
      body: Center(
        child: name.isEmpty
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('name: $name', style: const TextStyle(fontSize: 20)),
                  Text('gender: $gender', style: const TextStyle(fontSize: 20)),
                  Text('department: $department',
                      style: const TextStyle(fontSize: 20)),
                ],
              ),
      ),
    );
  }
}
