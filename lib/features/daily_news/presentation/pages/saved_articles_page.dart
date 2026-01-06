import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_01/features/daily_news/domain/entities/article.dart';
import 'package:flutter_clean_architecture_01/features/daily_news/presentation/bloc/local/saved_article_bloc.dart';
import 'package:flutter_clean_architecture_01/features/daily_news/presentation/pages/article_detail_page.dart';
import 'package:flutter_clean_architecture_01/features/daily_news/presentation/widgets/article_tile.dart';

class SavedArticlesPage extends StatelessWidget {
  const SavedArticlesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildBody());
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0.0,
      centerTitle: true,
      backgroundColor: Colors.white,
      title: const Text('Saved Articles', style: TextStyle(color: Colors.black)),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<SavedArticleBloc, SavedArticleState>(
      builder: (context, state) {
        if (state is SavedArticleLoading) {
          return _loadingArticleWidget();
        }

        if (state is SavedArticleLoaded) {
          return _successArticleWidget(state);
        }

        if (state is SavedArticleFailure) {
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

  Widget _successArticleWidget(SavedArticleLoaded state) {
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
