import 'dart:ui';

import 'package:dailyquotes/core/widgets/dialogs/default_alert_dialog.dart';
import 'package:dailyquotes/core/widgets/loading/default_loading_indicator.dart';
import 'package:dailyquotes/main.dart';

import 'package:dailyquotes/presentation/add_edit_quote/controller/add_edit_quote_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/animations/fade_In_down_animation.dart';
import '../../../../core/widgets/dialogs/default_awesome_dialog.dart';
import '../../../../domain/entity/quote_entity.dart';
import '../../controller/add_edit_quote_cubit.dart';
import '../../../../core/widgets/cards/quote_card.dart';
part '../widgets/dialogs/fill_quote_dialog.dart';

class AddEditQuoteSheet extends StatelessWidget {
  final QuoteEntity? quote;
  const AddEditQuoteSheet({
    super.key,
    this.quote,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddEditQuoteCubit()..setQuoteFields(quote),
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
        if (state is AddMyQuotesPageuccessState) {
          AwesomeDialogUtil.sucess(
            context: context,
            body: 'Quote Added Successfully',
            title: 'Done',
            btnOkOnPress: () => Navigator.of(context).pop(),
          );
        }
        if (state is EditMyQuotesPageuccessState) {
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
            backgroundColor: AppColorsProvider.of(context).appColors.background,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Stack(
                children: [
                  Center(
                    child: QuoteCard(
                      authorController: cubit.authorController,
                      quoteController: cubit.quoteController,
                      isForm: true,
                      stackButtons: [
                        Positioned(
                          //right: 50,
                          bottom: -15,
                          child: InkWell(
                            overlayColor: WidgetStatePropertyAll<Color>(
                              Colors.transparent,
                            ),
                            onTap: () async {
                              if (cubit.quoteController.text.isEmpty ||
                                  cubit.authorController.text.isEmpty) {
                                showDialog(
                                  context: context,
                                  builder: (context) => FillQuoteDialog(),
                                );
                              } else {
                                if (quote != null) {
                                  await cubit.editMyQuote(quote!);
                                } else {
                                  await cubit.addMyQuote();
                                }
                              }
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 22.sp,
                              child: Icon(
                                quote != null ? Icons.done : Icons.add,
                                color: AppColorsProvider.of(context)
                                    .appColors
                                    .primary,
                                size: 25.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (state is AddMyQuoteLoadingState ||
                      state is EditMyQuoteLoadingState)
                    BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 3.0,
                        sigmaY: 3.0,
                      ),
                      child: DefaultLoadingIndicator(),
                    )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
