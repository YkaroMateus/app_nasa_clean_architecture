import 'package:nasa_app/app/core/failures/failure.dart';

class GenericFailure implements Failure {
  final String message;

  GenericFailure(this.message);
}
