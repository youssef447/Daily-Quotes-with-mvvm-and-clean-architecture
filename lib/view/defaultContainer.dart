import 'package:dailyquotes/model/Entities/quote.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;
import '../core/utils/appColors.dart';

class DefaultContainer extends StatelessWidget {
  final Quote quote;
  final double height;
  final List<Widget> stackButtons;

  const DefaultContainer({
    super.key,
    required this.quote,
    required this.height,
    required this.stackButtons,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.format_quote_sharp,
                        color: Colors.white,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Text(
                            textAlign: TextAlign.center,
                            quote.quote,
                            style: GoogleFonts.gabriela(
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(fontWeight: FontWeight.normal)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                '-${quote.author}',
                style: GoogleFonts.xanhMono(
                  textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: AppColors.defaultColor,
                      ),
                ),
              ),
            ],
          ),
        ),
        ...stackButtons,
      ],
    );
  }
}
