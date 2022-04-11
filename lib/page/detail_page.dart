import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:restaurant_app/database/db_helper.dart';
import 'package:restaurant_app/model/meal_item.dart';
import 'package:restaurant_app/model/response_detail.dart';
import 'package:http/http.dart' as http;

class DetailPage extends StatefulWidget {
  final String idMeal;

  DetailPage({required this.idMeal});

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
          'https://www.themealdb.com/api/json/v1/1/lookup.php?i=${widget.idMeal}'));
      isFavorite = await db.isFavorite(widget.idMeal);
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
    Meal favorite = Meal(
      idMeal: dataDetail.meals[0]['idMeal'],
      strMeal: dataDetail.meals[0]['strMeal'],
      strMealThumb: dataDetail.meals[0]['strMealThumb'],
      strInstructions: dataDetail.meals[0]['strInstructions'],
      strCategory: dataDetail.meals[0]['strCategory'],
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
        title: Text('Detail Resep Makanan'),
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
                              dataDetail.meals[0]['strMealThumb']),
                        ),
                        tag: '${dataDetail.meals[0]['idMeal']}',
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Center(
                      child: Text('${dataDetail.meals[0]['strMeal']}'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Center(
                      child: Text('Instructions'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Center(
                      child: Text('${dataDetail.meals[0]['strInstructions']}'),
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
