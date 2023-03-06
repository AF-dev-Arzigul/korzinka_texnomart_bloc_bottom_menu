part of 'korzinka_bloc.dart';

@immutable
class KorzinkaState {
  final Status status;
  final String message;
  final String search;
  final List<EbazarItem> list;
  final int start;
  final int limit;
  final int count;

  KorzinkaState({
    this.status = Status.initial,
    this.message = "",
    this.search = "",
    this.list = const [],
    this.start = 0,
    this.limit = 0,
    this.count = 0
  });

  KorzinkaState copyWith({
    Status? status,
    String? message,
    String? search,
    List<EbazarItem>? list,
    int? start,
    int? limit,
    int? count,
  }) {
    return KorzinkaState(
      status: status ?? this.status,
      message: message ?? this.message,
      search: search ?? this.search,
      list: list ?? this.list,
      start: start ?? this.start,
      limit: limit ?? this.limit,
      count: count ?? this.count,
    );
  }
}

