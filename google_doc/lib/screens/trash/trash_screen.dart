import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_doc/models/document_model.dart';
import 'package:google_doc/provider/document_list_controller.dart';
import 'package:google_doc/repositories/document_repository.dart';

final trashDocumentsProvider = FutureProvider<List<DocumentModel>>((ref) async {
  return ref.read(documentRepositoryProvider).getTrash();
});

class TrashScreen extends ConsumerWidget {
  const TrashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trashAsync = ref.watch(trashDocumentsProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trash'),
        actions: [
          TextButton.icon(
            onPressed: () => _emptyTrash(context, ref),
            icon: const Icon(Icons.delete_forever),
            label: const Text('Empty trash'),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
          ),
        ],
      ),
      body: trashAsync.when(
        data: (documents) {
          if (documents.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.delete_outline, size: 64, color: Colors.grey.shade400),
                  const SizedBox(height: 16),
                  Text(
                    'Trash is empty',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            );
          }
          
          return ListView.builder(
            itemCount: documents.length,
            padding: const EdgeInsets.all(8),
            itemBuilder: (context, index) {
              final doc = documents[index];
              return _buildTrashItem(context, ref, doc);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 48, color: Colors.red.shade300),
              const SizedBox(height: 16),
              Text('Failed to load trash', style: Theme.of(context).textTheme.titleMedium),
              TextButton(
                onPressed: () => ref.refresh(trashDocumentsProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTrashItem(BuildContext context, WidgetRef ref, DocumentModel doc) {
    final deleteDate = doc.deletedAt ?? DateTime.now();
    final daysRemaining = 30 - DateTime.now().difference(deleteDate).inDays;
    
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => _restoreDocument(context, ref, doc.id),
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            icon: Icons.restore,
            label: 'Restore',
          ),
          SlidableAction(
            onPressed: (_) => _deleteForever(context, ref, doc.id),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete_forever,
            label: 'Delete',
          ),
        ],
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListTile(
          leading: const Icon(Icons.insert_drive_file, color: Colors.grey),
          title: Text(
            doc.title,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Deleted ${deleteDate}'),
              Text(
                'Will be deleted permanently in $daysRemaining days',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.red.shade700,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          isThreeLine: true,
          trailing: PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'restore') {
                _restoreDocument(context, ref, doc.id);
              } else if (value == 'delete') {
                _deleteForever(context, ref, doc.id);
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'restore',
                child: Row(
                  children: [
                    Icon(Icons.restore, color: Colors.green),
                    SizedBox(width: 8),
                    Text('Restore'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete_forever, color: Colors.red),
                    SizedBox(width: 8),
                    Text('Delete forever'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _restoreDocument(BuildContext context, WidgetRef ref, String id) async {
    try {
      await ref.read(documentRepositoryProvider).restoreFromTrash(id);
      ref.invalidate(trashDocumentsProvider);
      ref.invalidate(documentListControllerProvider); // Refresh main list
      
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Document restored')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  Future<void> _deleteForever(BuildContext context, WidgetRef ref, String id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete forever?'),
        content: const Text('This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        await ref.read(documentRepositoryProvider).deleteDocument(id);
        ref.invalidate(trashDocumentsProvider);
        
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Document deleted permanently')),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $e')),
          );
        }
      }
    }
  }

  Future<void> _emptyTrash(BuildContext context, WidgetRef ref) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Empty trash?'),
        content: const Text('All items in trash will be permanently deleted.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Empty trash'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      // You would implement empty trash API here
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Trash emptied')),
      );
    }
  }
}