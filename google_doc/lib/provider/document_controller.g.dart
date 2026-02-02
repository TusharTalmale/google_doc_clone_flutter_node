// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DocumentController)
const documentControllerProvider = DocumentControllerFamily._();

final class DocumentControllerProvider
    extends $AsyncNotifierProvider<DocumentController, DocumentModel> {
  const DocumentControllerProvider._({
    required DocumentControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'documentControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$documentControllerHash();

  @override
  String toString() {
    return r'documentControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  DocumentController create() => DocumentController();

  @override
  bool operator ==(Object other) {
    return other is DocumentControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$documentControllerHash() =>
    r'a17a2f2350da5101aa9b3da771323e0c08836317';

final class DocumentControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          DocumentController,
          AsyncValue<DocumentModel>,
          DocumentModel,
          FutureOr<DocumentModel>,
          String
        > {
  const DocumentControllerFamily._()
    : super(
        retry: null,
        name: r'documentControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  DocumentControllerProvider call(String documentId) =>
      DocumentControllerProvider._(argument: documentId, from: this);

  @override
  String toString() => r'documentControllerProvider';
}

abstract class _$DocumentController extends $AsyncNotifier<DocumentModel> {
  late final _$args = ref.$arg as String;
  String get documentId => _$args;

  FutureOr<DocumentModel> build(String documentId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<DocumentModel>, DocumentModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<DocumentModel>, DocumentModel>,
              AsyncValue<DocumentModel>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
