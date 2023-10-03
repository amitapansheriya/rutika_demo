import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rutika_demo/view_data.dart';

void main()
{
     runApp(MaterialApp(home: first(),));
}
class first extends StatefulWidget {
  String ?id;
  String? name;
  String ?contact;
  first([this.id,this.name,this.contact]);


  @override
  State<first> createState() => _firstState();
}

class _firstState extends State<first> {
  TextEditingController t1=TextEditingController();
  TextEditingController t2=TextEditingController();

  @override
  void initState() {
      if(widget.id!=null)
        {
          t1.text=widget.name!;
          t2.text=widget.contact!;
        }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextField(
            controller: t1,
          ),
          TextField(
            controller: t2,
          ),
          ElevatedButton(onPressed: () async {
              String name=t1.text;
              String contact=t2.text;

              // var url = Uri.parse('https://fluttercdmi.000webhostapp.com/demo.php?name=$name&contact=$contact');
              // var response = await http.get(url);
              // print('Response status: ${response.statusCode}');
              // print('Response body: ${response.body}');

              if(widget.id!=null)
               {
                 var url = Uri.parse('https://fluttercdmi.000webhostapp.com/update_demo.php');
                 var response = await http.post(url, body: {'id':'${widget.id}','name': '$name', 'contact': '$contact'});
                 print('Response status: ${response.statusCode}');
                 print('Response body: ${response.body}');
               }
             else{
               var url = Uri.parse('https://fluttercdmi.000webhostapp.com/demo.php');
               var response = await http.post(url, body: {'name': '$name', 'contact': '$contact'});
               print('Response status: ${response.statusCode}');
               print('Response body: ${response.body}');
             }

          }, child: Text("Submit")),
          ElevatedButton(onPressed: () {
               Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return view_data();
               },));
          }, child: Text("view"))
        ],
      ),
    );
  }
}
