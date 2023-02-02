part of 'quote_bloc.dart';

abstract class QuoteState extends Equatable {
  const QuoteState();

  @override
  List<Object> get props => [];
}

class QuoteEmpty extends QuoteState {}

class QuoteLoading extends QuoteState {}

class QuoteError extends QuoteState {}

class QuoteLoaded extends QuoteState {
  final Quote quote;

  const QuoteLoaded({required this.quote});

  //* This will transfer this.quote's toString method to onTransition void
  @override
  List<Object> get props => [quote];
}

class QuoteInitial extends QuoteState {}
