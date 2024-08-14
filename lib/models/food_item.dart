enum FoodItemType {
  burger,
  pizza,
  drink,
  // Add more types as needed
}

class FoodItem {
  String? fid;
  String? name;
  String? description;
  String? imageURL;
  double? price;
  double? rating;
  List<String>? categories;
  bool? isAvailable;
  bool? isVegetarian;
  int? preparationTime;
  List<String>? ingredients;
  int? quantity;
  DateTime? addedDate;
  String? restaurantId;
  String? restaurantName;
  String? restaurantLocation;
  FoodItemType? foodType;
  String? status;
  int? orderCount;

  FoodItem({
    this.fid,
    this.name,
    this.description,
    this.imageURL,
    this.price,
    this.rating,
    this.categories,
    this.isAvailable,
    this.isVegetarian,
    this.preparationTime,
    this.ingredients,
    this.quantity,
    this.addedDate,
    this.restaurantId,
    this.restaurantName,
    this.restaurantLocation,
    this.foodType,
    this.status,
    this.orderCount,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      fid: json['fid'],
      name: json['name'],
      description: json['description'],
      imageURL: json['imageURL'],
      price: json['price']?.toDouble(),
      rating: json['rating']?.toDouble(),
      categories: (json['categories'] as List<dynamic>?)
              ?.map((category) => category as String)
              .toList() ??
          [],
      isAvailable: json['isAvailable'],
      isVegetarian: json['isVegetarian'],
      preparationTime: json['preparationTime'],
      ingredients: (json['ingredients'] as List<dynamic>?)
              ?.map((ingredient) => ingredient as String)
              .toList() ??
          [],
      quantity: json['quantity'],
      addedDate: json['addedDate'] != null
          ? DateTime.parse(json['addedDate'])
          : null,
      restaurantId: json['restaurantId'],
      restaurantName: json['restaurantName'],
      restaurantLocation: json['restaurantLocation'],
      foodType: FoodItemType.values.firstWhere(
        (type) => type.toString() == 'FoodItemType.${json['foodType']}',
      ),
      status: json['status'],
      orderCount: json['orderCount'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fid'] = fid;
    data['name'] = name;
    data['description'] = description;
    data['imageURL'] = imageURL;
    data['price'] = price;
    data['rating'] = rating;
    data['categories'] = categories;
    data['isAvailable'] = isAvailable;
    data['isVegetarian'] = isVegetarian;
    data['preparationTime'] = preparationTime;
    data['ingredients'] = ingredients;
    data['quantity'] = quantity;
    if (addedDate != null) {
      data['addedDate'] = addedDate!.toIso8601String();
    }
    data['restaurantId'] = restaurantId;
    data['restaurantName'] = restaurantName;
    data['restaurantLocation'] = restaurantLocation;
    data['foodType'] = foodType?.toString().split('.').last;
    data['status'] = status;
    data['orderCount'] = orderCount;
    return data;
  }
}
