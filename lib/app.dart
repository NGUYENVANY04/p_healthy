import 'package:flutter/material.dart';
import 'package:p_healthy/ui/pages/home/home_vm.dart';
import 'package:p_healthy/ui/pages/main/main_page.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeVM>(
      create: (BuildContext context) {
        return HomeVM();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MainPage(),
      ),
    );
  }
}
