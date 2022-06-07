import 'package:nasa_app/app/modules/image_of_the_day/presentation/blocs/get_image_of_the_day_bloc/events/image_of_the_day_events.dart';

class SelectDateEvent implements ImageOfTheDayEvents {
  final DateTime date;

  SelectDateEvent(this.date);
}
