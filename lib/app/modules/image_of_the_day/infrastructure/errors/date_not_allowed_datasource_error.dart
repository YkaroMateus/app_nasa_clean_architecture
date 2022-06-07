import 'package:nasa_app/app/modules/image_of_the_day/infrastructure/errors/image_of_the_day_datasource_errors.dart';

class DateNotAllowedDatasourceError implements ImageOfTheDayDatasourceErrors {
  final String message;

  DateNotAllowedDatasourceError(this.message);
}
