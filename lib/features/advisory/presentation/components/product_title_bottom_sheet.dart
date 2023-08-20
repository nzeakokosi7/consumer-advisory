import 'dart:async';

import 'package:consumable_advisory/config/app_colors.dart';
import 'package:consumable_advisory/config/common/components/elevated_button.dart';
import 'package:consumable_advisory/config/common/components/text_field.dart';
import 'package:consumable_advisory/config/common/constants/edge_insets.dart';
import 'package:consumable_advisory/features/advisory/domain/enums/stage.dart';
import 'package:flutter/material.dart';

class ProductTitleBottomSheet {
  ProductTitleBottomSheet._();

  static Future show<T>({
    required BuildContext context,
    required void Function(String productCategory) proceed,
    required StreamController<Stage> bottomSheetStream,
    required TextEditingController controller,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppEdgeInsets.huge),
          topRight: Radius.circular(AppEdgeInsets.huge),
        ),
      ),
      backgroundColor: Colors.white,
      builder: (_) => _ProductTitleBottomSheet(
        proceed: proceed,
        bottomSheetStream: bottomSheetStream,
        controller: controller,
      ),
    );
  }
}

class _ProductTitleBottomSheet extends StatefulWidget {
  final void Function(String productCategory) proceed;
  final StreamController<Stage> bottomSheetStream;
  final TextEditingController controller;

  const _ProductTitleBottomSheet({
    required this.proceed,
    required this.bottomSheetStream,
    required this.controller,
  });

  @override
  __PhoneVerificationBottomSheet createState() =>
      __PhoneVerificationBottomSheet();
}

class __PhoneVerificationBottomSheet extends State<_ProductTitleBottomSheet> {
  bool _isLoading = false;
  bool _canProceed = false;
  String? _category;

  @override
  void initState() {
    super.initState();
    widget.bottomSheetStream.stream.listen((event) {
      if (event == Stage.initial) {
        setState(() {
          _isLoading = true;
        });
      } else if (event == Stage.error) {
        setState(() {
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        Navigator.pop(context);
      }
    });
    _canProceed = widget.controller.text.isNotEmpty && _category != null;

    widget.controller.addListener(() {
      setState(() {
        _canProceed = widget.controller.text.isNotEmpty && _category != null;
      });
    });
  }

  void onCategoryChange(String category) {
    setState(() {
      _category = category;
      _canProceed = widget.controller.text.isNotEmpty && _category != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: LayoutBuilder(
        builder: (context, _) {
          return Container(
            margin: AppEdgeInsets.elephant.asEdgeInsetsOnly(top: true),
            padding: AppEdgeInsets.huge.asEdgeInsetsSymmetric(horizontal: true),
            height: screenHeight,
            child: Column(
              children: [
                const SizedBox(
                  width: AppEdgeInsets.seaLion,
                  child: Divider(
                    color: AppColors.subTitleColor,
                    thickness: 3,
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Text(
                        "What type of product is this?",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: AppColors.titleColor,
                            ),
                      ),
                      const SizedBox(height: AppEdgeInsets.dolphin),
                      AppTextField(
                        hint: "Soda, Cough syrup",
                        controller: widget.controller,
                      ),
                      const SizedBox(height: AppEdgeInsets.huge),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Categorization",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.titleColor,
                                ),
                          ),
                          RadioListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              "Medication",
                              textAlign: TextAlign.left,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.subTitleColor,
                                  ),
                            ),
                            value: "Medication",
                            groupValue: _category,
                            onChanged: (value) {
                              onCategoryChange(value!);
                            },
                          ),
                          RadioListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              "Food Item",
                              textAlign: TextAlign.left,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.subTitleColor,
                                  ),
                            ),
                            value: "Food Item",
                            groupValue: _category,
                            onChanged: (value) {
                              onCategoryChange(value!);
                            },
                          ),
                          RadioListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              "Beverage",
                              textAlign: TextAlign.left,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.subTitleColor,
                                  ),
                            ),
                            value: "Beverage",
                            groupValue: _category,
                            onChanged: (value) {
                              onCategoryChange(value!);
                            },
                          ),
                          RadioListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              "Building Material",
                              textAlign: TextAlign.left,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.subTitleColor,
                                  ),
                            ),
                            value: "Building Material",
                            groupValue: _category,
                            onChanged: (value) {
                              onCategoryChange(value!);
                            },
                          ),
                          RadioListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              "Alcohol",
                              textAlign: TextAlign.left,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.subTitleColor,
                              ),
                            ),
                            value: "Alcohol",
                            groupValue: _category,
                            onChanged: (value) {
                              onCategoryChange(value!);
                            },
                          ),
                          RadioListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              "Others",
                              textAlign: TextAlign.left,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.subTitleColor,
                              ),
                            ),
                            value: "Others",
                            groupValue: _category,
                            onChanged: (value) {
                              onCategoryChange(value!);
                            },
                          )
                        ],
                      ),
                      const SizedBox(height: AppEdgeInsets.huge),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AppButton(
                        shape: const StadiumBorder(
                          side: BorderSide(),
                        ),
                        isDisabled: !_canProceed,
                        loading: _isLoading,
                        loaderColor: AppColors.appBlack,
                        onPressed: () {
                          widget.proceed.call(_category!);
                        },
                        backgroundColor: AppColors.appBackground,
                        title: "Proceed",
                        titleStyle: const TextStyle(
                          color: AppColors.appBlack,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: AppEdgeInsets.normal),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancel",
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
