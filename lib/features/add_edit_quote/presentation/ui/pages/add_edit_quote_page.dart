import 'dart:ui';

import 'package:dailyquotes/core/Widgets/dialogs/default_alert_dialog.dart';
import 'package:dailyquotes/data/Models/quoteModel.dart';
import 'package:dailyquotes/features/add_edit_quote/presentation/controller/add_edit_quote_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/animations/fade_In_down_animation.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/Widgets/dialogs/default_awesome_dialog.dart';
import '../../../../../core/utils/utils.dart';
import '../../controller/add_edit_quote_cubit.dart';
import '../../../../../core/Widgets/cards/quote_card.dart';

class AddEditQuote extends StatefulWidget {
  final bool? edit;
  final QuoteModel? quote;
  const AddEditQuote({
    super.key,
    this.edit,
    this.quote,
  });

  @override
  State<AddEditQuote> createState() => _AddEditQuoteState();
}

class _AddEditQuoteState extends State<AddEditQuote> {
  late final TextEditingController _quote = TextEditingController();
  late final TextEditingController _author = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.edit == true) {
      _quote.text = widget.quote!.quote;
      _author.text = widget.quote!.author;
    }
    return BlocProvider(
      create: (context) => AddEditQuoteCubit(),
      child: BlocConsumer<AddEditQuoteCubit, AddEditQuoteStates>(
          listener: (context, state) {
        if (state is AddMyQuoteErrorState) {
          AwesomeDialogUtil.error(
            context: context,
            body: 'Error Adding Your Quote, please try again',
            title: 'Failed',
          );
        }
        if (state is EditMyQuoteErrorState) {
          AwesomeDialogUtil.error(
            context: context,
            body: 'Error Upadting Your Quote, please try again',
            title: 'Failed',
          );
        }
        if (state is AddMyQuoteSuccessState) {
          AwesomeDialogUtil.sucess(
            context: context,
            body: 'Quote Added!, refresh to reflect changes',
            title: 'Done',
            btnOkOnPress: () => Navigator.of(context).pop(),
          );
        }
        if (state is EditMyQuoteSuccessState) {
          AwesomeDialogUtil.sucess(
            context: context,
            body: 'Quote Upadated!',
            title: 'Done',
            btnOkOnPress: () => Navigator.of(context).pop(),
          );
        }
      }, builder: (context, state) {
        var cubit = AddEditQuoteCubit.get(context);
        return SafeArea(
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Stack(
                children: [
                  Center(
                    child: QuoteCard(
                      authorController: _author,
                      quoteController: _quote,
                      height: height * 0.68,
                      stackButtons: [
                        Positioned(
                          //right: 50,
                          bottom: -15,
                          child: InkWell(
                            overlayColor: WidgetStatePropertyAll<Color>(
                              Colors.transparent,
                            ),
                            onTap: () async {
                              if (_quote.text.isEmpty || _author.text.isEmpty) {
                                showDialog(
                                  context: context,
                                  builder: (context) => FadeInDownAnimation(
                                    child: DefaultAlertDialog.Info(
                                        content:
                                            'You Need To fill Card Content',
                                        icon: Icons.warning,
                                        iconColor: AppColors.selectedItemColor,
                                        defaultTextStyle: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                        onOkClicked: () =>
                                            Navigator.of(context).pop()),
                                  ),
                                );
                              } else {
                                if (widget.edit == true) {
                                  widget.quote!.author = _author.text.trim();
                                  widget.quote!.quote = _quote.text.trim();

                                  await cubit.editMyQuote(widget.quote!);
                                } else {
                                  await cubit.addMyQuote(
                                    quote: _quote.text.trim(),
                                    author: _author.text.trim(),
                                  );
                                }
                              }
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 22.sp,
                              child: Icon(
                                widget.edit == true ? Icons.done : Icons.add,
                                color: AppColors.selectedItemColor,
                                size: 25.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  state is AddMyQuoteLoadingState ||
                          state is EditMyQuoteLoadingState
                      ? BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 3.0,
                            sigmaY: 3.0,
                          ),
                          child: const Center(
                            child:
                                CircularProgressIndicator(color: Colors.white),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
