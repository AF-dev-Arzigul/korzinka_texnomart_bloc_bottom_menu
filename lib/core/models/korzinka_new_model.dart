class KorzinkaNewModel {
  KorzinkaNewModel({
    required this.data,
    this.message,
    this.serverMessage,
    required this.status,
    required this.httpStatusCode,
  });

  Data data;
  dynamic message;
  dynamic serverMessage;
  String status;
  int httpStatusCode;

  factory KorzinkaNewModel.fromJson(Map<String, dynamic> json) => KorzinkaNewModel(
        data: Data.fromJson(json["data"]),
        message: json["message"] ?? "",
        serverMessage: json["serverMessage"] ?? "",
        status: json["status"] ?? "",
        httpStatusCode: json["httpStatusCode"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
        "serverMessage": serverMessage,
        "status": status,
        "httpStatusCode": httpStatusCode,
      };
}

class Data {
  Data({
    required this.list,
    required this.count,
    required this.priceRange,
  });

  List<ListElement> list;
  int count;
  PriceRange priceRange;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        list: List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
        count: json["count"],
        priceRange: PriceRange.fromJson(json["priceRange"]),
      );

  Map<String, dynamic> toJson() => {
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
        "count": count,
        "priceRange": priceRange.toJson(),
      };
}

class ListElement {
  ListElement({
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

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        keywords: json["keywords"] ?? "",
        description: json["description"] ?? "",
        skuNumber: json["skuNumber"] ?? "",
        price: json["price"] ?? 0,
        storeQuantity: json["storeQuantity"] ?? "",
        quantity: json["quantity"] ?? "",
        company: Category.fromJson(json["company"]),
        category: Category.fromJson(json["category"]),
        manufacturer: Category.fromJson(json["manufacturer"]),
        measurement: Category.fromJson(json["measurement"]),
        ingredients: json["ingredients"] ?? "",
        storageMethods: json["storageMethods"] ?? "",
        metaTitle: json["metaTitle"] ?? "",
        headline: json["headline"] ?? "",
        metaDescription: json["metaDescription"] ?? "",
        metaKeyword: json["metaKeyword"] ?? "",
        createdDate: json["createdDate"] ?? "",
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        parentId: json["parentId"] ?? 0,
        missing: json["missing"] ?? false,
        oldPrice: json["oldPrice"] ?? 0,
        addedWishlist: json["addedWishlist"] ?? false,
        categoryList: List<dynamic>.from(json["categoryList"].map((x) => x)),
        ingredientProducts: List<dynamic>.from(json["ingredientProducts"].map((x) => x)),
        attributes: List<dynamic>.from(json["attributes"].map((x) => x)),
        companyGroup: Category.fromJson(json["companyGroup"]),
        sale: json["sale"] ?? false,
        campaign: json["campaign"] ?? false,
        popular: json["popular"] ?? false,
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
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
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

enum Code { KG, PCS }

final codeValues = EnumValues({"kg": Code.KG, "pcs": Code.PCS});

enum Description { EMPTY, DESCRIPTION }

final descriptionValues = EnumValues({"шт": Description.DESCRIPTION, "кг": Description.EMPTY});

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
        id: json["id"] ?? 0,
        productId: json["productId"] ?? 0,
        main: json["main"] ?? false,
        largeUrl: json["largeUrl"] ?? "",
        mediumUrl: json["mediumUrl"] ?? "",
        smallUrl: json["smallUrl"] ?? "",
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

class PriceRange {
  PriceRange({
    required this.min,
    required this.max,
  });

  int min;
  int max;

  factory PriceRange.fromJson(Map<String, dynamic> json) => PriceRange(
        min: json["min"]?? 0,
        max: json["max"]?? 0,
      );

  Map<String, dynamic> toJson() => {
        "min": min,
        "max": max,
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
