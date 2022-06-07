import 'package:nasa_app/app/modules/image_of_the_day/domain/entities/image_of_the_day_parameters.dart';

class ImageOfTheDayParametersModel extends ImageOfTheDayParameters {
  final String date;

  ImageOfTheDayParametersModel({required this.date}) : super(date: date);

  static Map<String, dynamic> toJson(ImageOfTheDayParameters parameters, String apiKey) {
    return {
      "api_key": apiKey,
      "date": parameters.date,
    };
  }
}
