import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_app/app/modules/image_of_the_day/domain/entities/image_of_the_day.dart';
import 'package:nasa_app/app/modules/image_of_the_day/domain/entities/image_of_the_day_parameters.dart';
import 'package:nasa_app/app/modules/image_of_the_day/domain/failures/date_not_allowed_failure.dart';
import 'package:nasa_app/app/modules/image_of_the_day/domain/failures/image_of_the_day_failure.dart';
import 'package:nasa_app/app/modules/image_of_the_day/domain/repositories/image_of_the_day_repository.dart';
import 'package:nasa_app/app/modules/image_of_the_day/domain/usecase/get_image_of_the_day.dart';

class ImageOfTheDayRepositoryMock extends Mock implements ImageOfTheDayRepository {}

class ImageOfTheDayFake extends Fake implements ImageOfTheDay {}

class ImageOfTheDayParametersFake extends Fake implements ImageOfTheDayParameters {}

void main() {
  setUp(() {
    registerFallbackValue(ImageOfTheDayParametersFake());
  });

  final repository = ImageOfTheDayRepositoryMock();
  final usecase = GetImageOfTheDayImplementation(repository);

  final parameters = ImageOfTheDayParameters(date: '2022-01-01');

  test('Must return an ImageOfTheDay entity on success', () async {
    when(() => repository(any())).thenAnswer((invocation) async => Right(ImageOfTheDayFake()));

    final result = await usecase(parameters);

    expect(result.fold(id, id), isA<ImageOfTheDay>());
  });

  test('Must return an ImageOfTheDayFailure failure on error', () async {
    when(() => repository(any())).thenAnswer((invocation) async => Left(ImageOfTheDayFailure('error')));

    final result = await usecase(parameters);

    expect(result.fold(id, id), isA<ImageOfTheDayFailure>());
  });

  test('Must return an DateNotAllowedFailure failure on error', () async {
    when(() => repository(any())).thenAnswer((invocation) async => Left(DateNotAllowedFailure('error')));

    final result = await usecase(parameters);

    expect(result.fold(id, id), isA<DateNotAllowedFailure>());
  });
}
