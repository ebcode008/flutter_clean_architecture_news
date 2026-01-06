import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_01/core/error/failures.dart';
import 'package:flutter_clean_architecture_01/features/daily_news/domain/entities/article.dart';
import 'package:flutter_clean_architecture_01/features/daily_news/domain/use_cases/delete_article.dart';
import 'package:flutter_clean_architecture_01/features/daily_news/domain/use_cases/save_article.dart';

part 'article_detail_event.dart';
part 'article_detail_state.dart';

class ArticleDetailBloc extends Bloc<ArticleDetailEvent, ArticleDetailState> {
  final SaveArticleUseCase _saveArticleUseCase;
  final DeleteArticleUseCase _deleteArticleUseCase;

  ArticleDetailBloc(this._saveArticleUseCase, this._deleteArticleUseCase) : super(ArticleDetailLoading()) {
    on<InitArticleDetail>((event, emit) {
      emit(ArticleDetailLoaded(event.article));
    });

    on<OnSaveArticle>((event, emit) async {
      final resp = await _saveArticleUseCase(event.article);
      print(resp);
    });

    on<OnDeleteArticle>((event, emit) async {
      final resp = await _deleteArticleUseCase(event.article);
      print(resp);
    });
  }
}
