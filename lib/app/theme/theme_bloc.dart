import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_app/app/theme/theme_manager.dart';
import 'package:instagram_app/app/theme/theme_state.dart';

enum ThemeEvent { toggleDark, toggleLight }

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState.darkTheme) {
    on<ThemeEvent>((event, emit) {
      switch (event) {
        case ThemeEvent.toggleDark:
          emit(ThemeState.darkTheme);
          break;
        case ThemeEvent.toggleLight:
          emit(ThemeState.lightTheme);
          break;
      }
    });
  }

  ThemeState get currentTheme => state;
}
