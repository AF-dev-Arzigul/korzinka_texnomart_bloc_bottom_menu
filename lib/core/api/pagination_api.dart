import 'package:bottom_menu/core/models/korzinka_model.dart';
import 'package:bottom_menu/core/models/texnomart_model.dart';
import 'package:dio/dio.dart';
import '../models/korzinka_new_model.dart';
import '../models/list.dart';

class PaginationApi {
  final _dio = Dio(BaseOptions(connectTimeout: const Duration(seconds: 60)));

  Future<KorzinkaModel> productsByKorzinka({String search = "", int start = 0, int limit = 15}) async {
    final response = await _dio.get("https://api.lebazar.uz/api/v1/search/product?start=$start&limit=$limit&searchKey=$search",
        options: Options(headers: {"companyId": 78}));
    var korzinka = KorzinkaNewModel.fromJson(response.data["data"]);
    // var item = KorzinkaItem.fromJson(response.data["data"]["list"]);
    print("api: ${response.data}");
    print("api: ${response.data["data"]}");
    return response.data;
  }

  Future<int> productCount({
    int start = 0,
    int limit = 15,
    String search = ""
  }) async {
    final response = await _dio.get(
        "https://api.lebazar.uz/api/v1/search/product?start=$start&limit=$limit&searchKey=$search",
        options: Options(headers: {"companyId": 78}));
    var data = response.data["data"]["count"] as int;
    print("api count: $data");
    return data;
  }

  Future<List<EbazarItem>> searchProducts({
    int start = 0,
    int limit = 15,
    String search = "",
  }) async {
    print('start');
    final response = await _dio.get(
      "https://api.lebazar.uz/api/v1/search/product?start=$start&limit=$limit&searchKey=$search",
      options: Options(headers: {"companyId": 78}),
    );
    print(response.data.toString());
    return List<EbazarItem>.from(response.data["data"]['list'].map((x) => EbazarItem.fromJson(x)));
  }

  Future<TexnomartModel> productsByTexnomart({
    String search = "",
    int page = 1,
  }) async {
    final response = await _dio.get("https://backend.texnomart.uz/api/v2/search/search?q=$search&page=$page");
    // print("api: ${response.data}");
    return TexnomartModel.fromJson(response.data["data"]);
  }
}
