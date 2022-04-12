import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_rimo2/pages/pages.dart';
import 'package:go_router/go_router.dart';

enum HomePageName {
  characters,
  locations,
  episodes,
  chat,
}

enum InfoPageName {
  character,
  location,
  episode,
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.pageName}) : super(key: key);

  static List<String> pageList =
      HomePageName.values.map((e) => e.name).toList();

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

class _NavBarButton extends StatefulWidget {
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

  bool get isActive => name == activeName;

  @override
  State<_NavBarButton> createState() => _NavBarButtonState();
}

class _NavBarButtonState extends State<_NavBarButton>
    with TickerProviderStateMixin {
  late final _controller = AnimationController(
    duration: const Duration(milliseconds: 500),
    value: widget.isActive ? 1 : 0,
    vsync: this,
  );
  late final _scaleAnimation = Tween<double>(
    begin: 1,
    end: 1.2,
  ).animate(
    CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0,
        0.8,
        curve: Curves.ease,
      ),
    ),
  );

  late final _colorAnimation = ColorTween(
    begin: Theme.of(context).colorScheme.onPrimary,
    end: Theme.of(context).colorScheme.secondary,
  ).animate(
    CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.8,
        1,
        curve: Curves.ease,
      ),
    ),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant _NavBarButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isActive && !oldWidget.isActive) {
      _controller.forward();
    } else if (!widget.isActive && oldWidget.isActive) {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) => Transform.scale(
        scale: _scaleAnimation.value,
        child: IconButton(
          onPressed: () => widget.onPressed(widget.name),
          iconSize: 32,
          color: _colorAnimation.value,
          icon: Icon(
            widget.icon,
          ),
        ),
      ),
    );
  }
}
