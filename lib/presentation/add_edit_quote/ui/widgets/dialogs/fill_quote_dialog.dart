part of '../../pages/add_edit_quote_page.dart';

class FillQuoteDialog extends StatelessWidget {
  const FillQuoteDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeInDownAnimation(
      child: DefaultAlertDialog.Info(
          context: context,
          content: 'You Need To fill Card Content',
          icon: Icons.warning_rounded,
          iconColor: AppColorsProvider.of(context).appColors.primary,
          defaultTextStyle: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.bold),
          onOkClicked: () => Navigator.of(context).pop()),
    );
  }
}
