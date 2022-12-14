import 'package:flutter/material.dart';

import '../utils/all_lists.dart';
import '../utils/app_constants.dart';
import '../widgets/Text_widget.dart';
import '../widgets/category_list_tile.dart';

class ListCategory extends StatefulWidget {
  @override
  State<ListCategory> createState() => _ListCategoryState();
}

class _ListCategoryState extends State<ListCategory> {
  final _lists = AllLists();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
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
                      txt: "Kategori",
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
              ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _lists.kategotiList.length,
                  itemBuilder: (context, index) {
                    return CategoryListTile(
                      imagePath: _lists.kategotiList[index].foto,
                      categoryName: _lists.kategotiList[index].nama_kategori,
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
