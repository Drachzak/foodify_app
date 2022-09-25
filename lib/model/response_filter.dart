import 'dart:convert';
import 'meal_item.dart';



ResponseFilter responseFilterFromJson(String string) =>
 ResponseFilter.fromJson(json.decode(string));

String responseFilterToJson(ResponseFilter data) => json.encode(data);

class ResponseFilter{
  ResponseFilter({
    this.items
});
  List<Items>? items;

  factory ResponseFilter.fromJson(Map<String,dynamic> json) => ResponseFilter(
    items: List<Items>.from(json["items"].map((e) => Items.fromJson(e))));
  
  Map<String, dynamic> toJson() => {
    "items" : List<dynamic>.from(items!.map((e) => e.toJson()))
  };
}