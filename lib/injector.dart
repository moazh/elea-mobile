import 'package:elea_mobile/common/recording_handler.dart';
import 'package:elea_mobile/data/source/local/storage.dart';
import 'package:elea_mobile/data/source/remote/api.dart';
import 'package:elea_mobile/domain/mapper/transcript_mapper.dart';
import 'package:elea_mobile/domain/repository/transcript_repository.dart';
import 'package:elea_mobile/domain/usecase/generate_transcript.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  // ---------------------------------------------------------------------------
  // Remote
  // ---------------------------------------------------------------------------
  injector.registerLazySingleton<Api>(() => ApiImpl());

  // ---------------------------------------------------------------------------
  // Local
  // ---------------------------------------------------------------------------
  injector.registerFactory<Storage>(
    () => StorageImpl(
      sharedPref: injector(),
    ),
  );

  injector.registerFactory<TranscriptRepository>(
    () => TranscriptRepositoryImpl(
      api: injector(),
      storage: injector(),
      mapper: injector(),
    ),
  );

  injector.registerFactory(() => GenerateTranscript(
        repository: injector(),
      ));

  injector.registerLazySingleton(
    () => TranscriptMapper(),
  );

  final sharedPref = await SharedPreferences.getInstance();
  injector.registerLazySingleton(
    ()  => sharedPref,
  );

  // ---------------------------------------------------------------------------
  // Common
  // ---------------------------------------------------------------------------
  injector.registerLazySingleton(() => RecordingHandler());
}
