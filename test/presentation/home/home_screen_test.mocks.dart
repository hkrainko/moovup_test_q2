// Mocks generated by Mockito 5.4.4 from annotations
// in moovup_test/test/presentation/home/home_screen_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:moovup_test/domain/entities/person.dart' as _i4;
import 'package:moovup_test/domain/usecases/people_usecase.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [PeopleUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockPeopleUseCase extends _i1.Mock implements _i2.PeopleUseCase {
  @override
  _i3.Stream<List<_i4.Person>> get peopleBoardcast => (super.noSuchMethod(
        Invocation.getter(#peopleBoardcast),
        returnValue: _i3.Stream<List<_i4.Person>>.empty(),
        returnValueForMissingStub: _i3.Stream<List<_i4.Person>>.empty(),
      ) as _i3.Stream<List<_i4.Person>>);

  @override
  void refresh() => super.noSuchMethod(
        Invocation.method(
          #refresh,
          [],
        ),
        returnValueForMissingStub: null,
      );
}
