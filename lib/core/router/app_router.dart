import 'package:flutter_clean_architecture_01/features/daily_news/domain/entities/article.dart';
import 'package:flutter_clean_architecture_01/features/daily_news/presentation/pages/article_detail_page.dart';
import 'package:flutter_clean_architecture_01/features/daily_news/presentation/pages/news_article_page.dart';
import 'package:flutter_clean_architecture_01/features/daily_news/presentation/pages/saved_articles_page.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static const newsArticles = 'news-articles';
  static const savedArticles = 'saved-articles';
  static const articleDetail = 'article-detail';
}

final GoRouter router = GoRouter(
  initialLocation: '/news-articles',
  routes: [
    GoRoute(path: '/news-articles', name: AppRoutes.newsArticles, builder: (context, state) => const NewsArticlePage()),
    GoRoute(
      path: '/saved-articles',
      name: AppRoutes.savedArticles,
      builder: (context, state) => const SavedArticlesPage(),
    ),
    GoRoute(
      path: '/article-detail',
      name: AppRoutes.articleDetail,
      builder: (context, state) {
        final article = state.extra as Article;
        return ArticleDetailPage(article: article);
      },
    ),
  ],
);
