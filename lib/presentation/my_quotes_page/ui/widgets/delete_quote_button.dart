part of '../pages/my_quotes_page.dart';

class DeleteQuoteButton extends StatelessWidget {
  final int itemIndex;
  const DeleteQuoteButton({
    super.key,
    required this.cubit,
    required this.itemIndex,
  });

  final MyQuotesCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -28.h,
      right: -15.w,
      child: IconButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => FadeInDownAnimation(
              child: DefaultAlertDialog.confirm(
                  context: context,
                  content: 'Are You sure you want to delete this quote?',
                  icon: Icons.question_mark_sharp,
                  onNoClicked: () => Navigator.of(context).pop(),
                  onYesClicked: () {
                    cubit.removeMyQuote(cubit.myQuotes[itemIndex].id!);
                  }),
            ),
          );
        },
        icon: Icon(
          Icons.cancel_rounded,
          size: 50.sp,
          color: Colors.white,
        ),
      ),
    );
  }
}
