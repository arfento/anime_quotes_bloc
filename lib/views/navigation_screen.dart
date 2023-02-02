import 'package:anime_quotes_bloc/bloc/bottom_navigation/bottom_navigation_bloc.dart';
import 'package:anime_quotes_bloc/bloc/quote/quote_bloc.dart';
import 'package:anime_quotes_bloc/views/favorite_view.dart';
import 'package:anime_quotes_bloc/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final views = <Widget>[
  BlocProvider(
    create: (context) => QuoteBloc(),
    child: HomeView(),
  ),
  FavoriteView(),
];

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
        builder: (context, state) {
      if (state is HomeState) {
        return ViewNavigation(
          currentIndex: state.index,
        );
      }
      if (state is FavoriteState) {
        return ViewNavigation(
          currentIndex: state.index,
        );
      }
      return Container();
    });
  }
}

class ViewNavigation extends StatelessWidget {
  final int currentIndex;
  const ViewNavigation({Key? key, required this.currentIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'images/galaxy.jpg',
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
          //* A Stack that shows a single child from a list of children.
          //* The displayed child is the one with the given index. The stack is always as big as the largest child.
          IndexedStack(index: currentIndex, children: views),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Colors.blue.shade300,
        unselectedItemColor: Colors.grey[500],
        type: BottomNavigationBarType.fixed,
        elevation: 10,
        onTap: (value) {
          if (value == 0) {
            return BlocProvider.of<BottomNavigationBloc>(context)
                .add(LoadHome());
          }
          if (value == 1) {
            return BlocProvider.of<BottomNavigationBloc>(context)
                .add(LoadFavorite());
          }
        },
        items: [
          _buildTabBarItem(icon: Icon(Icons.home), label: 'Home'),
          _buildTabBarItem(icon: Icon(Icons.favorite), label: 'Favorite'),
        ],
      ),
    );
  }

  _buildTabBarItem({required final Widget icon, required final String label}) {
    return BottomNavigationBarItem(
      icon: icon,
      label: label,

      // Text(
      //   label,
      //   style: TextStyle(fontSize: 14.0),
      //   textAlign: TextAlign.center,
      // ),
    );
  }
}
