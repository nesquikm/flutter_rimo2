import 'dart:async';
import 'dart:developer';

import 'package:df_repository/df_repository.dart';
import 'package:entities_repository/entities_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/widgets.dart';
import 'package:flutter_services_binding/flutter_services_binding.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(
  FutureOr<Widget> Function({
    EntitiesRepository entitiesRepository,
    DfRepository dfRepository,
  })
      builder,
) async {
  // WidgetsFlutterBinding.ensureInitialized();
  FlutterServicesBinding.ensureInitialized();

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  final serviceAccountJson =
      await rootBundle.loadString('assets/rimorse2-key.json');
  final entitiesRepository = EntitiesRepository();
  final dfRepository = DfRepository(
    serviceAccountJson: serviceAccountJson,
    project: 'rimorse2-xphn',
  );

  final storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );

  await HydratedBlocOverrides.runZoned(
    () async => runApp(
      await builder(
        entitiesRepository: entitiesRepository,
        dfRepository: dfRepository,
      ),
    ),
    storage: storage,
    blocObserver: AppBlocObserver(),
  );

  // await runZonedGuarded(
  //   () async {
  //     await BlocOverrides.runZoned(
  //       () async => runApp(await builder()),
  //       blocObserver: AppBlocObserver(),
  //     );
  //   },
  //   (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  // );
}
