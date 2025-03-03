import 'package:dailyquotes/core/extensions/context_extension.dart';
import 'package:dailyquotes/core/theme/text/app_text_styles.dart';
import 'package:dailyquotes/core/widgets/animations/scale_animation.dart';
import 'package:dailyquotes/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;
import '../../../domain/entity/quote_entity.dart';
import '../../../presentation/home_page/controller/home_cubit.dart';
import '../../../presentation/home_page/controller/home_states.dart';
import '../../enums/card_shape.dart';
import '../fields/default_form_field.dart';

class QuoteCard extends StatelessWidget {
  final QuoteEntity? quote;
  final bool isForm;

  final List<Widget> stackButtons;
  final TextEditingController? authorController;
  final TextEditingController? quoteController;

  const QuoteCard(
      {super.key,
      this.quote,
      required this.stackButtons,
      this.authorController,
      this.quoteController,
      this.isForm = false});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
        buildWhen: (previous, current) => current is ChangeShapeState,
        builder: (context, state) {
          final isRectangle =
              context.read<HomeCubit>().cardShape == CardShape.rectangle ||
                  isForm;
          final height =
              isRectangle ? context.height * 0.6 : context.height * 0.3;
          return ScaleAnimation(
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomRight,
              children: [
                Transform.rotate(
                  angle: isRectangle
                      ? -math.pi * 0.02 // 45 degrees in radians
                      : -math.pi * 0.04,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    width: double.infinity,
                    clipBehavior: Clip.none,
                    height: height,
                    padding: EdgeInsets.all(8.h),
                    decoration: BoxDecoration(
                      color: AppColorsProvider.of(context)
                          .appColors
                          .primary
                          .withOpacity(0.6),
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          17.r,
                        ),
                      ),
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  width: double.infinity,
                  height: height,
                  clipBehavior: Clip.none,
                  padding: EdgeInsets.all(8.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        17.r,
                      ),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: AppColorsProvider.of(context)
                          .appColors
                          .gradientColors,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Center(
                          child: Row(
                            crossAxisAlignment: quote != null
                                ? CrossAxisAlignment.start
                                : CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.format_quote_sharp,
                                color: AppColorsProvider.of(context)
                                    .appColors
                                    .iconCard,
                                size: 20.sp,
                              ),
                              Expanded(
                                child: quote != null
                                    ? SingleChildScrollView(
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          quote!.quote,
                                          style: GoogleFonts.gabriela(
                                            textStyle: AppTextStyles
                                                .font22MediumABeeZee
                                                .copyWith(
                                              fontWeight: FontWeight.normal,
                                              color:
                                                  AppColorsProvider.of(context)
                                                      .appColors
                                                      .iconCard,
                                            ),
                                          ),
                                        ),
                                      )
                                    : DefaultFormField(
                                        controller: quoteController!,
                                        borderNone: true,
                                        enabled: true,
                                        hintText: 'Add Your Quote',
                                        hintColor: AppColorsProvider.of(context)
                                            .appColors
                                            .iconCard,
                                        styleColor:
                                            AppColorsProvider.of(context)
                                                .appColors
                                                .iconCard,
                                        context: context,
                                        expand: true,
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      quote != null
                          ? Text(
                              '-${quote!.author}',
                              style: GoogleFonts.xanhMono(
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: AppColorsProvider.of(context)
                                          .appColors
                                          .iconCard,
                                    ),
                              ),
                            )
                          : Row(
                              children: [
                                Text(
                                  '-',
                                  style: GoogleFonts.xanhMono(
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                            color: AppColorsProvider.of(context)
                                                .appColors
                                                .iconCard),
                                  ),
                                ),
                                Expanded(
                                  child: DefaultFormField(
                                    controller: authorController!,
                                    borderNone: true,
                                    hintText: 'Your Name',
                                    style: GoogleFonts.xanhMono(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                              color:
                                                  AppColorsProvider.of(context)
                                                      .appColors
                                                      .iconCard),
                                    ),
                                    hintStyle: GoogleFonts.xanhMono(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                              color:
                                                  AppColorsProvider.of(context)
                                                      .appColors
                                                      .iconCard),
                                    ),
                                    context: context,
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
                ...stackButtons
              ],
            ),
          );
        });
  }
}
