// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(backendApi)
const backendApiProvider = BackendApiProvider._();

final class BackendApiProvider
    extends $FunctionalProvider<ApiService, ApiService, ApiService>
    with $Provider<ApiService> {
  const BackendApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'backendApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$backendApiHash();

  @$internal
  @override
  $ProviderElement<ApiService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ApiService create(Ref ref) {
    return backendApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ApiService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ApiService>(value),
    );
  }
}

String _$backendApiHash() => r'3500771d97471b78d3a7d641a1efc2b19b07dd7f';

@ProviderFor(Chat)
const chatProvider = ChatProvider._();

final class ChatProvider extends $NotifierProvider<Chat, List<Message>> {
  const ChatProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'chatProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$chatHash();

  @$internal
  @override
  Chat create() => Chat();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Message> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Message>>(value),
    );
  }
}

String _$chatHash() => r'9b8285f42eba5f7dd0df23f85a662a784399214d';

abstract class _$Chat extends $Notifier<List<Message>> {
  List<Message> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<Message>, List<Message>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<Message>, List<Message>>,
              List<Message>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
