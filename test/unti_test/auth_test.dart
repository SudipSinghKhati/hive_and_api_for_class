import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_and_api_for_class/core/failure/failure.dart';
import 'package:hive_and_api_for_class/features/auth/domain/use_case/auth_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_and_api_for_class/features/auth/presentation/state/auth_state.dart';
import 'package:hive_and_api_for_class/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AuthUseCase>(),
  MockSpec<BuildContext>(),
])
void main() {
  late AuthUseCase mockAuthUseCase;
  
  late ProviderContainer container;
  
  late BuildContext context;

  setUpAll(() {
    mockAuthUseCase = MockAuthUseCase();
    context = MockBuildContext();
    container = ProviderContainer(
      overrides: [
        authViewModelProvider.overrideWith(
          (ref) => AuthViewModel(mockAuthUseCase),
        ),
      ],
    );
  });

  test('check for the inital state', () async{
    final authState = container.read(authViewModelProvider);
    expect(authState.isLoading, false);
    
  });

  test('login test with valid username and password', () async{
    when (mockAuthUseCase.loginStudent('sudip', 'sudip123'))
    .thenAnswer((_)=> Future.value((const Right(true))));

    await container
    .read(authViewModelProvider.notifier)
    .loginStudent(context, 'sudip', 'sudip123');
    final authState = container.read(authViewModelProvider);
    expect(authState.error, isNull);
  });

  test('check for Invalid username and password', () async{
    
   when (mockAuthUseCase.loginStudent('sudip', 'sudip1243'))
    .thenAnswer((_)=> Future.value(Left(Failure(error: 'Invalid'))));

    await container
    .read(authViewModelProvider.notifier)
    .loginStudent(context, 'sudip', 'sudip1243');
    final authState = container.read(authViewModelProvider);
    expect(authState.error, 'Invalid');
  });

  tearDown(() {
    container.dispose();
  });


}




