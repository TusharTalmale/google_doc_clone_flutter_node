import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:google_doc/models/document_model.dart';
import 'package:google_doc/models/socket_events.dart';
import 'package:google_doc/repositories/document_repository.dart';
import 'package:google_doc/services/socket_client.dart';
import 'package:google_doc/repositories/socket_repository.dart';

part 'document_list_controller.g.dart';

@riverpod
class DocumentListController extends _$DocumentListController {
  @override
  Future<List<DocumentModel>> build() async {
    _initSocket();
    return _fetchDocuments();
  }

  void _initSocket() {
    // Ensure socket is connected
    final client = ref.read(socketClientProvider.notifier);
    if (!client.isConnected) {
      client.connect();
    }

    // Listen for global updates
    ref.read(socketRepositoryProvider).eventStream.listen((event) {
      event.mapOrNull(
        documentListUpdate: (_) => refresh(),
      );
    });
  }

  Future<List<DocumentModel>> _fetchDocuments() async {
    final repository = ref.read(documentRepositoryProvider);
    return await repository.getMyDocuments();  // FIXED: Was getDocuments()
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchDocuments());
  }

  Future<void> createDocument() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(documentRepositoryProvider);
      await repository.createDocument();  // FIXED: Removed title parameter (backend generates "Untitled")
      return _fetchDocuments();
    });
  }

  Future<void> deleteDocument(String id) async {
    try {
      final repo = ref.read(documentRepositoryProvider);
      await repo.deleteDocument(id);
      
      // Optimistic update
      final current = state.asData?.value ?? [];
      state = AsyncValue.data(current.where((d) => d.id != id).toList());
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> restoreFromTrash(String id) async {
    try {
      await ref.read(documentRepositoryProvider).restoreFromTrash(id);
      await refresh(); // Refresh to show updated list
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> toggleFavorite(String id) async {
    final current = state.asData?.value ?? [];
    final docIndex = current.indexWhere((d) => d.id == id);
    if (docIndex == -1) return;

    // Optimistic update
    final updated = [...current];
    updated[docIndex] = updated[docIndex].copyWith(
      isFavorite: !updated[docIndex].isFavorite,
    );
    state = AsyncValue.data(updated);

    try {
      await ref.read(documentRepositoryProvider).toggleFavorite(id);
    } catch (e) {
      await refresh(); // Revert on error
      rethrow;
    }
  }

  Future<void> shareDocument(String id, String email, String role) async {
    try {
      await ref.read(documentRepositoryProvider).shareDocument(id, email, role);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }
}