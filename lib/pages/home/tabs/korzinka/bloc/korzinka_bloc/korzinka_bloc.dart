import 'package:bottom_menu/core/models/list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/api/pagination_api.dart';
import '../../../texnomart/bloc/texnomart_bloc.dart';

part 'korzinka_event.dart';

part 'korzinka_state.dart';

class KorzinkaBloc extends Bloc<KorzinkaEvent, KorzinkaState> {
  final PaginationApi _api;

  KorzinkaBloc(this._api) : super(KorzinkaState()) {
    on<KorzinkaInitEvent>((event, emit) async {
      emit(state.copyWith(status: Status.loading, list: [], start: state.start, limit: state.limit, count: state.count));
      try {
        final model = await _api.searchProducts(search: state.search);
        print("bloc: ${model.length}");
        final count = await _api.productCount();
        print("bloc count: $count");
        emit(state.copyWith(status: Status.success, list: model, start: state.start, limit: 15, count: count));
      } catch (e) {}
    });
    on<KorzinkaNextEvent>((event, emit) async {
      if (state.limit >= state.count) return;
      emit(state.copyWith(status: Status.loading));
      try {
        final model = await _api.searchProducts(search: state.search, start: state.limit, limit: state.limit + 15);
        emit(state.copyWith(
            status: Status.success, list: [...state.list, ...model], start: state.limit, limit: state.limit + 15, count: state.count));
      } catch (e) {}
    });
    on<KorzinkaSearchEvent>((event, emit) async {
      emit(state.copyWith(status: Status.loading, search: event.text, start: state.limit, limit: state.limit + 15, list: [], count: state.count));
      try {
        final model = await _api.searchProducts(search: state.search);
        emit(state.copyWith(status: Status.success, list: model, start: state.limit, limit: state.limit + 15, count: state.count));
      } catch (e) {}
    });
  }
}
