part of 'quote_bloc.dart';

abstract class QuoteEvent extends Equatable {
  const QuoteEvent();

  @override
  List<Object> get props => [];
}

class FetchQuote extends QuoteEvent {
  const FetchQuote();

  @override
  List<Object> get props => [];
}
