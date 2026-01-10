import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_01/core/error/failures.dart';
import 'package:flutter_clean_architecture_01/features/daily_news/domain/entities/article.dart';
import 'package:flutter_clean_architecture_01/features/daily_news/domain/use_cases/delete_article.dart';
import 'package:flutter_clean_architecture_01/features/daily_news/domain/use_cases/get_saved_article.dart';
import 'package:flutter_clean_architecture_01/features/daily_news/domain/use_cases/save_article.dart';

part 'article_detail_event.dart';
part 'article_detail_state.dart';

class ArticleDetailBloc extends Bloc<ArticleDetailEvent, ArticleDetailState> {
  final SaveArticleUseCase _saveArticleUseCase;
  final DeleteArticleUseCase _deleteArticleUseCase;
  final GetSavedArticleUseCase _getSavedArticleUseCase;

  ArticleDetailBloc(this._saveArticleUseCase, this._deleteArticleUseCase, this._getSavedArticleUseCase)
    : super(ArticleDetailLoading()) {
    on<InitArticleDetail>((event, emit) async {
      final resp = await _getSavedArticleUseCase(event.article.title ?? '');
      resp.fold((f) => emit(ArticleDetailLoaded(event.article)), (a) => emit(ArticleDetailLoaded(a)));
    });

    on<OnSaveArticle>((event, emit) async {
      var newArticle = event.article.copyWith(favorite: true);
      final resp = await _saveArticleUseCase(newArticle);
      resp.fold((f) => emit(ArticleDetailFailure(failure: f)), (a) => emit(ArticleDetailLoaded(newArticle)));
    });

    on<OnDeleteArticle>((event, emit) async {
      var newArticle = event.article.copyWith(favorite: false);
      final resp = await _deleteArticleUseCase(newArticle);
      resp.fold((f) => emit(ArticleDetailFailure(failure: f)), (a) => emit(ArticleDetailLoaded(newArticle)));
    });
  }
}
