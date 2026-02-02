// import 'package:dio/dio.dart';
// import 'package:google_doc/utils/constant/api_constant.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
// import 'package:google_doc/models/document_model.dart';
// import 'package:google_doc/models/api_response.dart';
// import 'package:google_doc/services/dio_client.dart';

// part 'document_repository.g.dart';

// @Riverpod(keepAlive: true)
// DocumentRepository documentRepository(Ref ref) {
//   return DocumentRepository(ref.read(dioClientProvider));
// }

// class DocumentRepository {
//   final Dio _dio;
  
//   DocumentRepository(this._dio);

//   Future<DocumentModel> createDocument() async {
//     final res = await _dio.post(ApiConstants.createDocument);
//     return _parseDocument(res.data);
//   }

//   Future<List<DocumentModel>> getMyDocuments() async {
//     final res = await _dio.get(ApiConstants.myDocuments);
//     final apiRes = ApiResponse<List<dynamic>>.fromJson(
//       res.data,
//       (json) => json as List<dynamic>,
//     );
    
//     return (apiRes.data ?? [])
//         .map((e) => DocumentModel.fromJson(e as Map<String, dynamic>))
//         .toList();
//   }
//   Future<DocumentModel> updateTitle(String id, String title) async {
//     final res = await _dio.post(
//       '${ApiConstants.renameDocument}/$id',
//       data: {'title': title},
//     );
//     return _parseDocument(res.data);
//   }
//   Future<DocumentModel> getDocument(String id) async {
//     final res = await _dio.get('${ApiConstants.getDocument}/$id');
//     return _parseDocument(res.data);
//   }



//   Future<void> saveDocument(String id, List<dynamic> content) async {
//     await _dio.post(
//       '${ApiConstants.saveDocument}/$id',
//       data: {'content': content},
//     );
//   }

//   Future<void> deleteDocument(String id) async {
//     await _dio.delete('${ApiConstants.deleteDocument}/$id');
//   }

//   Future<void> restoreFromTrash(String id) async {
//     await _dio.post('${ApiConstants.restoreFromTrash}/$id');
//   }

//   Future<List<DocumentModel>> getTrash() async {
//     final res = await _dio.get(ApiConstants.trashAll);
//     final apiRes = ApiResponse<List<dynamic>>.fromJson(
//       res.data,
//       (json) => json as List<dynamic>,
//     );
//     return (apiRes.data ?? [])
//         .map((e) => DocumentModel.fromJson(e as Map<String, dynamic>))
//         .toList();
//   }

//   Future<void> toggleFavorite(String id) async {
//     await _dio.post('/api/documents/$id/favorite');
//   }

//   Future<void> shareDocument(String id, String email, String role) async {
//     await _dio.post(
//       '${ApiConstants.shareDocument}/$id',
//       data: {'email': email, 'role': role},
//     );
//   }

 
//    Future<void> updatePageSettings(String id, PageSettings settings) async {
//     await _dio.patch(
//       '/api/documents/$id/page-settings',
//       data: settings.toJson(),
//     );
//   }
//    Future<String> generateShareLink(String id, String access) async {
//     final res = await _dio.post(
//       '/api/documents/$id/share-link',
//       data: {'access': access},
//     );
//     final apiRes = ApiResponse<Map<String, dynamic>>.fromJson(
//       res.data,
//       (json) => json as Map<String, dynamic>,
//     );
//     return apiRes.data?['link'] ?? '';
//   }

//   DocumentModel _parseDocument(dynamic data) {
//     final apiRes = ApiResponse<Map<String, dynamic>>.fromJson(
//       data,
//       (json) => json as Map<String, dynamic>,
//     );
//     return DocumentModel.fromJson(apiRes.data!);
//   }
// }

import 'package:dio/dio.dart';
import 'package:google_doc/utils/api_constant.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:google_doc/models/document_model.dart';
import 'package:google_doc/models/api_response.dart';
import 'package:google_doc/services/dio_client.dart';

part 'document_repository.g.dart';

@Riverpod(keepAlive: true)
DocumentRepository documentRepository(Ref ref) {
  return DocumentRepository(ref.read(dioClientProvider));
}

class DocumentRepository {
  final Dio _dio;
  
  DocumentRepository(this._dio);

  Future<DocumentModel> createDocument() async {
    final res = await _dio.post(ApiConstants.createDocument);
    return _parseDocument(res.data);
  }

  Future<List<DocumentModel>> getMyDocuments() async {
    final res = await _dio.get(ApiConstants.myDocuments);
    final apiRes = ApiResponse<List<dynamic>>.fromJson(
      res.data,
      (json) => json as List<dynamic>,
    );
    
    return (apiRes.data ?? [])
        .map((e) => DocumentModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<DocumentModel> getDocument(String id) async {
    final res = await _dio.get('${ApiConstants.getDocument}/$id');
    return _parseDocument(res.data);
  }

  Future<DocumentModel> updateTitle(String id, String title) async {
    final res = await _dio.post(
      '${ApiConstants.renameDocument}/$id',
      data: {'title': title},
    );
    return _parseDocument(res.data);
  }

  Future<void> saveDocument(String id, List<dynamic> content) async {
    await _dio.post(
      '${ApiConstants.saveDocument}/$id',
      data: {'content': content},
    );
  }

  Future<void> deleteDocument(String id) async {
    await _dio.delete('${ApiConstants.deleteDocument}/$id');
  }

  Future<void> restoreFromTrash(String id) async {
    await _dio.post('${ApiConstants.restoreFromTrash}/$id');
  }

  Future<List<DocumentModel>> getTrash() async {
    final res = await _dio.get(ApiConstants.trashAll);
    final apiRes = ApiResponse<List<dynamic>>.fromJson(
      res.data,
      (json) => json as List<dynamic>,
    );
    return (apiRes.data ?? [])
        .map((e) => DocumentModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> toggleFavorite(String id) async {
    await _dio.post('/api/documents/$id/favorite');
  }

  Future<void> shareDocument(String id, String email, String role) async {
    await _dio.post(
      '${ApiConstants.shareDocument}/$id',
      data: {'email': email, 'role': role},
    );
  }

  Future<void> updatePageSettings(String id, PageSettings settings) async {
    await _dio.patch(
      '/api/documents/$id/page-settings',
      data: settings.toJson(),
    );
  }

  Future<String> generateShareLink(String id, String access) async {
    final res = await _dio.post(
      '/api/documents/$id/share-link',
      data: {'access': access},
    );
    final apiRes = ApiResponse<Map<String, dynamic>>.fromJson(
      res.data,
      (json) => json as Map<String, dynamic>,
    );
    return apiRes.data?['link'] ?? '';
  }

  DocumentModel _parseDocument(dynamic data) {
    final apiRes = ApiResponse<Map<String, dynamic>>.fromJson(
      data,
      (json) => json as Map<String, dynamic>,
    );
    return DocumentModel.fromJson(apiRes.data!);
  }
}