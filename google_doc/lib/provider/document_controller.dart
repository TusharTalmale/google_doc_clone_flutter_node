import 'package:google_doc/provider/connection_state_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:google_doc/models/document_model.dart';
import 'package:google_doc/repositories/document_repository.dart';
import 'package:google_doc/services/offline_sync_service.dart';

part 'document_controller.g.dart';

@riverpod
class DocumentController extends _$DocumentController {
  @override
  Future<DocumentModel> build(String documentId) async {  // FIXED: Added parameter
    final repo = ref.read(documentRepositoryProvider);
    return await repo.getDocument(documentId);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => 
      ref.read(documentRepositoryProvider).getDocument(documentId));
  }

  Future<void> updateTitle(String title) async {
    final current = state.asData?.value;
    if (current == null) return;

    // Optimistic update
    state = AsyncValue.data(current.copyWith(title: title));

    try {
      await ref.read(documentRepositoryProvider).updateTitle(current.id, title);
    } catch (e, st) {
      // Revert on error
      state = AsyncValue.error(e, st);
      await Future.delayed(const Duration(milliseconds: 100));
      await refresh();
      rethrow;
    }
  }

  Future<void> saveContent(List<dynamic> content) async {
    final current = state.asData?.value;
    if (current == null) return;
    
    final isOnline = ref.read(isOnlineProvider);
    
    if (!isOnline) {
      // Queue for later sync
      await ref.read(offlineSyncServiceProvider.notifier).queueOperation(
        type: 'save_document',
        documentId: current.id,
        payload: {'content': content},
      );
      
      // Update local state only
      state = AsyncValue.data(current.copyWith(
        content: content,
        saveState: SaveState(
          status: 'unsaved',
          lastSavedAt: DateTime.now(),
        ),
      ));
      return;
    }
    
    try {
      await ref.read(documentRepositoryProvider).saveDocument(current.id, content);
      
      state = AsyncValue.data(current.copyWith(
        content: content,
        saveState: SaveState(
          status: 'saved',
          lastSavedAt: DateTime.now(),
        ),
      ));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> updatePageSettings(PageSettings settings) async {
    final current = state.asData?.value;
    if (current == null) return;

    // Optimistic
    state = AsyncValue.data(current.copyWith(page: settings));

    try {
      await ref.read(documentRepositoryProvider).updatePageSettings(current.id, settings);
    } catch (e) {
      await refresh();
      rethrow;
    }
  }

  Future<void> toggleFavorite() async {
    final current = state.asData?.value;
    if (current == null) return;

    state = AsyncValue.data(current.copyWith(isFavorite: !current.isFavorite));

    try {
      await ref.read(documentRepositoryProvider).toggleFavorite(current.id);
    } catch (e) {
      await refresh();
      rethrow;
    }
  }
}