import 'dart:ui';

import 'package:dailyquotes/core/widgets/dialogs/default_alert_dialog.dart';
import 'package:dailyquotes/core/widgets/loading/default_loading_indicator.dart';
import 'package:dailyquotes/main.dart';

import 'package:dailyquotes/presentation/add_edit_quote/controller/add_edit_quote_states.dart';
import 'package:dailyquotes/presentation/my_quotes_page/controller/my_quotes_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/animations/fade_in_down_animation.dart';
import '../../../../domain/entity/quote_entity.dart';
import '../../controller/add_edit_quote_cubit.dart';
import '../../../../core/widgets/cards/quote_card.dart';
part '../widgets/fill_quote_dialog.dart';

class AddEditQuoteSheet extends StatelessWidget {
  final QuoteEntity? quote;
  final MyQuotesCubit myQuotesCubit;
  const AddEditQuoteSheet({super.key, this.quote, required this.myQuotesCubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MyQuotesCubit>.value(
      value: myQuotesCubit,
      child: BlocProvider(
        create: (context) => AddEditQuoteCubit()..setQuoteFields(quote),
        child: BlocBuilder<AddEditQuoteCubit, AddEditQuoteStates>(
            builder: (context, state) {
          var cubit = AddEditQuoteCubit.get(context);
          return SafeArea(
            child: Scaffold(
              backgroundColor:
                  AppColorsProvider.of(context).appColors.background,
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
                            bottom: -15.h,
                            child: InkWell(
                              overlayColor: const WidgetStatePropertyAll<Color>(
                                Colors.transparent,
                              ),
                              onTap: () async {
                                if (cubit.quoteController.text.isEmpty ||
                                    cubit.authorController.text.isEmpty) {
                                  showDialog(
                                    context: context,
                                    builder: (context) =>
                                        const FillQuoteDialog(),
                                  );
                                } else {
                                  if (quote != null) {
                                    await cubit.editMyQuote(quote!,
                                        context: context);
                                  } else {
                                    await cubit.addMyQuote(context);
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
                        child: const DefaultLoadingIndicator(),
                      )
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
