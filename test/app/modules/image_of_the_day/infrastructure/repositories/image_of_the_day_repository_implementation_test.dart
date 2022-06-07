import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_app/app/core/failures/generic_failure.dart';
import 'package:nasa_app/app/modules/image_of_the_day/domain/entities/image_of_the_day.dart';
import 'package:nasa_app/app/modules/image_of_the_day/domain/entities/image_of_the_day_parameters.dart';
import 'package:nasa_app/app/modules/image_of_the_day/domain/failures/date_not_allowed_failure.dart';
import 'package:nasa_app/app/modules/image_of_the_day/domain/failures/image_of_the_day_failure.dart';
import 'package:nasa_app/app/modules/image_of_the_day/infrastructure/datasources/image_of_the_day_datasources.dart';
import 'package:nasa_app/app/modules/image_of_the_day/infrastructure/errors/date_not_allowed_datasource_error.dart';
import 'package:nasa_app/app/modules/image_of_the_day/infrastructure/errors/image_of_the_day_datasource_error.dart';
import 'package:nasa_app/app/modules/image_of_the_day/infrastructure/repositories/image_of_the_day_repository_implementation.dart';

class ImageOfTheDayDatasourceMock extends Mock implements ImageOfTheDayDatasource {}

class ImageOfTheDayFake extends Fake implements ImageOfTheDay {}

class ImageOfTheDayParametersFake extends Fake implements ImageOfTheDayParameters {}

void main() {
  setUp(() {
    registerFallbackValue(ImageOfTheDayParametersFake());
  });

  final datasource = ImageOfTheDayDatasourceMock();
  final repository = ImageOfTheDayRepositoryImplementation(datasource);

  final parameters = ImageOfTheDayParameters(date: '2022-01-01');

  test('Must return an ImageOfTheDay on success', () async {
    when(() => datasource(any())).thenAnswer((invocation) async => ImageOfTheDayFake());

    final result = await repository(parameters);

    expect(result.fold(id, id), isA<ImageOfTheDay>());
  });

  test('Must return an ImageOfTheDayFailure on ImageOfTheDayDatasourceError', () async {
    when(() => datasource(any())).thenThrow(ImageOfTheDayDatasourceError('error'));

    final result = await repository(parameters);

    expect(result.fold(id, id), isA<ImageOfTheDayFailure>());
  });

  test('Must return an DateNotAllowedFailure on DateNotAllowedDatasourceError', () async {
    when(() => datasource(any())).thenThrow(DateNotAllowedDatasourceError('error'));

    final result = await repository(parameters);

    expect(result.fold(id, id), isA<DateNotAllowedFailure>());
  });

  test('Must return an GenericFailure on Exception', () async {
    when(() => datasource(any())).thenThrow(Exception());

    final result = await repository(parameters);

    expect(result.fold(id, id), isA<GenericFailure>());
  });
}
