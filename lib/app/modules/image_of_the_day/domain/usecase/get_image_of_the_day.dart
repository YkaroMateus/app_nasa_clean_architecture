import 'package:dartz/dartz.dart';
import 'package:nasa_app/app/core/failures/failure.dart';
import 'package:nasa_app/app/modules/image_of_the_day/domain/entities/image_of_the_day.dart';
import 'package:nasa_app/app/modules/image_of_the_day/domain/entities/image_of_the_day_parameters.dart';
import 'package:nasa_app/app/modules/image_of_the_day/domain/repositories/image_of_the_day_repository.dart';

abstract class GetImageOfTheDay {
  Future<Either<Failure, ImageOfTheDay>> call(ImageOfTheDayParameters parameters);
}

class GetImageOfTheDayImplementation implements GetImageOfTheDay {
  final ImageOfTheDayRepository repository;

  GetImageOfTheDayImplementation(this.repository);

  @override
  Future<Either<Failure, ImageOfTheDay>> call(ImageOfTheDayParameters parameters) async {
    return await repository(parameters);
  }
}
