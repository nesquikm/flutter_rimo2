// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:df_repository/df_repository.dart';
import 'package:entities_repository/entities_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_rimo2/app/cubit/nav_cubit.dart';
import 'package:flutter_rimo2/l10n/l10n.dart';
import 'package:flutter_rimo2/pages/pages.dart';
import 'package:go_router/go_router.dart';

const charactersPath = '/characters';
const charactersName = 'characters';
const locationsPath = '/locations';
const locationsName = 'locations';
const episodesPath = '/episodes';
const episodesName = 'episodes';
const chatPath = '/chat';
const chatName = 'chat';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serviceAccountJson =
        rootBundle.loadString('assets/rimorse2-xphn-b74dc6b8345f.json');
    final entitiesRepository = EntitiesRepository();
    final dfRepository = DfRepository(
      serviceAccountJson: serviceAccountJson,
      project: 'rimorse2-xphn',
    );

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: entitiesRepository),
        RepositoryProvider.value(value: dfRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => NavCubit(charactersPath),
          ),
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: charactersPath,
          name: charactersName,
          builder: (_, __) => const CharactersPage(),
        ),
        // GoRoute(
        //   path: locationsPath,
        //   name: locationsName,
        //   builder: (_, __) => const LocationsPage(),
        // ),
        // GoRoute(
        //   path: episodesPath,
        //   name: episodesName,
        //   builder: (_, __) => const EpisodesPage(),
        // ),
        // GoRoute(
        //   path: episodesPath,
        //   name: episodesName,
        //   pageBuilder: (context, state) => CustomTransitionPage<void>(
        //     key: state.pageKey,
        //     child: const EpisodesPage(),
        //     transitionsBuilder:
        //         (context, animation, secondaryAnimation, child) =>
        //             ScaleTransition(scale: animation, child: child),
        //   ),
        // ),
        // GoRoute(
        //   path: episodesPath,
        //   name: episodesName,
        //   pageBuilder: (context, state) => NoTransitionPage<void>(
        //     key: state.pageKey,
        //     child: const EpisodesPage(),
        //   ),
        // ),
        GoRoute(
          path: chatPath,
          name: chatName,
          builder: (_, __) => const ChatPage(),
        ),
      ],
      navigatorBuilder: (context, state, child) => Navigator(
        onPopPage: (route, dynamic result) {
          route.didPop(result);
          return false; // don't pop the single page on the root navigator
        },
        pages: [
          MaterialPage<void>(
            child: SharedScaffold(
              activeName: Uri.parse(state.location).pathSegments.first,
              body: child,
            ),
          ),
        ],
      ),
      redirect: (state) {
        context.read<NavCubit>().setLocation(state.location);

        return null;
      },
      initialLocation: context.read<NavCubit>().state.location,
      debugLogDiagnostics: true,
    );
    return MaterialApp.router(
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}

class SharedScaffold extends StatelessWidget {
  const SharedScaffold({
    Key? key,
    required this.activeName,
    required this.body,
  }) : super(key: key);

  final String activeName;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    void _onPressed(String location) {
      context.goNamed(location);
    }

    return Scaffold(
      body: body,
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _NavBarButton(
              name: charactersName,
              activeName: activeName,
              onPressed: _onPressed,
              icon: Icons.person,
            ),
            _NavBarButton(
              name: locationsName,
              activeName: activeName,
              onPressed: _onPressed,
              icon: Icons.location_pin,
            ),
            _NavBarButton(
              name: episodesName,
              activeName: activeName,
              onPressed: _onPressed,
              icon: Icons.list_alt,
            ),
            _NavBarButton(
              name: chatName,
              activeName: activeName,
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
