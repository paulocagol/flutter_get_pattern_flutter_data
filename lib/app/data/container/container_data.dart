import 'package:flutter_data/flutter_data.dart';
import 'package:flutter_get_pattern_flutter_data/main.data.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

class ContainerData {
  ProviderContainer _providerContainer;

  static ContainerData _instance;

  ContainerData._();

  static ContainerData get instace {
    _instance ??= ContainerData._();
    return _instance;
  }

  Future<ProviderContainer> get providerContainer async => await _configureProviderContainer();

  Future<ProviderContainer> _configureProviderContainer() async {
    if (_providerContainer == null) {
      _providerContainer = ProviderContainer(
        overrides: [
          configureRepositoryLocalStorage(
            clear: false,
            baseDirFn: () async => await getApplicationDocumentsDirectory().then((directory) => directory.path),
          ),
        ],
      );
      await _providerContainer.read(repositoryInitializerProvider().future);
    }
    return _providerContainer;
  }
}
