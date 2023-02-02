import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

import 'package:anime_quotes_bloc/models/models.dart';
import 'package:anime_quotes_bloc/repositories/quote_api_client.dart';
import 'package:anime_quotes_bloc/repositories/repository.dart';

part 'quote_event.dart';
part 'quote_state.dart';

class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {
  QuoteBloc() : super(QuoteEmpty());

  QuoteState get initialState => QuoteEmpty();

  @override
  Stream<QuoteState> mapEventToState(QuoteEvent event) async* {
    final QuoteRepository repository =
        QuoteRepository(quoteAPIClient: QuoteAPIClient(client: http.Client()));

    if (event is FetchQuote) {
      emit(QuoteLoading());

      try {
        final Quote quote = await repository.fetchQuote();
        emit(QuoteLoaded(quote: quote));
      } catch (error) {
        emit(QuoteError());
      }
    }
  }
}
