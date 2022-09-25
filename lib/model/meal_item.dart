

class Items {
  Items({
  this.id,
  this.title,
  this.price,
  this.description,
  this.category,
  this.image,
});
  String? id;
  String? title;
  String? price;
  String? description;
  String? category;
  String? image;

  factory Items.fromJson(Map<String,dynamic> json) => Items(
    id: json["id"],
    title: json["title"],
    price: json["price"],
    description: json["description"],
    category: json["category"],
    image: json["image"],
  );

  Map<String,dynamic> toJson()=> {
    "id" : id,
    "title" : title,
    "price" : price,
    "description" : description,
    "category" : category,
    "image" : image,
  };
  void setFavoritesId(String id){
    id = id;
  }
}