import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_rimo2/pages/pages.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.pageName}) : super(key: key);

  static List<String> pageList = [
    'characters',
    'locations',
    'episodes',
    'chat',
  ];

  final String pageName;

  int get _pageIndex {
    return max(pageList.indexOf(pageName), 0);
  }

  @override
  Widget build(BuildContext context) {
    void _onPressed(String name) {
      context.goNamed('home', params: {'page': name});
    }

    return Scaffold(
      body: IndexedStack(
        index: _pageIndex,
        children: const [
          CharactersPage(),
          LocationsPage(),
          EpisodesPage(),
          ChatPage(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _NavBarButton(
              name: HomePage.pageList[0],
              activeName: pageName,
              onPressed: _onPressed,
              icon: Icons.person,
            ),
            _NavBarButton(
              name: HomePage.pageList[1],
              activeName: pageName,
              onPressed: _onPressed,
              icon: Icons.location_pin,
            ),
            _NavBarButton(
              name: HomePage.pageList[2],
              activeName: pageName,
              onPressed: _onPressed,
              icon: Icons.list_alt,
            ),
            _NavBarButton(
              name: HomePage.pageList[3],
              activeName: pageName,
              onPressed: _onPressed,
              icon: Icons.chat,
            ),
          ],
        ),
      ),
    );
  }
}

class _NavBarButton extends StatelessWidget {
  const _NavBarButton({
    Key? key,
    required this.name,
    required this.activeName,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);

  final String name;
  final String activeName;
  final Function(String) onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => onPressed(name),
      iconSize: 32,
      color:
          name == activeName ? Theme.of(context).colorScheme.secondary : null,
      icon: Icon(
        icon,
      ),
    );
  }
}
