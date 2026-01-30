import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_doc/models/document_model.dart';
import 'package:google_doc/services/dio_client.dart';


final documentApiProvider = Provider<DocumentApi>((ref) {
  return DocumentApi(ref.read(dioProvider));
});

class DocumentApi {
  final Dio _dio;

  DocumentApi(this._dio);

  // ----------------------------
  // CREATE DOCUMENT
  // POST /documents
  // ----------------------------
  Future<DocumentModel> createDocument() async {
    final res = await _dio.post('/documents');

    return DocumentModel.fromJson(res.data['data']);
  }

  // ----------------------------
  // GET ALL DOCUMENTS
  // GET /documents
  // ----------------------------
  Future<List<DocumentModel>> getAllDocuments() async {
    final res = await _dio.get('/documents');

    final list = res.data['data'] as List;

    return list
        .map((e) => DocumentModel.fromJson(e))
        .toList();
  }

  // ----------------------------
  // GET SINGLE DOCUMENT
  // GET /documents/:id
  // ----------------------------
  Future<DocumentModel> getDocumentById(String documentId) async {
    final res = await _dio.get('/documents/$documentId');

    return DocumentModel.fromJson(res.data['data']);
  }

  // ----------------------------
  // UPDATE TITLE
  // PATCH /documents/:id/title
  // ----------------------------
  Future<DocumentModel> updateTitle({
    required String documentId,
    required String title,
  }) async {
    final res = await _dio.patch(
      '/documents/$documentId/title',
      data: {
        'title': title,
      },
    );

    return DocumentModel.fromJson(res.data['data']);
  }

  // ----------------------------
  // SAVE DOCUMENT (MANUAL)
  // POST /documents/:id/save
  // ----------------------------
  Future<void> saveDocument({
    required String documentId,
    required List<dynamic> content,
  }) async {
    await _dio.post(
      '/documents/$documentId/save',
      data: {
        'content': content,
      },
    );
  }

  // ----------------------------
  // SHARE DOCUMENT
  // POST /documents/:id/share
  // ----------------------------
  Future<DocumentModel> shareDocument({
    required String documentId,
    required String email,
    required String role,
  }) async {
    final res = await _dio.post(
      '/documents/$documentId/share',
      data: {
        'email': email,
        'role': role,
      },
    );

    return DocumentModel.fromJson(res.data['data']);
  }

  // ----------------------------
  // REMOVE COLLABORATOR
  // DELETE /documents/:id/collaborator
  // ----------------------------
  Future<void> removeCollaborator({
    required String documentId,
    required String userId,
  }) async {
    await _dio.delete(
      '/documents/$documentId/collaborator',
      data: {
        'userId': userId,
      },
    );
  }

  // ----------------------------
  // TRASH
  // ----------------------------
  Future<void> moveToTrash(String documentId) async {
    await _dio.delete('/documents/$documentId');
  }

  Future<List<DocumentModel>> getTrashDocuments() async {
    final res = await _dio.get('/documents/trash');

    final list = res.data['data'] as List;

    return list
        .map((e) => DocumentModel.fromJson(e))
        .toList();
  }

  Future<void> restoreFromTrash(String documentId) async {
    await _dio.patch('/documents/$documentId/restore');
  }
}
