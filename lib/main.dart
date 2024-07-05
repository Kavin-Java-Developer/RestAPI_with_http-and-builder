import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List data = [];
  Future<void> fetchdata() async {
    final res = await http.get(Uri.parse('https://retoolapi.dev/fZwpGS/data'));
    print(res.statusCode);
    //print(res.body.toString());

    setState(() {
      data = jsonDecode(res.body);
      print(data.toString());
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: Text('Rest API with http (User Details)'),
        actions: [
          Icon(
            Icons.add_circle_outline,
            color: Colors.black,
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 150,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              image: DecorationImage(
                                  image: NetworkImage(data[index]['logo']),
                                  fit: BoxFit.cover)),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data[index]['fullname'],
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Text(data[index]['email']),
                          Text(data[index]['phone']),
                          Text(data[index]['rating']),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
