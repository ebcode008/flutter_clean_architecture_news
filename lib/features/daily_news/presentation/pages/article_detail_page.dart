import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_01/features/daily_news/domain/entities/article.dart';
import 'package:flutter_clean_architecture_01/features/daily_news/presentation/bloc/remote/article_detail_bloc.dart';
import 'package:flutter_clean_architecture_01/features/daily_news/presentation/widgets/article_card.dart';
import 'package:flutter_clean_architecture_01/injection_container.dart';

class ArticleDetailPage extends StatelessWidget {
  final Article article;

  const ArticleDetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ArticleDetailBloc(getIt(), getIt(), getIt())..add(InitArticleDetail(article)),
      child: BlocBuilder<ArticleDetailBloc, ArticleDetailState>(
        builder: (context, state) {
          return Scaffold(appBar: _buildAppBar(context, state), body: _buildBody(state), backgroundColor: Colors.white);
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, ArticleDetailState state) {
    if (state is ArticleDetailLoaded) {
      return AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon((state.article.favorite == true) ? Icons.favorite : Icons.favorite_border, color: Colors.black),
            onPressed: () {
              if (state.article.favorite == true) {
                context.read<ArticleDetailBloc>().add(OnDeleteArticle(article));
              } else {
                context.read<ArticleDetailBloc>().add(OnSaveArticle(article));
              }
            },
          ),
        ],
        title: const Text('Article', style: TextStyle(color: Colors.black)),
      );
    }

    return AppBar(
      elevation: 0.0,
      centerTitle: true,
      backgroundColor: Colors.white,
      title: const Text('Article', style: TextStyle(color: Colors.black)),
    );
  }

  Widget _buildBody(ArticleDetailState state) {
    if (state is ArticleDetailLoading) {
      return _loadingArticleWidget();
    }

    if (state is ArticleDetailLoaded) {
      return _loadedArticleWidget(state);
    }

    if (state is ArticleDetailFailure) {
      return _failureArticleWidget();
    }

    return const SizedBox();
  }

  Widget _loadingArticleWidget() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _failureArticleWidget() {
    return const Center(child: Text('Error'));
  }

  Widget _loadedArticleWidget(ArticleDetailLoaded state) {
    return ArticleCard(article: state.article);
  }
}
