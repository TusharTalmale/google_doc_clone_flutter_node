// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connection_state_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(connectivityStream)
const connectivityStreamProvider = ConnectivityStreamProvider._();

final class ConnectivityStreamProvider
    extends
        $FunctionalProvider<
          AsyncValue<ConnectivityResult>,
          ConnectivityResult,
          Stream<ConnectivityResult>
        >
    with
        $FutureModifier<ConnectivityResult>,
        $StreamProvider<ConnectivityResult> {
  const ConnectivityStreamProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'connectivityStreamProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$connectivityStreamHash();

  @$internal
  @override
  $StreamProviderElement<ConnectivityResult> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<ConnectivityResult> create(Ref ref) {
    return connectivityStream(ref);
  }
}

String _$connectivityStreamHash() =>
    r'd54afa6bff5323bbea7cce3e2daf300fe4ee6e7d';

@ProviderFor(isOnline)
const isOnlineProvider = IsOnlineProvider._();

final class IsOnlineProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  const IsOnlineProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isOnlineProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isOnlineHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isOnline(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isOnlineHash() => r'44dde44243cc0b754e313956e547c1f82a5d8728';

@ProviderFor(socketConnectionState)
const socketConnectionStateProvider = SocketConnectionStateProvider._();

final class SocketConnectionStateProvider
    extends
        $FunctionalProvider<
          AsyncValue<SocketConnectionState>,
          SocketConnectionState,
          Stream<SocketConnectionState>
        >
    with
        $FutureModifier<SocketConnectionState>,
        $StreamProvider<SocketConnectionState> {
  const SocketConnectionStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'socketConnectionStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$socketConnectionStateHash();

  @$internal
  @override
  $StreamProviderElement<SocketConnectionState> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<SocketConnectionState> create(Ref ref) {
    return socketConnectionState(ref);
  }
}

String _$socketConnectionStateHash() =>
    r'a55779debead58089b53fb6cbc91468714fb9999';
