class KorzinkaModel {
  KorzinkaModel({required this.list, required this.count});

  final List<KorzinkaItem> list;
  final int count;

  factory KorzinkaModel.fromJson(Map<String, dynamic> json) => KorzinkaModel(
        list: List<KorzinkaItem>.from((json["list"]).map((x) => KorzinkaItem.fromJson(x))),
        count: json["count"] ?? 0,
      );

  Map<String, dynamic> toJson() => {"list": List<dynamic>.from(list.map((x) => x.toJson())), "count": count};
}

class KorzinkaItem {
  KorzinkaItem({
    required this.id,
    required this.name,
    this.keywords,
    required this.description,
    this.skuNumber,
    required this.price,
    this.storeQuantity,
    this.quantity,
    required this.company,
    required this.category,
    required this.manufacturer,
    required this.measurement,
    this.ingredients,
    this.storageMethods,
    this.metaTitle,
    this.headline,
    this.metaDescription,
    this.metaKeyword,
    required this.createdDate,
    required this.images,
    required this.parentId,
    required this.missing,
    required this.oldPrice,
    required this.addedWishlist,
    required this.categoryList,
    required this.ingredientProducts,
    required this.attributes,
    required this.companyGroup,
    required this.sale,
    required this.campaign,
    required this.popular,
  });

  int id;
  String name;
  dynamic keywords;
  String description;
  dynamic skuNumber;
  int price;
  dynamic storeQuantity;
  dynamic quantity;
  Category company;
  Category category;
  Category manufacturer;
  Category measurement;
  dynamic ingredients;
  dynamic storageMethods;
  dynamic metaTitle;
  dynamic headline;
  dynamic metaDescription;
  dynamic metaKeyword;
  int createdDate;
  List<Image> images;
  int parentId;
  bool missing;
  int oldPrice;
  bool addedWishlist;
  List<dynamic> categoryList;
  List<dynamic> ingredientProducts;
  List<dynamic> attributes;
  Category companyGroup;
  bool sale;
  bool campaign;
  bool popular;

  factory KorzinkaItem.fromJson(Map<String, dynamic> json) => KorzinkaItem(
        id: json["id"],
        name: json["name"],
        keywords: json["keywords"],
        description: json["description"],
        skuNumber: json["skuNumber"],
        price: json["price"],
        storeQuantity: json["storeQuantity"],
        quantity: json["quantity"],
        company: Category.fromJson(json["company"]),
        category: Category.fromJson(json["category"]),
        manufacturer: Category.fromJson(json["manufacturer"]),
        measurement: Category.fromJson(json["measurement"]),
        ingredients: json["ingredients"],
        storageMethods: json["storageMethods"],
        metaTitle: json["metaTitle"],
        headline: json["headline"],
        metaDescription: json["metaDescription"],
        metaKeyword: json["metaKeyword"],
        createdDate: json["createdDate"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        parentId: json["parentId"],
        missing: json["missing"],
        oldPrice: json["oldPrice"],
        addedWishlist: json["addedWishlist"],
        categoryList: List<dynamic>.from(json["categoryList"].map((x) => x)),
        ingredientProducts: List<dynamic>.from(json["ingredientProducts"].map((x) => x)),
        attributes: List<dynamic>.from(json["attributes"].map((x) => x)),
        companyGroup: Category.fromJson(json["companyGroup"]),
        sale: json["sale"],
        campaign: json["campaign"],
        popular: json["popular"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "keywords": keywords,
        "description": description,
        "skuNumber": skuNumber,
        "price": price,
        "storeQuantity": storeQuantity,
        "quantity": quantity,
        "company": company.toJson(),
        "category": category.toJson(),
        "manufacturer": manufacturer.toJson(),
        "measurement": measurement.toJson(),
        "ingredients": ingredients,
        "storageMethods": storageMethods,
        "metaTitle": metaTitle,
        "headline": headline,
        "metaDescription": metaDescription,
        "metaKeyword": metaKeyword,
        "createdDate": createdDate,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "parentId": parentId,
        "missing": missing,
        "oldPrice": oldPrice,
        "addedWishlist": addedWishlist,
        "categoryList": List<dynamic>.from(categoryList.map((x) => x)),
        "ingredientProducts": List<dynamic>.from(ingredientProducts.map((x) => x)),
        "attributes": List<dynamic>.from(attributes.map((x) => x)),
        "companyGroup": companyGroup.toJson(),
        "sale": sale,
        "campaign": campaign,
        "popular": popular,
      };
}

class Category {
  Category({
    required this.id,
    this.name,
    this.description,
    this.code,
  });

  int id;
  String? name;
  Description? description;
  Code? code;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        description: descriptionValues.map[json["description"]]!,
        code: codeValues.map[json["code"]]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": descriptionValues.reverse[description],
        "code": codeValues.reverse[code],
      };
}

enum Code { PCS }

final codeValues = EnumValues({"pcs": Code.PCS});

enum Description { EMPTY }

final descriptionValues = EnumValues({"шт": Description.EMPTY});

class Image {
  Image({
    required this.id,
    required this.productId,
    required this.main,
    required this.largeUrl,
    required this.mediumUrl,
    required this.smallUrl,
  });

  int id;
  int productId;
  bool main;
  String largeUrl;
  String mediumUrl;
  String smallUrl;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        productId: json["productId"],
        main: json["main"],
        largeUrl: json["largeUrl"],
        mediumUrl: json["mediumUrl"],
        smallUrl: json["smallUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "productId": productId,
        "main": main,
        "largeUrl": largeUrl,
        "mediumUrl": mediumUrl,
        "smallUrl": smallUrl,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
