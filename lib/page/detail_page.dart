import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:restaurant_app/database/db_helper.dart';
import 'package:restaurant_app/model/meal_item.dart';
import 'package:restaurant_app/model/response_detail.dart';
import 'package:http/http.dart' as http;

class DetailPage extends StatefulWidget {
  final String id;

  DetailPage({required this.id});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late ResponseDetail dataDetail;
  bool isLoading = true;
  bool isFavorite = false;
  var db = DBHelper();

  Future<ResponseDetail?> fetchDetail() async {
    try {
      var res = await http.get(Uri.parse(
          'https://fakestoreapi.com/products${widget.id}'));
      isFavorite = await db.isFavorite(widget.id);
      print("Favorite : $isFavorite");
      if (res.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(res.body);
        ResponseDetail data = ResponseDetail.fromJson(json);
        if (mounted) {
          setState(() {
            dataDetail = data;
            isLoading = false;
          });
        }
        return data;
      } else {
        return null;
      }
    } catch (e) {
      print('failed $e');
      return null;
    }
  }

  setFavorite() async {
    var db = DBHelper();
    Items favorite = Items(
      id: dataDetail.items[0]['id'],
      title: dataDetail.items[0]['title'],
      price: dataDetail.items[0]['price'],
      description: dataDetail.items[0]['description'],
      category: dataDetail.items[0]['category'],
      image: dataDetail.items[0]['image'],
    );
    if (!isFavorite) {
      await db.insert(favorite);
      print("data favorite di tambahkan");
    } else {
      await db.delete(favorite);
      print("data favorit di hapus");
    }
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Item'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              setFavorite();
            },
            icon:
                isFavorite ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder<ResponseDetail?>(
          future: fetchDetail(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator(
                backgroundColor: Colors.orange,
                strokeWidth: 5,
              );
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  GestureDetector(
                    child: Center(
                      child: Hero(
                        child: Material(
                          child: Image.network(
                              dataDetail.items[0]['image']),
                        ),
                        tag: '${dataDetail.items[0]['id']}',
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Center(
                      child: Text('${dataDetail.items[0]['title']}'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Center(
                      child: Text('Description'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Center(
                      child: Text('${dataDetail.items[0]['description']}'),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
