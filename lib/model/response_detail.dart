import 'dart:convert';

ResponseDetail responseDetailFromJson(String string) =>
    ResponseDetail.fromJson(json.decode(string));


class ResponseDetail {
  late List<Map<String, dynamic>>items;

  ResponseDetail({required this.items});

  factory ResponseDetail.fromJson(Map<String, dynamic> json) =>
      ResponseDetail(items: List<Map<String, dynamic>>.from(json["meals"].map((x)=>
          Map.from(x).map((key, value) => MapEntry<String,dynamic>(key, value == null ? null : value)))));

  Map<String,dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((e) =>
          Map.from(e).map(
                  (key, value) =>
                      MapEntry<String, dynamic>(key, value == null ? null : value))))
      };

}
