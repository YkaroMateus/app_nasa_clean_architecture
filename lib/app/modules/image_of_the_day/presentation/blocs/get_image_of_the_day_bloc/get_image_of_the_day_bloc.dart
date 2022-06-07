import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nasa_app/app/modules/image_of_the_day/domain/failures/date_not_allowed_failure.dart';
import 'package:nasa_app/app/modules/image_of_the_day/domain/failures/image_of_the_day_failure.dart';
import 'package:nasa_app/app/modules/image_of_the_day/domain/usecase/get_image_of_the_day.dart';
import 'package:nasa_app/app/modules/image_of_the_day/presentation/blocs/get_image_of_the_day_bloc/events/image_of_the_day_events.dart';
import 'package:nasa_app/app/modules/image_of_the_day/presentation/blocs/get_image_of_the_day_bloc/states/date_not_allowed_failure_state.dart';
import 'package:nasa_app/app/modules/image_of_the_day/presentation/blocs/get_image_of_the_day_bloc/states/get_image_of_the_day_loading_state.dart';
import 'package:nasa_app/app/modules/image_of_the_day/presentation/blocs/get_image_of_the_day_bloc/states/image_of_the_day_states.dart';
import 'package:nasa_app/app/modules/image_of_the_day/presentation/blocs/get_image_of_the_day_bloc/states/get_image_of_the_day_success_state.dart';
import 'package:nasa_app/app/modules/image_of_the_day/presentation/blocs/get_image_of_the_day_bloc/states/image_of_the_day_failure_state.dart';
import 'package:nasa_app/app/modules/image_of_the_day/presentation/blocs/get_image_of_the_day_bloc/states/select_date_sucess_state.dart';
import '../../../domain/entities/image_of_the_day.dart';
import 'events/get_image_of_the_day_event.dart';
import 'events/select_date_event.dart';
import 'states/select_date_loading_state.dart';

class GetImageOfTheDayBloc extends Bloc<ImageOfTheDayEvents, ImageOfTheDayStates> implements Disposable {
  final GetImageOfTheDay usecase;

  GetImageOfTheDayBloc(this.usecase) : super(GetImageOfTheDayLoadingState()) {
    on<GetImageOfTheDayEvent>(_mapGetImageOfTheDayEventToState);
    on<SelectDateEvent>(_mapSelectDateEventToState);
  }
  DateTime selectDate = DateTime.now();

  ImageOfTheDay imageOfTheDay = ImageOfTheDay(
    copyright: '',
    date: '',
    description: '',
    image: '',
    mediaType: '',
    title: '',
  );

  @override
  void dispose() {
    close();
  }

  void _mapGetImageOfTheDayEventToState(
      GetImageOfTheDayEvent event, Emitter<ImageOfTheDayStates> emit) async {
    emit(GetImageOfTheDayLoadingState());

    final result = await usecase(event.parameters);

    result.fold(
      (l) {
        switch (l.runtimeType) {
          case DateNotAllowedFailure:
            emit(DateNotAllowedFailureState(l as DateNotAllowedFailure));
            break;
          case ImageOfTheDayFailure:
            emit(ImageOfTheDayFailureState(l as ImageOfTheDayFailure));
            break;
        }
      },
      (r) => emit(GetImageOfTheDaySuccessState(r)),
    );
  }

  void _mapSelectDateEventToState(SelectDateEvent event, Emitter<ImageOfTheDayStates> emit) {
    emit(SelectDateLoadingState());

    selectDate = event.date;

    emit(SelectDateSuccessState());
  }
}
