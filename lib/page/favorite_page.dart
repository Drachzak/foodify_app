import 'package:flutter/material.dart';
import 'package:restaurant_app/database/db_helper.dart';
import 'package:restaurant_app/model/response_filter.dart';
import 'package:restaurant_app/ui/list_meal.dart';

class FavoritePage extends StatefulWidget {
  final int indexNav;

  const FavoritePage({Key? key, required this.indexNav}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  int currentIndex = 0;
  String category = "Items";
  ResponseFilter? responseFilter;
  bool isLoading = true;
  var db = DBHelper();

  void fetchDataMeals() async {
    var data = await db.gets(category);
    setState(() {
      responseFilter = ResponseFilter(items: data);
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchDataMeals();
    currentIndex = widget.indexNav;
  }

  @override
  Widget build(BuildContext context) {
    var listNav = [listItems(responseFilter), listItems(responseFilter)];
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Items'),
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: isLoading == false
            ? listNav[currentIndex]
            : CircularProgressIndicator(),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   selectedItemColor: Colors.amber,
      //   currentIndex: currentIndex,
      //   items: <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(icon: Icon(Icons.table_chart), label: "Items"),
      //   ],
      //   onTap: (index) {
      //     setState(() {
      //       currentIndex = index;
      //       index == 0 ? category = "Items" : category;
      //     });
      //     fetchDataMeals();
      //   },
      // ),
    );
  }
}
