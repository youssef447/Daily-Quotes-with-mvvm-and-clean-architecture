import 'dart:ui';

import 'package:dailyquotes/core/utils/defaultDialog.dart';
import 'package:dailyquotes/model/Models/quoteModel.dart';
import 'package:dailyquotes/view-model/addEditQuoteStates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Widgets/FadeInDown.dart';
import '../core/utils/appColors.dart';
import '../core/utils/defaultAwesomeDialog.dart';
import '../core/utils/globales.dart';
import '../view-model/addEditQuoteCubit.dart';
import 'defaultContainer.dart';

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
  late final TextEditingController _quote=TextEditingController();
  late final TextEditingController _author=TextEditingController();

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
                    child: DefaultContainer(
                      authorController: _author,
                      quoteController: _quote,
                      height: height * 0.68,
                      stackButtons: [
                        Positioned(
                          //right: 50,
                          bottom: -15,
                          child: InkWell(
                            overlayColor: MaterialStateProperty.all<Color>(
                              Colors.transparent,
                            ),
                            onTap: () async {
                              if (_quote.text.isEmpty || _author.text.isEmpty) {
                                showDialog(
                                  context: context,
                                  builder: (context) => FadeInDown(
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
                              child: Icon(
                                widget.edit == true ? Icons.done : Icons.add,
                                color: AppColors.selectedItemColor,
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
