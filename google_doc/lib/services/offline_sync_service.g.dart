// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline_sync_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(OfflineSyncService)
const offlineSyncServiceProvider = OfflineSyncServiceProvider._();

final class OfflineSyncServiceProvider
    extends $AsyncNotifierProvider<OfflineSyncService, void> {
  const OfflineSyncServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'offlineSyncServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$offlineSyncServiceHash();

  @$internal
  @override
  OfflineSyncService create() => OfflineSyncService();
}

String _$offlineSyncServiceHash() =>
    r'cabf53e78ad3c0ddad612f96b6d681d6ad6b243c';

abstract class _$OfflineSyncService extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleValue(ref, null);
  }
}
