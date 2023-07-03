import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_and_api_for_class/features/auth/domain/use_case/auth_usecase.dart';
import 'package:hive_and_api_for_class/features/batch/domain/entity/batch_entity.dart';
import 'package:hive_and_api_for_class/features/batch/domain/use_case/batch_use_case.dart';
import 'package:hive_and_api_for_class/features/course/domain/entity/course_entity.dart';
import 'package:hive_and_api_for_class/features/course/domain/use_case/course_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../test_data/batch_entity_test.dart';
import '../../../../test_data/course_entity_test.dart';
import '../../../../unti_test/auth_test.mocks.dart';
import 'login_view_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<BatchUseCase>(),
  MockSpec<CourseUseCase>(),
])
void main() {
  late AuthUseCase mockAuthUseCase;
  late BatchUseCase mockBatchUseCase;
  late CourseUseCase mockCourseUseCase;
  late List<BatchEntity> lstBatchEntity;
  late List<CourseEntity> lstCourseEntity;
  late bool isLogin;

  setUpAll(() async {
    mockBatchUseCase = MockBatchUseCase();
    mockAuthUseCase = MockAuthUseCase();
    mockCourseUseCase = MockCourseUseCase();
    lstBatchEntity = await getBatchListTest();
    lstCourseEntity = await getCourseListTest();
    isLogin = true;
  });
  testWidgets('login view ...', (WidgetTester tester) async {
   when(mockAuthUseCase.loginStudent('sudip', 'sudip123'))
   .thenAnswer((_) async => Right(isLogin) );
   
  });
}
