// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'socket_client.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SocketClient)
const socketClientProvider = SocketClientProvider._();

final class SocketClientProvider
    extends $StreamNotifierProvider<SocketClient, SocketConnectionState> {
  const SocketClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'socketClientProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$socketClientHash();

  @$internal
  @override
  SocketClient create() => SocketClient();
}

String _$socketClientHash() => r'48a24f4243bc1f0984f622491de0658c6425f73a';

abstract class _$SocketClient extends $StreamNotifier<SocketConnectionState> {
  Stream<SocketConnectionState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<AsyncValue<SocketConnectionState>, SocketConnectionState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<SocketConnectionState>,
                SocketConnectionState
              >,
              AsyncValue<SocketConnectionState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
