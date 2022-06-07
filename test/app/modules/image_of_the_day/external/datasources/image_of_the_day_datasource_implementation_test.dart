import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_app/app/modules/image_of_the_day/domain/entities/image_of_the_day_parameters.dart';
import 'package:nasa_app/app/modules/image_of_the_day/external/datasources/image_of_the_day_datasource_implementation.dart';
import 'package:nasa_app/app/modules/image_of_the_day/infrastructure/errors/date_not_allowed_datasource_error.dart';
import 'package:nasa_app/app/modules/image_of_the_day/infrastructure/errors/image_of_the_day_datasource_error.dart';
import 'package:nasa_app/app/modules/image_of_the_day/infrastructure/models/image_of_the_day_model.dart';

import '../mocks/image_of_the_day_failure_response.dart';
import '../mocks/image_of_the_day_sucess_response.dart';

class DioMock extends Mock implements Dio {}

class RequestOptionsFake extends Fake implements RequestOptions {}

class OptionsFake extends Fake implements Options {}

class ImageOfTheDayParametersFake extends Fake implements ImageOfTheDayParameters {}

void main() {
  final dio = DioMock();
  final datasource = ImageOfTheDayDatasourceImplementation(dio);

  final parameters = ImageOfTheDayParameters(date: '2022-01-01');

  setUp(() {
    registerFallbackValue(OptionsFake());
    registerFallbackValue(ImageOfTheDayParametersFake());
  });

  test('Must return an ImageOfTheDay on status code 200', () async {
    when(() => dio.get(
          any(),
          queryParameters: any(named: 'queryParameters'),
          options: any(named: 'options'),
        )).thenAnswer((invocation) async => Response(
          statusCode: 200,
          data: imageOfTheDaySuccessResponse,
          requestOptions: RequestOptionsFake(),
        ));

    final result = await datasource(parameters);

    expect(result, isA<ImageOfTheDayModel>());
  });

  test('Must throw a DateNotAllowedDatasourceError on status code 400', () async {
    when(() => dio.get(
          any(),
          queryParameters: any(named: 'queryParameters'),
          options: any(named: 'options'),
        )).thenAnswer((invocation) async => Response(
          statusCode: 400,
          data: imageOfTheDayFailureResponse,
          requestOptions: RequestOptionsFake(),
        ));

    final result = datasource(parameters);

    expect(result, throwsA(isA<DateNotAllowedDatasourceError>()));
  });

  test('Must throw a ImageOfTheDayDatasourceError on any other status code', () async {
    when(() => dio.get(
          any(),
          queryParameters: any(named: 'queryParameters'),
          options: any(named: 'options'),
        )).thenAnswer((invocation) async => Response(
          statusCode: 500,
          data: {},
          requestOptions: RequestOptionsFake(),
        ));

    final result = datasource(parameters);

    expect(result, throwsA(isA<ImageOfTheDayDatasourceError>()));
  });

  test('Must throw a Exception on Dio error', () async {
    when(() => dio.get(
          any(),
          queryParameters: any(named: 'queryParameters'),
          options: any(named: 'options'),
        )).thenThrow(Exception());

    final result = datasource(parameters);

    expect(result, throwsA(isA<Exception>()));
  });
}
