import 'package:crud/create.dart';
import 'package:crud/editData.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Read extends StatefulWidget {
  const Read({super.key});

  @override
  State<Read> createState() => _ReadState();
}

class _ReadState extends State<Read> {
  List _users = [];

  getUsers() async {
    http.get(Uri.parse('https://reqres.in/api/users?page=2')).then((res) {
      Map userData = json.decode(res.body);
      setState(() {
        _users = userData["data"];
      });
    });
  }

  deleteUser(String id, int index) {
    http.delete(Uri.parse('https://reqres.in/api/users/2')).then((res) {
      setState(() {
         _users.removeAt(index);
      });
    });
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
        title: Text("Users"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => getUsers(),
          )
        ],
      ),
      body: _users.length == 0
          ? Center(child: Text("No user Found, silahkan pencet tombol refresh"))
          : ListView.builder(
              itemCount: _users.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.blue
                  ),
                  margin: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(backgroundImage: NetworkImage(_users[index]['avatar']), radius: 35,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_users[index]['first_name']+" "+_users[index]['last_name'], style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),),
                          Text(_users[index]['email'], style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),)
                        ],
                      ),
                      Row(children: [
                        IconButton(onPressed: (){{
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                return  EditData(IDuser: _users[index]['id']);
              }));
                              }}, icon: Icon(Icons.edit)),
                      IconButton(onPressed: (){deleteUser(_users[index]['id'].toString(), index);}, icon: Icon(Icons.delete))
                      ],)
                      
                    ],
                  ),
                );
              },
            ),
            floatingActionButton: FloatingActionButton(onPressed: (){{
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                return  Create();
              }));
                              }}, child: Icon(Icons.add),)
    );
  }
}