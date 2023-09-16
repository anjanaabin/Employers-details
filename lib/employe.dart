import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;


class newone extends StatefulWidget {
  const newone({Key? key}) : super(key: key);

  @override
  State<newone> createState() => _newoneState();
}

class _newoneState extends State<newone> {
 Future<List<dynamic>>getdetails()
 async{
   final response=await http.get(Uri.parse('https://dummy.restapiexample.com/api/v1/employees'));
   if(response.statusCode==200){
     final data=jsonDecode(response.body);
   return data["data"];
   }else{
     throw Exception('loading');
   }
 }
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor:Colors.cyan ,
        title: Text("Details of employes"),
      ),
      body: FutureBuilder(
        future: getdetails(),
          builder:(context,
              AsyncSnapshot<List<dynamic>>snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator());
          }if(snapshot.hasData){
            return ListView.builder(itemCount:snapshot.data!.length,
            itemBuilder: (context,index){
              final details=snapshot.data![index];
              return Padding(padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                  ),
                  height: 100,
                  color: Colors.white,
                  child: ListTile(
                    title: Text('No:${details["id"]}'),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(details["employee_name"]),
                        Text('salary:${details["employee_salary"]}'),
                        Text('salary:${details["employee_age"]}'),

                      ],
                    ),



                  ),
                ),

              );
            },
            );
          }else {
            return Center(
                child: Text('something went wrong'),
            );
          }
          }

          )



    );
  }
}
