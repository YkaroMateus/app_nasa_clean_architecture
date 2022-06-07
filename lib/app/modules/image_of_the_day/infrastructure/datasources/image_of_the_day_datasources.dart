import 'package:nasa_app/app/modules/image_of_the_day/domain/entities/image_of_the_day.dart';
import 'package:nasa_app/app/modules/image_of_the_day/domain/entities/image_of_the_day_parameters.dart';

abstract class ImageOfTheDayDatasource {
  Future<ImageOfTheDay> call(ImageOfTheDayParameters parameters);
}
