// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Represents a static [Type] in a yet-to-be-resolved Dart library or package.
///
/// Unlike the analyzer's `DartType` representation, a [TypeReference] is based
/// on the library/package name and symbol being the canonical source.
class TypeReference {
  /// The library and symbol representing the type.
  ///
  /// For example `dart:core#List`, or `package:foo/foo.dart#Foo`.
  final Uri type;

  /// Optional.
  ///
  /// If non-empty, the type is assumed to have the provided types as arguments.
  final List<TypeReference> typeArguments;

  factory TypeReference(dynamic typeUrl, [List<dynamic> typeArguments]) {
    final typedType = typeUrl is Uri ? typeUrl : Uri.parse(typeUrl as String);
    final typedArguments = typeArguments != null
        ? typeArguments
            .map((a) => a is TypeReference ? a : new TypeReference(a))
            .toList()
        : const <TypeReference>[];
    return new TypeReference._(typedType, typedArguments);
  }

  const TypeReference._(this.type, this.typeArguments);
}
