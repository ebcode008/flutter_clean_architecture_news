import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_01/core/error/failures.dart';
import 'package:flutter_clean_architecture_01/features/daily_news/domain/entities/article.dart';
import 'package:flutter_clean_architecture_01/features/daily_news/domain/use_cases/get_saved_articles.dart';

part 'saved_article_event.dart';
part 'saved_article_state.dart';

class SavedArticleBloc extends Bloc<SavedArticleEvent, SavedArticleState> {
  final GetSavedArticlesUseCase _getSavedArticlesUseCase;

  SavedArticleBloc(this._getSavedArticlesUseCase) : super(SavedArticleLoading()) {
    on<OnSavedArticleEvent>((event, emit) async {
      final resp = await _getSavedArticlesUseCase.call();

      resp.fold((f) => emit(SavedArticleFailure(failure: f)), (a) => emit(SavedArticleLoaded(articles: a)));
    });

    add(OnSavedArticleEvent());
  }
}
