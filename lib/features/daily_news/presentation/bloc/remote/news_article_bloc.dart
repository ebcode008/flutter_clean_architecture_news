import 'package:flutter_clean_architecture_01/core/error/failures.dart';
import 'package:flutter_clean_architecture_01/features/daily_news/domain/entities/article.dart';
import 'package:flutter_clean_architecture_01/features/daily_news/domain/use_cases/get_news_article.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'news_article_event.dart';
part 'news_article_state.dart';

class NewsArticleBloc extends Bloc<NewsArticleEvent, NewsArticleState> {
  final GetNewsArticlesUseCase _getNewsArticleUseCase;

  NewsArticleBloc(this._getNewsArticleUseCase) : super(NewsArticleLoading()) {
    on<OnNewsArticleEvent>((event, emit) async {
      final resp = await _getNewsArticleUseCase.call();

      resp.fold((f) => emit(NewsArticleFailure(failure: f)), (a) => emit(NewsArticleLoaded(articles: a)));
    });
  }
}
