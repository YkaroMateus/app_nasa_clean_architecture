import 'package:nasa_app/app/core/failures/generic_failure.dart';
import 'package:nasa_app/app/modules/image_of_the_day/domain/entities/image_of_the_day_parameters.dart';
import 'package:nasa_app/app/modules/image_of_the_day/domain/entities/image_of_the_day.dart';
import 'package:nasa_app/app/core/failures/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:nasa_app/app/modules/image_of_the_day/domain/failures/date_not_allowed_failure.dart';
import 'package:nasa_app/app/modules/image_of_the_day/domain/failures/image_of_the_day_failure.dart';
import 'package:nasa_app/app/modules/image_of_the_day/domain/repositories/image_of_the_day_repository.dart';
import 'package:nasa_app/app/modules/image_of_the_day/infrastructure/datasources/image_of_the_day_datasources.dart';
import 'package:nasa_app/app/modules/image_of_the_day/infrastructure/errors/date_not_allowed_datasource_error.dart';
import 'package:nasa_app/app/modules/image_of_the_day/infrastructure/errors/image_of_the_day_datasource_error.dart';

class ImageOfTheDayRepositoryImplementation implements ImageOfTheDayRepository {
  final ImageOfTheDayDatasource datasource;

  ImageOfTheDayRepositoryImplementation(this.datasource);

  @override
  Future<Either<Failure, ImageOfTheDay>> call(ImageOfTheDayParameters parameters) async {
    try {
      return Right(await datasource(parameters));
    } on ImageOfTheDayDatasourceError catch (error) {
      return Left(ImageOfTheDayFailure(error.message));
    } on DateNotAllowedDatasourceError catch (error) {
      return Left(DateNotAllowedFailure(error.message));
    } on Exception {
      return Left(GenericFailure('Houve um erro Interno'));
    }
  }
}
