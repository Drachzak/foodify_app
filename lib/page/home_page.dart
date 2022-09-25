import 'package:flutter/material.dart';
import 'package:restaurant_app/model/response_filter.dart';
import 'package:restaurant_app/network/net_client.dart';
import 'package:restaurant_app/page/favorite_page.dart';
import 'package:restaurant_app/ui/list_meal.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  ResponseFilter? responseFilter;
  bool isLoading = true;

  void fetchDataMeals() async {
    try{
      NetClient client = NetClient();
      var data = await client.fetchDataMeals(currentIndex);
      setState(() {
        responseFilter = data;
        isLoading = false;
      });
    }
    catch (e) {
      print(e);
    }
  }
  @override
  void initState() {
    super.initState();
    fetchDataMeals();
  }

  @override
  Widget build(BuildContext context) {
    var listNav = [listItems(responseFilter),listItems(responseFilter)];
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                FavoritePage(indexNav: currentIndex)
            ));
          }, icon: Icon(Icons.favorite_border))
        ],
      ),
      body: Center(
        child: isLoading == false
            ? listNav[currentIndex]
            : CircularProgressIndicator(),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   selectedItemColor: Colors.lightBlue,
      //   currentIndex: currentIndex,
      //   items: <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(icon: Icon(Icons.table_chart),label: "Items"),
      //   ],
      //   onTap: (index){
      //     setState(() {
      //       currentIndex = index;
      //     });
      //     fetchDataMeals();
      //   },
      // ),
    );
  }
}
