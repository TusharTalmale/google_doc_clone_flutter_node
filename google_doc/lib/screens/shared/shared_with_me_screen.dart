import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_doc/models/document_model.dart';
import 'package:google_doc/repositories/document_repository.dart';

final sharedDocumentsProvider = FutureProvider<List<DocumentModel>>((ref) async {
  final allDocs = await ref.read(documentRepositoryProvider).getMyDocuments();
  // Filter documents where current user is not owner but is collaborator
  return allDocs.where((doc) {
    // This assumes you're tracking current user ID somewhere
    // In real implementation, filter properly based on backend response
    return doc.ownerId != 'currentUserId'; 
  }).toList();
});

class SharedWithMeScreen extends ConsumerWidget {
  const SharedWithMeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sharedAsync = ref.watch(sharedDocumentsProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shared with me'),
      ),
      body: sharedAsync.when(
        data: (documents) {
          if (documents.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.folder_shared_outlined, size: 64, color: Colors.grey.shade400),
                  const SizedBox(height: 16),
                  Text(
                    'No shared documents',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Documents shared with you will appear here',
                    style: TextStyle(color: Colors.grey.shade500),
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
              return _buildSharedDocCard(context, ref, doc);
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
              Text('Failed to load', style: Theme.of(context).textTheme.titleMedium),
              TextButton(
                onPressed: () => ref.refresh(sharedDocumentsProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSharedDocCard(BuildContext context, WidgetRef ref, DocumentModel doc) {
    final collaborator = doc.collaborators.firstWhere(
      (c) => c.userId == 'currentUserId', // Replace with actual current user ID
      orElse: () => const Collaborator(userId: '', role: 'viewer'),
    );
    
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: const Icon(Icons.insert_drive_file, color: Colors.blue),
        title: Text(
          doc.title,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Shared by ${doc.ownerId}'), // Replace with owner name
            Text(
              'Your role: ${collaborator.role.toUpperCase()}',
              style: TextStyle(
                color: _getRoleColor(collaborator.role),
                fontWeight: FontWeight.w500,
              ),
            ),
            Text('Modified ${(doc.updatedAt ?? DateTime.now())}'),
          ],
        ),
        isThreeLine: true,
        trailing: Chip(
          label: Text(
            collaborator.role,
            style: const TextStyle(fontSize: 12, color: Colors.white),
          ),
          backgroundColor: _getRoleColor(collaborator.role),
          padding: EdgeInsets.zero,
        ),
        onTap: () => context.push('/doc/${doc.id}'),
      ),
    );
  }

  Color _getRoleColor(String role) {
    switch (role.toLowerCase()) {
      case 'owner':
        return Colors.purple;
      case 'editor':
        return Colors.blue;
      case 'commenter':
        return Colors.orange;
      case 'viewer':
      default:
        return Colors.grey;
    }
  }
}