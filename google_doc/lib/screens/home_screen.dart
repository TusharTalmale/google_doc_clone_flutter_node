import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final isWeb = width > 900;

    return Scaffold(
      backgroundColor: const Color(0xfff8f9fa),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "My Documents",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black54),
            onPressed: () {},
          ),
          const CircleAvatar(
            radius: 18,
            backgroundColor: Colors.blue,
            child: Text("T"),
          ),
          const SizedBox(width: 16)
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // =====================
            // Create new
            // =====================
            const Text(
              "Start a new document",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 16),

            SizedBox(
              height: 160,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  _CreateCard(),
                  _TemplateCard(title: "Resume"),
                  _TemplateCard(title: "Report"),
                  _TemplateCard(title: "Notes"),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // =====================
            // Documents grid
            // =====================
            const Text(
              "Your documents",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isWeb ? 5 : 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.78,
                ),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const _DocumentCard();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// UI COMPONENTS
// ============================================================================

class _CreateCard extends StatelessWidget {
  const _CreateCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.white,
      ),
      child: const Center(
        child: Icon(Icons.add, size: 40),
      ),
    );
  }
}

class _TemplateCard extends StatelessWidget {
  final String title;

  const _TemplateCard({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade200,
      ),
      child: Center(
        child: Text(title),
      ),
    );
  }
}

class _DocumentCard extends StatelessWidget {
  const _DocumentCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            blurRadius: 6,
            color: Colors.black12,
          )
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                color: Color(0xffe8f0fe),
              ),
              child: const Center(
                child: Icon(Icons.description, size: 48),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Untitled Document",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 4),
                Text(
                  "Edited yesterday",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
