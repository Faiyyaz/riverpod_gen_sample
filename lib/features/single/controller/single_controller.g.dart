// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$singleHash() => r'ce8ed26b0c5b4f4a171b083d8f15d15179f34abc';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

typedef SingleRef = AutoDisposeFutureProviderRef<CustomPlaceholder>;

/// Whenever flag is change we need to rebuild app
/// flutter pub run build_runner build
/// Also if we mark anything keepAlive then all related provider should be keepAlive
/// With keepAlive
/// Without keepAlive (default)
///
/// Copied from [single].
@ProviderFor(single)
const singleProvider = SingleFamily();

/// Whenever flag is change we need to rebuild app
/// flutter pub run build_runner build
/// Also if we mark anything keepAlive then all related provider should be keepAlive
/// With keepAlive
/// Without keepAlive (default)
///
/// Copied from [single].
class SingleFamily extends Family<AsyncValue<CustomPlaceholder>> {
  /// Whenever flag is change we need to rebuild app
  /// flutter pub run build_runner build
  /// Also if we mark anything keepAlive then all related provider should be keepAlive
  /// With keepAlive
  /// Without keepAlive (default)
  ///
  /// Copied from [single].
  const SingleFamily();

  /// Whenever flag is change we need to rebuild app
  /// flutter pub run build_runner build
  /// Also if we mark anything keepAlive then all related provider should be keepAlive
  /// With keepAlive
  /// Without keepAlive (default)
  ///
  /// Copied from [single].
  SingleProvider call({
    required int postId,
  }) {
    return SingleProvider(
      postId: postId,
    );
  }

  @override
  SingleProvider getProviderOverride(
    covariant SingleProvider provider,
  ) {
    return call(
      postId: provider.postId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'singleProvider';
}

/// Whenever flag is change we need to rebuild app
/// flutter pub run build_runner build
/// Also if we mark anything keepAlive then all related provider should be keepAlive
/// With keepAlive
/// Without keepAlive (default)
///
/// Copied from [single].
class SingleProvider extends AutoDisposeFutureProvider<CustomPlaceholder> {
  /// Whenever flag is change we need to rebuild app
  /// flutter pub run build_runner build
  /// Also if we mark anything keepAlive then all related provider should be keepAlive
  /// With keepAlive
  /// Without keepAlive (default)
  ///
  /// Copied from [single].
  SingleProvider({
    required this.postId,
  }) : super.internal(
          (ref) => single(
            ref,
            postId: postId,
          ),
          from: singleProvider,
          name: r'singleProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$singleHash,
          dependencies: SingleFamily._dependencies,
          allTransitiveDependencies: SingleFamily._allTransitiveDependencies,
        );

  final int postId;

  @override
  bool operator ==(Object other) {
    return other is SingleProvider && other.postId == postId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, postId.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
