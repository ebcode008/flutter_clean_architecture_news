import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_01/core/error/failures.dart';
import 'package:flutter_clean_architecture_01/features/daily_news/domain/entities/article.dart';
import 'package:flutter_clean_architecture_01/features/daily_news/domain/repository/article_repository.dart';

class SaveArticleUseCase {
  final ArticleRepository articleRepository;

  SaveArticleUseCase(this.articleRepository);

  Future<Either<Failure, bool>> call(Article article) async {
    return await articleRepository.saveArticle(article);
  }
}
