import 'package:flutter/material.dart';
import 'package:restaurant_app/color_constant.dart';
import 'package:restaurant_app/math_utils.dart';

Widget itemOutfit(String? id, String? title, String? image) {
  return SafeArea(
    child: Scaffold(
      backgroundColor: ColorConstant.whiteA700,
      body: Container(
        width: size.width,
        child: SingleChildScrollView(
          child: Container(
            height: getVerticalSize(
              250.00,
            ),
            width: size.width,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: getPadding(
                      right: 10,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          height: getVerticalSize(
                            250.00,
                          ),
                          width: getHorizontalSize(
                            133.00,
                          ),
                          child: Stack(
                            alignment: Alignment.topLeft,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Hero(
                                        child: Image.network(
                                          image!,
                                          height: 230,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                        tag: id!!,
                                      ),
                                    ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: getPadding(
                                    left: 9,
                                    top: 8,
                                    right: 10,
                                    bottom: 10,
                                  ),
                                  child: Text(
                                    "5.30",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: ColorConstant.black900,
                                      fontSize: getFontSize(
                                        12,
                                      ),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: getMargin(
                            left: 5,
                            top: 11,
                            bottom: 18,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: getPadding(
                                  right: 10,
                                ),
                                child: Text(
                                  title!,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: ColorConstant.black900,
                                    fontSize: getFontSize(
                                      20,
                                    ),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Container(
                                width: getHorizontalSize(
                                  220.00,
                                ),
                                margin: getMargin(
                                  top: 17,
                                  right: 10,
                                ),
                                child: Text(
                                  "new product has release bla bla bla bla bla new product has release bla bla bla bla blanew product has release bla bla bla bla blanew product has release bla bla bla bla blanew product has release bla bla bla bla blanew product has release bla bla bla bla blanew product has release bla bla bla bla blanew product has release bla bla bla bla bla",
                                  maxLines: null,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: ColorConstant.bluegray100,
                                    fontSize: getFontSize(
                                      12,
                                    ),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: getPadding(
                                    left: 10,
                                    top: 11,
                                  ),
                                  child: Text(
                                    "4.1",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: ColorConstant.gray900,
                                      fontSize: getFontSize(
                                        20,
                                      ),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
            ],
            ),
          ),
        ),

              ],
            ),
          ),
        ),
      ),
    ),
  );
}
