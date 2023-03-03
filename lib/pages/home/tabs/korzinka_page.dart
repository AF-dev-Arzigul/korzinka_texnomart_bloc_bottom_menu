import 'package:bottom_menu/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KorzinkaPage extends StatefulWidget {
  const KorzinkaPage({Key? key}) : super(key: key);

  @override
  State<KorzinkaPage> createState() => _KorzinkaPageState();
}

class _KorzinkaPageState extends State<KorzinkaPage> {
  @override
  void initState() {
    print("initState: Korzinka");
    context.read<HomeProvider>().addListener(() {
      print("Korzinka: ${context.read<HomeProvider>().index}");
    });
    super.initState();
  }

  @override
  void dispose() {
    print("dispose: Korzinka");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text("KorzinkaPage"),
      ),
    );
  }
}
