import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_doc/models/document_version_model.dart';
import 'package:google_doc/services/dio_client.dart';


final versionApiProvider = Provider<VersionApi>((ref) {
  return VersionApi(ref.read(dioProvider));
});

class VersionApi {
  final Dio _dio;

  VersionApi(this._dio);

  // ----------------------------
  // GET ALL VERSIONS
  // GET /documents/:id/versions
  // ----------------------------
  Future<List<DocumentVersionModel>> getVersions(String documentId) async {
    final res = await _dio.get('/documents/$documentId/versions');

    final list = res.data['data'] as List;

    return list
        .map((e) => DocumentVersionModel.fromJson(e))
        .toList();
  }

  // ----------------------------
  // RESTORE VERSION
  // POST /documents/:id/restore
  // ----------------------------
  Future<void> restoreVersion({
    required String documentId,
    required String versionId,
  }) async {
    await _dio.post(
      '/documents/$documentId/restore',
      data: {
        'versionId': versionId,
      },
    );
  }
}
