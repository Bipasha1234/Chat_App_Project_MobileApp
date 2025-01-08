// onboarding_bloc.dart
import 'package:bloc/bloc.dart';

import 'onboarding_event.dart';
import 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(OnboardingInitial()) {
    on<OnboardingPageChangedEvent>((event, emit) {
      emit(OnboardingPageChanged(event.pageIndex));
    });
  }
}
