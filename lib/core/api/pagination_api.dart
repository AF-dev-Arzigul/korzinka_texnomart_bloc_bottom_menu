import 'package:bottom_menu/core/models/texnomart_model.dart';
import 'package:dio/dio.dart';

class PaginationApi {
  final _dio = Dio(BaseOptions(connectTimeout: const Duration(seconds: 60)));

  Future<Response> productsByKorzinka() async {
    final response = await _dio.get(
      "https://api.lebazar.uz/api/v1/search/product?start=0&limit=10&searchKey=cola",
      options: Options(),
    );
    return response;
  }

  Future<TexnomartModel> productsByTexnomart({
    String search = "",
    int page = 1,
  }) async {
    final response = await _dio.get(
      "https://backend.texnomart.uz/api/v2/search/search?q=$search&page=$page",
    );
    print(response.data);
    return TexnomartModel.fromJson(response.data["data"]);
  }
}
