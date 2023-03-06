import 'package:bottom_menu/pages/home/home_page.dart';
import 'package:bottom_menu/pages/home/tabs/korzinka/bloc/korzinka_bloc/korzinka_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../core/api/pagination_api.dart';
import '../texnomart/bloc/texnomart_bloc.dart';

class KorzinkaPage extends StatefulWidget {
  const KorzinkaPage({Key? key}) : super(key: key);

  @override
  State<KorzinkaPage> createState() => _KorzinkaPageState();
}

class _KorzinkaPageState extends State<KorzinkaPage> {
  final bloc = KorzinkaBloc(PaginationApi());
  final controller = RefreshController();

  @override
  void initState() {
    bloc.add(KorzinkaInitEvent());
    // print("initState: Korzinka");
    // context.read<HomeProvider>().addListener(() {
    //   print("Korzinka: ${context.read<HomeProvider>().index}");
    // });
    super.initState();
  }

  @override
  void dispose() {
    print("dispose: Korzinka");
    bloc.close();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: BlocListener<KorzinkaBloc, KorzinkaState>(
        listener: (context, state) {
          if (state.status == Status.success) {
            controller.refreshCompleted();
            controller.loadComplete();
          }
        },
        child: BlocBuilder<KorzinkaBloc, KorzinkaState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.red,
                title: const Text("Korzinka", style: TextStyle(color: Colors.white)),
              ),
              body: Builder(builder: (context) {
                if (state.status == Status.loading && state.list.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                return SmartRefresher(
                  controller: controller,
                  enablePullDown: true,
                  enablePullUp: true,
                  onRefresh: () {
                    bloc.add(KorzinkaInitEvent());
                  },
                  onLoading: () {
                    bloc.add(KorzinkaNextEvent());
                  },
                  child: ListView.builder(
                    itemCount: state.list.length,
                    itemBuilder: (BuildContext context, int index) {
                      print("list page: ${state.list.length}");
                      var model = state.list[index];
                      return Card(
                        elevation: 2,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Image.network(
                                    "https://api.lebazar.uz/${model.images![0].mediumUrl}",
                                    height: 100,
                                    width: 100,
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${index + 1}. ${model.name!}",
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                      softWrap: true,
                                      maxLines: 2,
                                    ),
                                    Text(
                                      "${model.price} sum",
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                                      softWrap: true,
                                      maxLines: 2,
                                    ),
                                    Text(
                                      "1 ${model.measurement!.code}",
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                                      softWrap: true,
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
            );
          },
        ),
      ),
    );
  }
}
