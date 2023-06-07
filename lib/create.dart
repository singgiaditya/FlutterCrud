import 'package:crud/editData.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Create extends StatefulWidget {
  const Create({super.key});

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
  late Map detailUser = {};
  String apiUrl = 'https://reqres.in/api/users';

   Future<void> postUser(String name, String job) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    Map<String, String> body = {
      'name': name,
      'job': job,
    };


    http.Response response = await http.post(Uri.parse(apiUrl), headers: headers, body: json.encode(body));
    if (response.statusCode == 201) {
      setState(() {
        detailUser = json.decode(response.body);
      });
    } else {
      // Gagal melakukan permintaan Post
      print('Gagal menyimpan user');
    }
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController jobController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    jobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create User"),
      ),
      body: SafeArea(child: ListView(
        children: [
          Column(
            children: [
              TextField(controller: nameController, decoration: new InputDecoration(hintText: "Masukkan Nama"),),
              TextField(controller: jobController, decoration: new InputDecoration(hintText: "Masukkan Pekerjaan")),
              ElevatedButton(
                  onPressed: () {
                    postUser(nameController.text, jobController.text);
                  },
                  child: Text("Save"),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(40), // NEW
                  ),
                ),
                Text(detailUser['name'] != null ? "Name : ${detailUser['name']}" : "Name :"),
                Text(detailUser['job'] != null ? "Job : ${detailUser['job']}" : "Job :"),
                Text(detailUser['id'] != null ? "id : ${detailUser['id']}" : "id :"),
                Text(detailUser['createdAt'] != null ? "createdAt : ${detailUser['createdAt']}" : "createdAt :"),
            ],
          )
        ],
      )),
    );
  }
}