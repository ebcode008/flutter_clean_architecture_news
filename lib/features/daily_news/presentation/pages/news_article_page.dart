import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_01/features/daily_news/domain/entities/article.dart';
import 'package:flutter_clean_architecture_01/features/daily_news/presentation/bloc/remote/news_article_bloc.dart';
import 'package:flutter_clean_architecture_01/features/daily_news/presentation/pages/article_detail_page.dart';
import 'package:flutter_clean_architecture_01/features/daily_news/presentation/pages/saved_articles_page.dart';
import 'package:flutter_clean_architecture_01/features/daily_news/presentation/widgets/article_tile.dart';

class NewsArticlePage extends StatelessWidget {
  const NewsArticlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(context), body: _buildBody(), backgroundColor: Colors.white);
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      centerTitle: true,
      backgroundColor: Colors.white,
      actions: [
        IconButton(
          icon: const Icon(Icons.favorite, color: Colors.black),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => SavedArticlesPage()));
          },
        ),
      ],
      title: const Text('Daily News', style: TextStyle(color: Colors.black)),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<NewsArticleBloc, NewsArticleState>(
      builder: (context, state) {
        if (state is NewsArticleLoading) {
          return _loadingArticleWidget();
        }

        if (state is NewsArticleLoaded) {
          return _successArticleWidget(state);
        }

        if (state is NewsArticleFailure) {
          return _failureArticleWidget();
        }

        return const SizedBox();
      },
    );
  }

  Widget _loadingArticleWidget() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _failureArticleWidget() {
    return const Center(child: Text('Error'));
  }

  Widget _successArticleWidget(NewsArticleLoaded state) {
    return ListView.builder(
      itemCount: state.articles.length,
      itemBuilder: (context, index) {
        Article article = state.articles[index];
        return ArticleTile(
          article: article,
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => ArticleDetailPage(article: article)));
          },
        );
      },
    );
  }
}
