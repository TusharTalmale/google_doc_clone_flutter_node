import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_doc/models/document_model.dart';
import 'package:google_doc/provider/document_list_controller.dart';
import 'package:google_doc/widgets/animations.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final docList = ref.watch(documentListControllerProvider);

    return Scaffold(
      body: docList.when(
        data: (doc) => _buildDocumentsGrid(context, ref, doc),
        error: (err, stack) => _buildErrorWidget(context, ref, err),
        loading: () => _buildShimmerLoading(),
        skipLoadingOnRefresh: true,
        skipLoadingOnReload: true,
      ),
    );
  }
}

Widget _buildDocumentsGrid(
  BuildContext context,
  WidgetRef ref,
  List<DocumentModel> documents,
) {
  final isDesktop = MediaQuery.of(context).size.width > 900;
  final crossAxisCount = isDesktop ? 4 : 2;
  if (documents.isEmpty) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.description_outlined,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'No documents yet',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 8),
          TextButton.icon(
            onPressed: () => ref
                .read(documentListControllerProvider.notifier)
                .createDocument(),
            icon: const Icon(Icons.add),
            label: const Text('Create your first document'),
          ),
        ],
      ),
    );
  }

  return CustomScrollView(
    slivers: [
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              Text(
                "My Documents",
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              SegmentedButton<int>(
                segments: const [
                  ButtonSegment(value: 0, label: Icon(Icons.grid_view)),
                  ButtonSegment(value: 1, label: Icon(Icons.list)),
                ],
                selected: const <int>{0},
                onSelectionChanged: (value) {},
              ),
            ],
          ),
        ),
      ),
      SliverPadding(
        padding: const EdgeInsets.all(24),
        sliver: SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: 0.75,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
          ),
          delegate: SliverChildBuilderDelegate((context, index) {
            final document = documents[index];
            return DocumentCard(
              document: document,
              onTap: () => context.push('/doc/${document.id}'),
            ).animateFadeIn(delayMs: index * 50);
          }, childCount: documents.length),
        ),
      ),
      const SliverPadding(padding: EdgeInsets.all(24)),
    ],
  );
}

Widget _buildShimmerLoading() {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    child: GridView.builder(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: 8,
      itemBuilder: (_, __) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
  );
}

Widget _buildErrorWidget(BuildContext context, WidgetRef ref, Object error) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.error_outline, size: 48, color: Colors.red.shade300),
        const SizedBox(height: 16),
        Text(
          'Failed to load documents',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Text(error.toString(), style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => ref.refresh(documentListControllerProvider),
          child: const Text('Retry'),
        ),
      ],
    ),
  );
}

class DocumentCard extends StatelessWidget {
  final DocumentModel document;
  final VoidCallback onTap;

  const DocumentCard({super.key, required this.document, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail/Preview
            Expanded(
              child: Container(
                width: double.infinity,
                color: Colors.grey.shade50,
                child: const Center(
                  child: Icon(Icons.description, size: 48, color: Colors.grey),
                ),
              ),
            ),

            // Info
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    document.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Edited ${(document.updatedAt ?? DateTime.now())}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                      if (document.isFavorite)
                        const Icon(Icons.star, size: 14, color: Colors.amber),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
