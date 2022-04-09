// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:df_repository/df_repository.dart';
import 'package:entities_repository/entities_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_rimo2/app/cubit/nav_cubit.dart';
import 'package:flutter_rimo2/l10n/l10n.dart';
import 'package:flutter_rimo2/pages/pages.dart';
import 'package:go_router/go_router.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    this.entitiesRepository,
    this.dfRepository,
  }) : super(key: key);

  final EntitiesRepository? entitiesRepository;
  final DfRepository? dfRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: entitiesRepository),
        RepositoryProvider.value(value: dfRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => NavCubit('/${HomePage.pageList[0]}'),
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
          path: '/:page',
          name: 'home',
          pageBuilder: (context, state) => NoTransitionPage<void>(
            key: state.pageKey,
            child: HomePage(pageName: state.params['page'] ?? ''),
          ),
        ),
      ],
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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.green,
          brightness: Brightness.dark,
        ),
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
