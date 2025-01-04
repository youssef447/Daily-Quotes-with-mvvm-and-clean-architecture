part of '../pages/popular_quotes_page.dart';

class ErrorPopularWidget extends StatelessWidget {
  final String errorMsg;
  final PopularCubit cubit;
  const ErrorPopularWidget(
      {super.key, required this.errorMsg, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        ErrorPage(
            errMsg: errorMsg,
            retry: () async {
              await cubit.getPopularQuotes();
            }),
      ],
    );
  }
}
