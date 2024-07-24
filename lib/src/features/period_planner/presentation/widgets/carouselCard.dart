import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nishauri/src/shared/display/AppCard.dart';
import 'package:nishauri/src/utils/constants.dart';

class CarouselCard extends StatelessWidget {
  final String svgPath;
  final String title;
  final double? width;
  final double? height;
  final Function()? onTap;

  const CarouselCard({
    super.key,
    required this.svgPath,
    required this.title,
    this.width,
    this.height,
    this.onTap,
    });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppCard(
      clipBehaviour: Clip.antiAlias,
      svgImage: "assets/images/rect_bg.svg",
      onTap: onTap,
      child: SizedBox(
        width: width,
        height: height,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                // height: 200,
                // width: 336,
                // color: Colors.red, // Set the background color to red
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      // style: theme.textTheme.titleMedium?.copyWith(
                      //   color: Constants.announcement,
                      // ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Constants.periodPlanner,
                      ),
                      onPressed: onTap,
                      child: Text(
                        'Click Me',
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Right column with SVG image
            Expanded(
              flex: 1,
              child: SvgPicture.asset(
                svgPath,
                fit: BoxFit.scaleDown,
                height: double.infinity,
              ),
            ),
          ],
        ),
      ),
    );
  }
}