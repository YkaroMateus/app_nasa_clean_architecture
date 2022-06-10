import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:nasa_app/app/modules/image_of_the_day/presentation/blocs/get_image_of_the_day_bloc/events/select_date_event.dart';
import 'package:nasa_app/app/modules/image_of_the_day/presentation/blocs/get_image_of_the_day_bloc/states/date_not_allowed_failure_state.dart';
import 'package:nasa_app/app/modules/image_of_the_day/presentation/blocs/get_image_of_the_day_bloc/states/get_image_of_the_day_loading_state.dart';
import '../../domain/entities/image_of_the_day_parameters.dart';
import '../blocs/get_image_of_the_day_bloc/events/get_image_of_the_day_event.dart';
import '../blocs/get_image_of_the_day_bloc/get_image_of_the_day_bloc.dart';
import '../blocs/get_image_of_the_day_bloc/states/get_image_of_the_day_success_state.dart';
import '../blocs/get_image_of_the_day_bloc/states/image_of_the_day_failure_state.dart';
import '../blocs/get_image_of_the_day_bloc/states/image_of_the_day_states.dart';

class ImageOftheDayHomePage extends StatefulWidget {
  const ImageOftheDayHomePage();

  @override
  State<ImageOftheDayHomePage> createState() => _ImageOftheDayHomePageState();
}

class _ImageOftheDayHomePageState extends State<ImageOftheDayHomePage> {
  final imageOfTheDayBloc = Modular.get<GetImageOfTheDayBloc>();

  @override
  void initState() {
    imageOfTheDayBloc.add(GetImageOfTheDayEvent(ImageOfTheDayParameters(date: '')));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.blue,
              ),
              title: Text(
                'Home Page',
                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 16),
              ),
              onTap: () {
                Navigator.pop(context);
                imageOfTheDayBloc.add(GetImageOfTheDayEvent(ImageOfTheDayParameters(date: '')));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.arrow_back,
                color: Colors.red,
              ),
              title: Text(
                'Sair',
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16),
              ),
              onTap: () {
                exit(0);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.red),
        title: Image.network(
            'https://turbologo.com/articles/wp-content/uploads/2019/08/NASA%E2%80%99s-meatball.png',
            height: 135),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/space.jpg'), fit: BoxFit.cover),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                BlocConsumer<GetImageOfTheDayBloc, ImageOfTheDayStates>(
                  bloc: imageOfTheDayBloc,
                  listener: (context, state) {
                    if (state is ImageOfTheDayFailureState) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(
                            'ERROR:(\n\nDesculpe,\nOcorreu um Erro Interno!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          alignment: Alignment.center,
                          backgroundColor: Colors.red,
                          actionsAlignment: MainAxisAlignment.center,
                          actions: [
                            TextButton(
                              style: ButtonStyle(alignment: Alignment.center),
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                'OK',
                                textAlign: TextAlign.center,
                                style:
                                    TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            TextButton(
                              style: ButtonStyle(alignment: Alignment.center),
                              onPressed: () {
                                imageOfTheDayBloc
                                    .add(GetImageOfTheDayEvent(ImageOfTheDayParameters(date: '')));
                              },
                              child: Text(
                                'Tentar Novamente',
                                textAlign: TextAlign.center,
                                style:
                                    TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      );
                    }
                    if (state is DateNotAllowedFailureState) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(
                            'ERROR :( \n\nSorry,\n${state.failure.message}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          alignment: Alignment.center,
                          backgroundColor: Colors.red,
                          actionsAlignment: MainAxisAlignment.center,
                          actions: [
                            TextButton(
                              style: ButtonStyle(alignment: Alignment.center),
                              onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
                              child: Text(
                                'OK',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is GetImageOfTheDayLoadingState) {
                      return CircularProgressIndicator(
                        backgroundColor: Colors.blue,
                        color: Colors.red,
                      );
                    } else if (state is GetImageOfTheDaySuccessState) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
                            child: Card(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  '" ${state.imageOfTheDay.title} "',
                                  style:
                                      TextStyle(color: Colors.red, fontSize: 24, fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          InteractiveViewer(
                            child: Image.network(
                              state.imageOfTheDay.image,
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return Center(child: child);
                                }
                                return Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                                    child: LinearProgressIndicator(
                                      color: Colors.red,
                                      backgroundColor: Colors.blue,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Card(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                                child: TextButton.icon(
                                  onPressed: (() async {
                                    final date = await showDatePicker(
                                      builder: (context, child) {
                                        return Theme(
                                          child: child!,
                                          data: ThemeData.light().copyWith(
                                            primaryColor: Colors.red,
                                            colorScheme: ColorScheme.light(primary: Colors.red),
                                          ),
                                        );
                                      },
                                      context: context,
                                      initialDate: imageOfTheDayBloc.selectDate,
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime.now(),
                                    );

                                    if (date != null) {
                                      imageOfTheDayBloc.add(SelectDateEvent(date));
                                      imageOfTheDayBloc.add(
                                        GetImageOfTheDayEvent(
                                          ImageOfTheDayParameters(
                                              date: DateFormat('yyyy-MM-dd').format(date)),
                                        ),
                                      );
                                    }
                                  }),
                                  icon: Icon(
                                    Icons.rocket,
                                    size: 40,
                                    color: Colors.red,
                                  ),
                                  label: Text(
                                    '${DateFormat('dd/MM/yyyy').format(imageOfTheDayBloc.selectDate)}',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 1, 18, 163)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: Card(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Text(
                                  state.imageOfTheDay.description,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          state.imageOfTheDay.copyright != ''
                              ? Card(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      'Copyright© ${state.imageOfTheDay.copyright}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                              : SizedBox(),
                          SizedBox(
                            width: 60,
                            height: 60,
                          ),
                        ],
                      );
                    }
                    return SizedBox();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () async {
          final date = await showDatePicker(
            builder: (context, child) {
              return Theme(
                child: child!,
                data: ThemeData.light().copyWith(
                  primaryColor: Colors.red,
                  colorScheme: ColorScheme.light(primary: Colors.red),
                ),
              );
            },
            context: context,
            initialDate: imageOfTheDayBloc.selectDate,
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );

          if (date != null) {
            imageOfTheDayBloc.add(SelectDateEvent(date));
            imageOfTheDayBloc.add(
              GetImageOfTheDayEvent(
                ImageOfTheDayParameters(date: DateFormat('yyyy-MM-dd').format(date)),
              ),
            );
          }
        },
        child: Icon(
          Icons.calendar_month,
          size: 40,
          color: Colors.white,
        ),
      ),
    );
  }
}
