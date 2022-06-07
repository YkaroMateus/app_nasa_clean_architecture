import 'package:nasa_app/app/modules/image_of_the_day/infrastructure/errors/image_of_the_day_datasource_errors.dart';

class ImageOfTheDayDatasourceError implements ImageOfTheDayDatasourceErrors {
  final String message;

  ImageOfTheDayDatasourceError(this.message);
}
