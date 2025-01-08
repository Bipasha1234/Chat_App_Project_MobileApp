// onboarding_state.dart
import 'package:equatable/equatable.dart';

abstract class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object> get props => [];
}

class OnboardingInitial extends OnboardingState {}

class OnboardingPageChanged extends OnboardingState {
  final int currentPageIndex;

  const OnboardingPageChanged(this.currentPageIndex);

  @override
  List<Object> get props => [currentPageIndex];
}
