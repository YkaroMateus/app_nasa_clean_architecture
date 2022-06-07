import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_app/app/modules/image_of_the_day/domain/entities/image_of_the_day.dart';
import 'package:nasa_app/app/modules/image_of_the_day/domain/entities/image_of_the_day_parameters.dart';
import 'package:nasa_app/app/modules/image_of_the_day/domain/failures/date_not_allowed_failure.dart';
import 'package:nasa_app/app/modules/image_of_the_day/domain/failures/image_of_the_day_failure.dart';
import 'package:nasa_app/app/modules/image_of_the_day/domain/usecase/get_image_of_the_day.dart';
import 'package:nasa_app/app/modules/image_of_the_day/presentation/blocs/get_image_of_the_day_bloc/events/get_image_of_the_day_event.dart';
import 'package:nasa_app/app/modules/image_of_the_day/presentation/blocs/get_image_of_the_day_bloc/get_image_of_the_day_bloc.dart';
import 'package:nasa_app/app/modules/image_of_the_day/presentation/blocs/get_image_of_the_day_bloc/states/date_not_allowed_failure_state.dart';
import 'package:nasa_app/app/modules/image_of_the_day/presentation/blocs/get_image_of_the_day_bloc/states/get_image_of_the_day_loading_state.dart';
import 'package:nasa_app/app/modules/image_of_the_day/presentation/blocs/get_image_of_the_day_bloc/states/get_image_of_the_day_success_state.dart';
import 'package:nasa_app/app/modules/image_of_the_day/presentation/blocs/get_image_of_the_day_bloc/states/image_of_the_day_failure_state.dart';

class GetImageOfTheDayMock extends Mock implements GetImageOfTheDay {}

class ImageOfTheDayParametersFake extends Fake implements ImageOfTheDayParameters {}

class ImageOfTheDayFake extends Fake implements ImageOfTheDay {}

void main() {
  final usecase = GetImageOfTheDayMock();
  final bloc = GetImageOfTheDayBloc(usecase);

  setUp(() {
    registerFallbackValue(ImageOfTheDayParametersFake());
  });

  final parameters = ImageOfTheDayParameters(date: '2022-05-27');

  test('Must emit all states in order on success', () {
    when(() => usecase(any())).thenAnswer((invocation) async => Right(ImageOfTheDayFake()));

    bloc.add(GetImageOfTheDayEvent(parameters));

    expect(
        bloc.stream,
        emitsInOrder([
          isA<GetImageOfTheDayLoadingState>(),
          isA<GetImageOfTheDaySuccessState>(),
        ]));
  });

  test('Must emit all states in order on DateNotAllowedFailure failure', () {
    when(() => usecase(any())).thenAnswer((invocation) async => Left(DateNotAllowedFailure('')));

    bloc.add(GetImageOfTheDayEvent(parameters));

    expect(
        bloc.stream,
        emitsInOrder([
          isA<GetImageOfTheDayLoadingState>(),
          isA<DateNotAllowedFailureState>(),
        ]));
  });

  test('Must emit all states in order on ImageOfTheDayFailure failure', () {
    when(() => usecase(any())).thenAnswer((invocation) async => Left(ImageOfTheDayFailure('')));

    bloc.add(GetImageOfTheDayEvent(parameters));

    expect(
        bloc.stream,
        emitsInOrder([
          isA<GetImageOfTheDayLoadingState>(),
          isA<ImageOfTheDayFailureState>(),
        ]));
  });
}
