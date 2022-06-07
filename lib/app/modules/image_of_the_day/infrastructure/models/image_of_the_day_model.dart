import 'package:nasa_app/app/modules/image_of_the_day/domain/entities/image_of_the_day.dart';

class ImageOfTheDayModel extends ImageOfTheDay {
  final String copyright;
  final String date;
  final String description;
  final String image;
  final String mediaType;
  final String title;

  ImageOfTheDayModel({
    required this.copyright,
    required this.date,
    required this.description,
    required this.image,
    required this.mediaType,
    required this.title,
  }) : super(
          copyright: copyright,
          date: date,
          description: description,
          image: image,
          mediaType: mediaType,
          title: title,
        );

  static ImageOfTheDayModel fromJson(Map<String, dynamic> json) {
    return ImageOfTheDayModel(
      copyright: json['copyright'] ?? '',
      date: json['date'] ?? '',
      description: json['explanation'] ?? '',
      image: json['hdurl'] ?? '',
      mediaType: json['media_type'] ?? '',
      title: json['title'] ?? '',
    );
  }
}
