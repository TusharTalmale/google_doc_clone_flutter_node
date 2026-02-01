import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:google_doc/services/socket_client.dart';

part 'connection_state_provider.g.dart';

@riverpod
Stream<ConnectivityResult> connectivityStream(Ref ref) {
  return Connectivity().onConnectivityChanged;
}

@riverpod
bool isOnline(Ref ref) {
  final connectivity = ref.watch(connectivityStreamProvider);
  return connectivity.maybeWhen(
    data: (result) => result != ConnectivityResult.none,
    orElse: () => false,
  );
}

@riverpod
Stream<SocketConnectionState> socketConnectionState(Ref ref) {
  return ref.watch(socketClientProvider.stream);
}
