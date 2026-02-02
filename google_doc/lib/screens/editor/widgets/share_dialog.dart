import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_doc/repositories/document_repository.dart';
import 'package:share_plus/share_plus.dart';

class ShareDialog extends ConsumerStatefulWidget {
  final String documentId;
  
  const ShareDialog({super.key, required this.documentId});

  @override
  ConsumerState<ShareDialog> createState() => _ShareDialogState();
}

class _ShareDialogState extends ConsumerState<ShareDialog> {
  final _emailController = TextEditingController();
  String _selectedRole = 'viewer';
  bool _isLoading = false;
  String? _link;
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Share with others'),
      content: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Email input
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: 'Add people by email',
                prefixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            
            // Role selector
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'viewer', label: Text('Viewer')),
                ButtonSegment(value: 'editor', label: Text('Editor')),
                ButtonSegment(value: 'commenter', label: Text('Commenter')),
              ],
              selected: {_selectedRole},
              onSelectionChanged: (set) => setState(() => _selectedRole = set.first),
            ),
            const SizedBox(height: 16),
            
            // Share button
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _share,
                child: _isLoading 
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Send invite'),
              ),
            ),
            
            const Divider(height: 32),
            
            // Link sharing
            if (_link != null) ...[
              const Text('Link sharing', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _link!,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.copy),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: _link!));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Link copied')),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ] else
              TextButton.icon(
                onPressed: _generateLink,
                icon: const Icon(Icons.link),
                label: const Text('Get shareable link'),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Done'),
        ),
      ],
    );
  }
  
  void _share() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) return;
    
    setState(() => _isLoading = true);
    
    try {
      await ref.read(documentRepositoryProvider).shareDocument(
        widget.documentId,
        email,
        _selectedRole,
      );
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Shared with $email')),
        );
        _emailController.clear();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }
  
  void _generateLink() async {
    setState(() => _isLoading = true);
    
    try {
      final link = await ref.read(documentRepositoryProvider).generateShareLink(
        widget.documentId,
        'view',
      );
      
      setState(() => _link = link);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }
}