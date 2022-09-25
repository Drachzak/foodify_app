import 'package:flutter/material.dart';
import 'package:restaurant_app/model/response_filter.dart';
import 'package:restaurant_app/page/detail_page.dart';
import 'item_meal.dart';
import 'dart:io';

Widget listItems(ResponseFilter? responseFilter){
  if(responseFilter == null){
    return Container();
  }
  return ListView.builder(
    itemCount: responseFilter.items?.length,
      itemBuilder: (context, index){
      var itemMeal = responseFilter.items?[index];
      return InkWell(
        splashColor: Colors.lightBlue,
        child: itemOutfit (itemMeal?.id, itemMeal?.title, itemMeal?.image),
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(id: itemMeal?.id ?? "",)));
        },
      );
      });
}
