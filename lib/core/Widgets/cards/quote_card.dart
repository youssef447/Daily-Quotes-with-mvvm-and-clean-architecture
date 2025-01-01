import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;
import '../../../features/home_page/data/models/quoteModel.dart';
import '../fields/default_form_field.dart';
import '../../theme/app_colors.dart';

class QuoteCard extends StatelessWidget {
  final QuoteModel? quote;
  final double height;
  final List<Widget> stackButtons;
  final TextEditingController? authorController;
  final TextEditingController? quoteController;

  const QuoteCard({
    super.key,
    this.quote,
    required this.height,
    required this.stackButtons,
    this.authorController,
    this.quoteController,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomRight,
      children: [
        Transform.rotate(
          angle: -math.pi * 0.02, // 45 degrees in radians

          child: Container(
            width: double.infinity,
            height: height,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.selectedItemColor.withOpacity(0.6),
              borderRadius: const BorderRadius.all(
                Radius.circular(
                  17,
                ),
              ),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: height,
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(
                18,
              ),
            ),
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: AppColors.gradientColors,
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
                        color: Colors.white,
                        size: 20.sp,
                      ),
                      Expanded(
                        child: quote != null
                            ? SingleChildScrollView(
                                child: Text(
                                  textAlign: TextAlign.center,
                                  quote!.quote,
                                  style: GoogleFonts.gabriela(
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                            fontWeight: FontWeight.normal),
                                  ),
                                ),
                              )
                            : DefaultFormField(
                                controller: quoteController!,
                                borderNone: true,
                                enabled: true,
                                hintText: 'Add Your Quote',
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
                        textStyle:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: AppColors.defaultColor,
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
                                .copyWith(color: AppColors.defaultColor),
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
                                  .copyWith(color: AppColors.defaultColor),
                            ),
                            hintStyle: GoogleFonts.xanhMono(
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: AppColors.defaultColor),
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
    );
  }
}
