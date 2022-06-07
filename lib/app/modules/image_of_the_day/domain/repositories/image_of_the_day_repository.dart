import 'package:dartz/dartz.dart';
import 'package:nasa_app/app/core/failures/failure.dart';
import 'package:nasa_app/app/modules/image_of_the_day/domain/entities/image_of_the_day.dart';
import 'package:nasa_app/app/modules/image_of_the_day/domain/entities/image_of_the_day_parameters.dart';

abstract class ImageOfTheDayRepository {
  Future<Either<Failure, ImageOfTheDay>> call(ImageOfTheDayParameters parameters);
}