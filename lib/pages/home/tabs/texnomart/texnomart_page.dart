import 'package:bottom_menu/core/api/pagination_api.dart';
import 'package:easy_debounce/easy_debounce.dart';
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

  Widget appBarTitle = new Text(
    "Texnomart",
    style: new TextStyle(color: Colors.black),
  );
  Icon actionIcon = new Icon(
    Icons.search,
    color: Colors.black,
  );
  final key = new GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = new TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    bloc.add(TexnomartInitEvent());

    _searchQuery.addListener(() {
      EasyDebounce.debounce("debouncer", Duration(seconds: 2), () {
        bloc.add(TexnomartSearchEvent(_searchQuery.text));
      });
    });

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
    _searchQuery.dispose();
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
              appBar: buildBar(context),
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

  AppBar buildBar(BuildContext context) {
    return new AppBar(title: appBarTitle, backgroundColor: Colors.yellow, actions: <Widget>[
      new IconButton(
        icon: actionIcon,
        onPressed: () {
          setState(() {
            if (this.actionIcon.icon == Icons.search) {
              this.actionIcon = new Icon(
                Icons.close,
                color: Colors.black,
              );
              this.appBarTitle = new TextField(
                controller: _searchQuery,
                style: new TextStyle(color: Colors.black, fontSize: 18),
                decoration: new InputDecoration(
                    prefixIcon: new Icon(Icons.search, color: Colors.black),
                    hintText: "Search...",
                    border: InputBorder.none,
                    hintStyle: new TextStyle(color: Colors.black)),
              );
              _handleSearchStart();
            } else {
              _handleSearchEnd();
            }
          });
        },
      ),
    ]);
  }

  void _handleSearchStart() {
    setState(() {
      _isSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.actionIcon = new Icon(
        Icons.search,
        color: Colors.white,
      );
      this.appBarTitle = new Text(
        "Korzinka",
        style: new TextStyle(color: Colors.white),
      );
      _isSearching = false;
      _searchQuery.clear();
    });
  }
}
