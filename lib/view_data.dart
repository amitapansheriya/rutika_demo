import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rutika_demo/main.dart';

class view_data extends StatefulWidget {
  const view_data({Key? key}) : super(key: key);

  @override
  State<view_data> createState() => _view_dataState();
}

class _view_dataState extends State<view_data> {
  get()
  async {
    var url = Uri.parse('https://fluttercdmi.000webhostapp.com/view_demo.php');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    List l=jsonDecode(response.body);
    return l;

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
  body: FutureBuilder(future: get(),
    builder: (context, snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting){
             return CircularProgressIndicator();
        }
        else{
          List l=snapshot.data as List;
         // print(l);
            return ListView.builder(
              itemCount: l.length,
              itemBuilder: (context, index) {
               return Card(
                 child: ListTile(
                    title: Text("${l[index]['name']}"),
                    subtitle: Text("${l[index]['contact']}"),
                   trailing: Wrap(
                     children: [
                       IconButton(onPressed: () async {
                         var url = Uri.parse('https://fluttercdmi.000webhostapp.com/delete_demo.php?id=${l[index]['id']}');
                         var response = await http.get(url);
                         print('Response status: ${response.statusCode}');
                         print('Response body: ${response.body}');
                         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                             return view_data();
                         },));
                       }, icon: Icon(Icons.delete)),
                       IconButton(onPressed: () {

                         Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return first(l[index]['id'],l[index]['name'],l[index]['contact']);
                         },));
                       }, icon: Icon(Icons.edit))
                     ],
                   ),
                 ),
               );
            },);
        }
  },),
    );
  }
}
