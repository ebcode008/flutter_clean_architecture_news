// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_01/core/router/app_router.dart';
import 'package:flutter_clean_architecture_01/features/daily_news/domain/entities/article.dart';
import 'package:flutter_clean_architecture_01/features/daily_news/presentation/bloc/local/saved_article_bloc.dart';
import 'package:flutter_clean_architecture_01/features/daily_news/presentation/widgets/article_tile.dart';
import 'package:flutter_clean_architecture_01/injection_container.dart';
import 'package:go_router/go_router.dart';

class SavedArticlesPage extends StatelessWidget {
  const SavedArticlesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SavedArticleBloc(getIt())..add(OnSavedArticleEvent()),
      child: BlocBuilder<SavedArticleBloc, SavedArticleState>(
        builder: (context, state) {
          return Scaffold(appBar: _buildAppBar(), body: _buildBody(context, state), backgroundColor: Colors.white);
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0.0,
      centerTitle: true,
      backgroundColor: Colors.white,
      title: const Text('Saved Articles', style: TextStyle(color: Colors.black)),
    );
  }

  Widget _buildBody(BuildContext context, SavedArticleState state) {
    if (state is SavedArticleLoading) {
      return _loadingArticleWidget();
    }

    if (state is SavedArticleLoaded) {
      return _successArticleWidget(context, state);
    }

    if (state is SavedArticleFailure) {
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

  Widget _successArticleWidget(BuildContext context, SavedArticleLoaded state) {
    return (state.articles.isNotEmpty)
        ? ListView.builder(
            itemCount: state.articles.length,
            itemBuilder: (context, index) {
              Article article = state.articles[index];
              return ArticleTile(
                article: article,
                onTap: () {
                  context.pushNamed(AppRoutes.articleDetail, extra: article).then((result) {
                    context.read<SavedArticleBloc>().add(OnSavedArticleEvent());
                  });
                },
              );
            },
          )
        : Center(child: Text('No articles saved'));
  }
}
