import 'package:flutter_clean_architecture_01/features/daily_news/data/data_sources/local/article_local.dart';
import 'package:flutter_clean_architecture_01/features/daily_news/data/data_sources/remote/article_remote.dart';
import 'package:flutter_clean_architecture_01/features/daily_news/data/repository/article_repository_impl.dart';
import 'package:flutter_clean_architecture_01/features/daily_news/domain/repository/article_repository.dart';
import 'package:flutter_clean_architecture_01/features/daily_news/domain/use_cases/delete_article.dart';
import 'package:flutter_clean_architecture_01/features/daily_news/domain/use_cases/get_news_article.dart';
import 'package:flutter_clean_architecture_01/features/daily_news/domain/use_cases/get_saved_article.dart';
import 'package:flutter_clean_architecture_01/features/daily_news/domain/use_cases/get_saved_articles.dart';
import 'package:flutter_clean_architecture_01/features/daily_news/domain/use_cases/save_article.dart';
import 'package:flutter_clean_architecture_01/features/daily_news/presentation/bloc/local/saved_article_bloc.dart';
import 'package:flutter_clean_architecture_01/features/daily_news/presentation/bloc/remote/article_detail_bloc.dart';
import 'package:flutter_clean_architecture_01/features/daily_news/presentation/bloc/remote/news_article_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  //Blocs
  getIt.registerFactory(() => NewsArticleBloc(getIt()));
  getIt.registerFactory(() => SavedArticleBloc(getIt()));
  getIt.registerFactory(() => ArticleDetailBloc(getIt(), getIt(), getIt()));

  //UseCases
  getIt.registerLazySingleton(() => SaveArticleUseCase(getIt()));
  getIt.registerLazySingleton(() => DeleteArticleUseCase(getIt()));
  getIt.registerLazySingleton(() => GetNewsArticlesUseCase(getIt()));
  getIt.registerLazySingleton(() => GetSavedArticlesUseCase(getIt()));
  getIt.registerLazySingleton(() => GetSavedArticleUseCase(getIt()));

  //Repository
  getIt.registerLazySingleton<ArticleRepository>(
    () => ArticleRepositoryImpl(articleRemoteDataSource: getIt(), articleLocalDataSource: getIt()),
  );

  //DataSources
  getIt.registerLazySingleton<ArticleLocalDataSource>(() => ArticleLocalDataSourceImpl());
  getIt.registerLazySingleton<ArticleRemoteDataSource>(() => ArticleRemoteDataSourceImpl());
}
