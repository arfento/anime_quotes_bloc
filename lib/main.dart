import 'dart:async';

import 'package:anime_quotes_bloc/bloc/bottom_navigation/bottom_navigation_bloc.dart';
import 'package:anime_quotes_bloc/utils/simple_bloc_observer.dart';
import 'package:anime_quotes_bloc/views/navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

StreamController<bool> streamController = StreamController();
Stream<bool> stream = streamController.stream;
void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(brightness: Brightness.dark),
      debugShowCheckedModeBanner: false,
      home: BlocProvider<BottomNavigationBloc>(
        create: (context) => BottomNavigationBloc(),
        child: NavigationScreen(),
      ),
    );
  }
}
