import 'package:nasa_app/app/modules/image_of_the_day/domain/entities/image_of_the_day_parameters.dart';
import 'package:nasa_app/app/modules/image_of_the_day/presentation/blocs/get_image_of_the_day_bloc/events/image_of_the_day_events.dart';

class GetImageOfTheDayEvent implements ImageOfTheDayEvents {
  final ImageOfTheDayParameters parameters;

  GetImageOfTheDayEvent(this.parameters);
}
