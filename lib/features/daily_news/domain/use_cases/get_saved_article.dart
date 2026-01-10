import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_01/core/error/failures.dart';
import 'package:flutter_clean_architecture_01/features/daily_news/domain/entities/article.dart';
import 'package:flutter_clean_architecture_01/features/daily_news/domain/repository/article_repository.dart';

class GetSavedArticleUseCase {
  final ArticleRepository repository;

  GetSavedArticleUseCase(this.repository);

  Future<Either<Failure, Article>> call(String title) async {
    return await repository.getSavedArticle(title);
  }
}
