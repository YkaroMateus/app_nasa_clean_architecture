import 'package:flutter_modular/flutter_modular.dart';
import 'package:nasa_app/app/modules/image_of_the_day/presentation/pages/image_of_the_day_home_page.dart';
import 'domain/usecase/get_image_of_the_day.dart';
import 'external/datasources/image_of_the_day_datasource_implementation.dart';
import 'infrastructure/repositories/image_of_the_day_repository_implementation.dart';
import 'presentation/blocs/get_image_of_the_day_bloc/get_image_of_the_day_bloc.dart';

class ImageOfTheDayModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => GetImageOfTheDayImplementation(i())),
    Bind((i) => ImageOfTheDayRepositoryImplementation(i())),
    Bind((i) => ImageOfTheDayDatasourceImplementation(i())),
    Bind((i) => GetImageOfTheDayBloc(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute("/", child: (context, args) => ImageOftheDayHomePage()),
  ];
}
