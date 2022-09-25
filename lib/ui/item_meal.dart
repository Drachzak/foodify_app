import 'package:flutter/material.dart';

Widget itemOutfit(String? id, String? title, String? image) {
  return Padding(
    padding: EdgeInsets.all(8),
    child: Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Hero(
            tag: id!,
            child: Image.network(
              image!,
              height: 230,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          left: 10,
          bottom: 15,
          child: Text(
            title!,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
              shadows: [
                Shadow(
                  offset: Offset(5,4),
                  blurRadius: 6,
                  color: Colors.black
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}
