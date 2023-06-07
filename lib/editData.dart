import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditData extends StatefulWidget {
  final int IDuser;
  const EditData({super.key, required this.IDuser});

  @override
  State<EditData> createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  late Map detailUser = {};
  late Map updatedUser = {};
  String apiUrl = 'https://reqres.in/api/users/';

  final TextEditingController nameController = TextEditingController();
  final TextEditingController jobController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    jobController.dispose();
    super.dispose();
  }

  getUsers() async {
    http.get(Uri.parse(apiUrl + widget.IDuser.toString())).then((res) {
      Map userData = json.decode(res.body);
      setState(() {
        detailUser = userData["data"];
      });
    });
  }

  
  Future<void> updateUser(String name, String job) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    Map<String, String> body = {
      'name': name,
      'job': job,
    };

    http.Response response = await http.put(Uri.parse(apiUrl + widget.IDuser.toString()), headers: headers, body: json.encode(body));
    if (response.statusCode == 200) {
      setState(() {
        updatedUser = json.decode(response.body);
      });
    } else {
      // Gagal melakukan permintaan PUT
      print('Gagal mengupdate user');
    }
  }

  @override
  void initState() {
    getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit User"),
      ),
      body: detailUser.length == 0
          ? Center(child: Text("No user Found"))
          :Container(
        margin: EdgeInsets.all(12),
        width: double.infinity,
        child: SafeArea(
          child: ListView(
            children: [Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(detailUser['avatar']),
                  backgroundColor: Colors.blue,
                  radius: 120,
                ),
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: nameController..text = '${detailUser['first_name']} ${detailUser['last_name']}',
                    style: GoogleFonts.inter(fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  height: 120,
                  margin: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("ID", style: GoogleFonts.inter(fontSize: 20)),
                          SizedBox(
                            width: 250,
                            child: Text(detailUser['id'].toString(),
                                style: GoogleFonts.inter(fontSize: 20)),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.email),
                          SizedBox(
                            width: 250,
                            child: Text(detailUser['email'],
                                style: GoogleFonts.inter(fontSize: 16)),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.cases_outlined),
                          SizedBox(
                            width: 250,
                            child: TextField(
                              controller: jobController,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 20)),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(updatedUser['name'] != null ? "Name : ${updatedUser['name']}" : "Name :"),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(updatedUser['job'] != null ? "Job : ${updatedUser['job']}" : "Job :"),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(updatedUser['updatedAt'] != null ? "Updated at : ${updatedUser['updatedAt']}" : "Updated at : "),
                ),
                Padding(padding: EdgeInsets.only(top: 40)),
                ElevatedButton(
                  onPressed: () {
                    updateUser(nameController.text, jobController.text);
                  },
                  child: Text("Update"),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(40), // NEW
                  ),
                )
              ],
            ),]
          ),
        ),
      ),
    );
  }
}
