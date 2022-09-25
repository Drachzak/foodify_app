import 'dart:convert';
import 'package:http/http.dart';
import 'package:restaurant_app/model/response_filter.dart';

class NetClient{
  String url = "https://fakestoreapi.com/";
  late String endPoint;


  Future<ResponseFilter?> fetchDataMeals(int currentIndex) async {
     currentIndex == 0;
      endPoint = "products";

    try {
      var res = await get(Uri.parse(url + endPoint));
      if(res.statusCode == 200){
        Map<String,dynamic> json = jsonDecode(res.body);
        ResponseFilter data = ResponseFilter.fromJson(json);
        return data;
    }
    } catch (e) {
      print(e);
      return null;
    }
  }
}

//https://www.themealdb.com/api/json/v1/1/"