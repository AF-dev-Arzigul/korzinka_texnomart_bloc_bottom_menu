import 'package:bottom_menu/core/api/pagination_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'bloc/texnomart_bloc.dart';

class TexnomartPage extends StatefulWidget {
  const TexnomartPage({Key? key}) : super(key: key);

  @override
  State<TexnomartPage> createState() => _TexnomartPageState();
}

class _TexnomartPageState extends State<TexnomartPage> {
  final bloc = TexnomartBloc(PaginationApi());
  final controller = RefreshController();

  @override
  void initState() {
    bloc.add(TexnomartInitEvent());
    // print("initState: Texnomart");
    // context.read<HomeProvider>().addListener(() {
    //   // if(context.read<HomeProvider>().index==0){
    //   //
    //   // }
    //   print("Texnomart: ${context.read<HomeProvider>().index}");
    // });
    super.initState();
  }

  @override
  void dispose() {
    print("dispose: Texnomart");
    bloc.close();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: BlocListener<TexnomartBloc, TexnomartState>(
        listener: (context, state) {
          if (state.status == Status.success) {
            controller.refreshCompleted();
            controller.loadComplete();
          }
        },
        child: BlocBuilder<TexnomartBloc, TexnomartState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.yellow,
                title: const Text("Texnomart", style: TextStyle(color: Colors.black)),
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
                    bloc.add(TexnomartInitEvent());
                  },
                  onLoading: () {
                    bloc.add(TexnomartNextEvent());
                  },
                  child: ListView.builder(
                    itemCount: state.list.length,
                    itemBuilder: (BuildContext context, int index) {
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
                                    "https://backend.texnomart.uz/${model.image}",
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
                                      model.name,
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                      softWrap: true,
                                      maxLines: 2,
                                    ),
                                    Text(
                                      "Sale price: ${model.fSalePrice}",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      "Loan price: ${model.fLoanPrice}",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      "Monthly price: ${model.axiomMonthlyPrice}",
                                      style: TextStyle(fontSize: 14),
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
