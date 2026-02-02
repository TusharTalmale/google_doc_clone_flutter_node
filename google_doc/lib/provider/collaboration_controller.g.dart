// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collaboration_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CollaborationController)
const collaborationControllerProvider = CollaborationControllerFamily._();

final class CollaborationControllerProvider
    extends $NotifierProvider<CollaborationController, CollaborationState> {
  const CollaborationControllerProvider._({
    required CollaborationControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'collaborationControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$collaborationControllerHash();

  @override
  String toString() {
    return r'collaborationControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  CollaborationController create() => CollaborationController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CollaborationState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CollaborationState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CollaborationControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$collaborationControllerHash() =>
    r'8e23b51d86431c1e793af83fa16a2b9799af41fe';

final class CollaborationControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          CollaborationController,
          CollaborationState,
          CollaborationState,
          CollaborationState,
          String
        > {
  const CollaborationControllerFamily._()
    : super(
        retry: null,
        name: r'collaborationControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CollaborationControllerProvider call(String documentId) =>
      CollaborationControllerProvider._(argument: documentId, from: this);

  @override
  String toString() => r'collaborationControllerProvider';
}

abstract class _$CollaborationController extends $Notifier<CollaborationState> {
  late final _$args = ref.$arg as String;
  String get documentId => _$args;

  CollaborationState build(String documentId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<CollaborationState, CollaborationState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CollaborationState, CollaborationState>,
              CollaborationState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
