// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'socket_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(socketRepository)
const socketRepositoryProvider = SocketRepositoryProvider._();

final class SocketRepositoryProvider
    extends
        $FunctionalProvider<
          SocketRepository,
          SocketRepository,
          SocketRepository
        >
    with $Provider<SocketRepository> {
  const SocketRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'socketRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$socketRepositoryHash();

  @$internal
  @override
  $ProviderElement<SocketRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SocketRepository create(Ref ref) {
    return socketRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SocketRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SocketRepository>(value),
    );
  }
}

String _$socketRepositoryHash() => r'9f2c8a900ac91fea89b3e19e08f582a95fafdcc8';
