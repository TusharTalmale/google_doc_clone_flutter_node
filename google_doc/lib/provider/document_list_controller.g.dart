// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_list_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DocumentListController)
const documentListControllerProvider = DocumentListControllerProvider._();

final class DocumentListControllerProvider
    extends
        $AsyncNotifierProvider<DocumentListController, List<DocumentModel>> {
  const DocumentListControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'documentListControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$documentListControllerHash();

  @$internal
  @override
  DocumentListController create() => DocumentListController();
}

String _$documentListControllerHash() =>
    r'5d37399c6e7ad435f9ccb5113eb2d99c750aa78f';

abstract class _$DocumentListController
    extends $AsyncNotifier<List<DocumentModel>> {
  FutureOr<List<DocumentModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<List<DocumentModel>>, List<DocumentModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<DocumentModel>>, List<DocumentModel>>,
              AsyncValue<List<DocumentModel>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
