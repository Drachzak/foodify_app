import 'dart:io' as io;
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:restaurant_app/model/meal_item.dart';

class DBHelper {
  //1
  DBHelper._creatInstance();

  //2
  static final DBHelper _instance = DBHelper._creatInstance();

  //3
  factory DBHelper() => _instance;

//4
  static Database? _db;

  //7
  Future<Database?> get db async {
    _db = await setDb();
    return _db ?? _db;
  }

//5
  setDb() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "itemsDB");
    var DB = await openDatabase(path, version: 1, onCreate: _oncreate);
    return DB;
  }

  //6
  void _oncreate(Database db, int version) async {
    var dbsql =
        "CREATE TABLE favorite(id INTEGER PRIMARY KEY, id TEXT, title TEXT,"
        "price TEXT, description TEXT, category TEXT, image TEXT)";
    await db.execute(dbsql);
    print('DB Created');
  }

//8
  Future<int?> insert(Items items) async {
    var dbClient = await db;
    int res = await dbClient!.insert("favorite", items.toJson()).then((i) {
      return 1;
    });
    if (res == 1) {
      print("data favorite bertambah");
    }
    return res;
  }

  Future<Items?> get(String idMeal) async {
    var dbClient = await db;
    var sql = "SELECT * FROM FAVORITE WHERE id=? ORDER BY id DESC";
    List<Map> list = await dbClient!.rawQuery(sql, [idMeal]);
    late Items items;
    if (list.isNotEmpty) {
      items = Items(
        id: list[0]['id'],
        title: list[0]['title'],
        price: list[0]['price'],
        description: list[0]['description'],
        category: list[0]['category'],
        image: list[0]['image'],
      );
    }
    return items;
  }

  Future<List<Items>> gets (String category) async {
    var dbClient = await db;
    var sql = "SELECT * FROM favorite WHERE  category=? ORDER BY id DESC";
    List<Map> list = await dbClient!.rawQuery(sql,[category]);
    List<Items> favorites = [];
    for (int i = 0; i < list.length; i++){
      Items favorite = Items(
        id: list[i]['id'],
        title: list[i]['title'],
        price: list[i]['price'],
        description: list[i]['description'],
        category: list[i]['category'],
        image: list[i]['image'],
      );
      favorite.setFavoritesId(list[i]['id']);
      favorites.add((favorite));
    }
    return favorites;
  }

  Future<int?> delete(Items items) async {
    var dbClient = await db;
    var sql = "DELETE FROM favorite WHERE id = ?";
    var res = await dbClient!.rawDelete(sql, [items.id]);
    print("Favorite data deleted");
    return res;
  }

  Future<bool> isFavorite(String? idMeals) async {
    var dbClient = await db;
    var sql = "SELECT * FROM favorite WHERE idMeal = ?";
    var res = await dbClient!.rawQuery(sql,[idMeals]);

    return res.isNotEmpty;
  }
}
