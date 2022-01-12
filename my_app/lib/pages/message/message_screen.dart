import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

Future<Album> fetchAlbum() async {
  var dio = Dio();
  final response =
      await dio.get('https://jsonplaceholder.typicode.com/albums/1');

  return Album.fromMap(response.data);
}

class _MessageScreenState extends State<MessageScreen> {
  List<String> items = List<String>.generate(5, (i) => 'Item $i');
  Future<Album> album = fetchAlbum();

  @override
  Widget build(BuildContext context) {
    Widget row1 = Row(
      children: const <Widget>[
        Expanded(
          child: Text('Deliver features faster', textAlign: TextAlign.center),
        ),
        Expanded(
          child: Text('Craft beautiful UIs', textAlign: TextAlign.center),
        ),
        Expanded(
          child: FittedBox(
            fit: BoxFit.contain, // otherwise the logo will be tiny
            child: FlutterLogo(),
          ),
        ),
      ],
    );

    Widget listView = ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index]),
          );
        });

    Widget testCallDio = Center(
      child: FutureBuilder<Album>(
          future: album,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!.title);
            }

            return const CircularProgressIndicator();
          }),
    );

    return Column(
      children: [row1, Expanded(child: listView), testCallDio],
    );
  }
}

class Album {
  final int userId;
  final int id;
  final String title;

  Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromMap(Map<String, dynamic> map) {
    return Album(
      userId: map['userId']?.toInt() ?? 0,
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
    );
  }

  factory Album.fromJson(String source) => Album.fromMap(json.decode(source));
}
