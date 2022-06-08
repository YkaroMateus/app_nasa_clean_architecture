import 'package:dio/dio.dart';
import 'package:nasa_app/app/core/config/config.dart';
import 'package:nasa_app/app/modules/image_of_the_day/domain/entities/image_of_the_day_parameters.dart';
import 'package:nasa_app/app/modules/image_of_the_day/domain/entities/image_of_the_day.dart';
import 'package:nasa_app/app/modules/image_of_the_day/external/settings/image_of_the_day_settings.dart';
import 'package:nasa_app/app/modules/image_of_the_day/infrastructure/datasources/image_of_the_day_datasources.dart';
import 'package:nasa_app/app/modules/image_of_the_day/infrastructure/errors/date_not_allowed_datasource_error.dart';
import 'package:nasa_app/app/modules/image_of_the_day/infrastructure/errors/image_of_the_day_datasource_error.dart';
import 'package:nasa_app/app/modules/image_of_the_day/infrastructure/models/image_of_the_day_model.dart';
import 'package:nasa_app/app/modules/image_of_the_day/infrastructure/models/image_of_the_day_parameters_model.dart';
import '../../../../secrets.dart';

class ImageOfTheDayDatasourceImplementation implements ImageOfTheDayDatasource {
  final Dio dio;

  ImageOfTheDayDatasourceImplementation(this.dio);

  @override
  Future<ImageOfTheDay> call(ImageOfTheDayParameters parameters) async {
    final result = await dio.get(
      '${Config.baseUrl}${ImageOfTheDaySettings.endpoint}',
      queryParameters: ImageOfTheDayParametersModel.toJson(parameters, Secrets.apiKey),
      options: Options(validateStatus: (status) => true),
    );

    if (result.statusCode == 200) {
      return ImageOfTheDayModel.fromJson(result.data);
    } else if (result.statusCode == 400) {
      throw DateNotAllowedDatasourceError(result.data['msg'] ?? 'Data não permitida');
    } else {
      throw ImageOfTheDayDatasourceError('Ocorreu um erro interno.');
    }
  }
}
