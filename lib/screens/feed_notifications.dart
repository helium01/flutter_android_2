
import 'package:flutter/material.dart';
import 'package:phileaflorist/widgets/feed_notification_list_tile.dart';

import '../utils/app_constants.dart';
import '../widgets/Text_widget.dart';

class FeedNotifications extends StatelessWidget {
  const FeedNotifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 26, left: 16, right: 16),
                child: Row(
                  children: const [
                    Icon(
                      Icons.arrow_back_ios,
                      color: AppConstants.subTxtColor,
                      size: 18,
                    ),
                    SizedBox(
                      width: 21,
                    ),
                    TextWidget(
                      txt: "Feed",
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      textColor: AppConstants.titleTextColor,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 28,
              ),
              const Divider(
                thickness: 1,
                height: 0,
                color: AppConstants.txtFieldColor,
              ),
              const SizedBox(
                height: 16,
              ),
              FeedNotificationListTile(
                  leadingImagePath: "assets/images/shoe1.png",
                  titleText: "New Product",
                  description:
                      "bunga papan yang cantik",
                  date: "June 3, 2015 5:06 PM"),
              const SizedBox(
                height: 16,
              ),
              FeedNotificationListTile(
                  leadingImagePath: "assets/images/shoe1.png",
                  titleText: "New Product",
                  description:
                      "bunga papan yang cantik",
                  date: "June 3, 2015 5:06 PM"),
              const SizedBox(
                height: 16,
              ),
              FeedNotificationListTile(
                 leadingImagePath: "assets/images/shoe1.png",
                  titleText: "New Product",
                  description:
                      "bunga papan yang cantik",
                  date: "June 3, 2015 5:06 PM"),
            ],
          ),
        ),
      ),
    );
  }
}
