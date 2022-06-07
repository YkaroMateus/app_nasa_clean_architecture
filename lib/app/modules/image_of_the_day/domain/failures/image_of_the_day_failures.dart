import 'package:nasa_app/app/core/failures/failure.dart';

abstract class ImageOfTheDayFailures implements Failure {
  final String message;

  ImageOfTheDayFailures(this.message);
}