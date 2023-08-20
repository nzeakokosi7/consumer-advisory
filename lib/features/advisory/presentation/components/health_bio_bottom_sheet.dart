import 'dart:async';

import 'package:consumable_advisory/config/app_colors.dart';
import 'package:consumable_advisory/config/app_logger.dart';
import 'package:consumable_advisory/config/common/components/elevated_button.dart';
import 'package:consumable_advisory/config/common/components/text_field.dart';
import 'package:consumable_advisory/config/common/constants/edge_insets.dart';
import 'package:consumable_advisory/features/accounts/domain/entities/health_bio_entity.dart';
import 'package:consumable_advisory/features/advisory/domain/enums/stage.dart';
import 'package:flutter/material.dart';

class HealthBioBottomSheet {
  HealthBioBottomSheet._();

  static Future show<T>({
    required BuildContext context,
    required void Function(HealthBioEntity healthBioEntity) proceed,
    required StreamController<Stage> bottomSheetStream,
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
      builder: (_) => _HealthBioBottomSheet(
        proceed: proceed,
        bottomSheetStream: bottomSheetStream,
      ),
    );
  }
}

class _HealthBioBottomSheet extends StatefulWidget {
  final void Function(HealthBioEntity healthBioEntity) proceed;
  final StreamController<Stage> bottomSheetStream;

  const _HealthBioBottomSheet({
    required this.proceed,
    required this.bottomSheetStream,
  });

  @override
  __HealthBioBottomSheet createState() => __HealthBioBottomSheet();
}

class __HealthBioBottomSheet extends State<_HealthBioBottomSheet> {
  bool _isLoading = false;
  bool _canProceed = false;
  String? _bloodGroup;
  String? _genotype;
  String? _gender;
  String? _isPregnant;
  String? _isAMother;
  String? _isLactating;
  String? _bloodGroupRhesus;
  final _ageController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _stdController = TextEditingController();
  final _allergyController = TextEditingController();

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
    _canProceed = _areAllTextFilled() && _areAllOptionsChecked();
    _isAMother = "false";
    _isLactating  = "false";
    _bloodGroupRhesus  = "false";

    _ageController.addListener(textControllerListener);
    _heightController.addListener(textControllerListener);
    _weightController.addListener(textControllerListener);
  }

  void textControllerListener() {
    _canProceed = _areAllTextFilled() && _areAllOptionsChecked();
  }

  void onGenderChange(String gender) {
    setState(() {
      _gender = gender;
      _canProceed = _areAllTextFilled() && _areAllOptionsChecked();
    });
  }

  void onGenotypeChange(String genotype) {
    setState(() {
      _genotype = genotype;
      _canProceed = _areAllTextFilled() && _areAllOptionsChecked();
    });
  }

  void onBloodGroupChange(String bloodGroup) {
    setState(() {
      _bloodGroup = bloodGroup;
      _canProceed = _areAllTextFilled() && _areAllOptionsChecked();
    });
  }

  void onBloodGroupRhesusChange(String bloodGroupRhesus) {
    setState(() {
      _bloodGroupRhesus = bloodGroupRhesus;
      _canProceed = _areAllTextFilled() && _areAllOptionsChecked();
    });
  }

  void onPregnancyStatusChange(String status) {
    setState(() {
      _isPregnant = status;
      _canProceed = _areAllTextFilled() && _areAllOptionsChecked();
    });
  }

  void onMotherStatusChange(String status) {
    setState(() {
      _isAMother = status;
      _canProceed = _areAllTextFilled() && _areAllOptionsChecked();
    });
  }

  void onLactatingStatusChange(String status) {
    setState(() {
      _isLactating = status;
      _canProceed = _areAllTextFilled() && _areAllOptionsChecked();
    });
  }

  bool _areAllTextFilled() {
    return _ageController.text.isNotEmpty &&
        _heightController.text.isNotEmpty &&
        _weightController.text.isNotEmpty;
  }

  bool _areAllOptionsChecked() {
    if (_gender != null && _gender == "female") {
      return _bloodGroup != null &&
          _bloodGroupRhesus != null &&
          _genotype != null &&
          _gender != null &&
          _isLactating != null &&
          _isAMother != null &&
          _isPregnant != null;
    } else {
      return _bloodGroup != null &&
          _bloodGroupRhesus != null &&
          _genotype != null &&
          _gender != null;
    }
  }

  HealthBioEntity prepareResponse() {
    final age = int.parse(_ageController.text.trim());
    final height = double.parse(_heightController.text.trim());
    final weight = double.parse(_weightController.text.trim());
    return HealthBioEntity(
      age: age,
      height: height,
      weight: weight,
      gender: _gender!,
      genotype: _genotype!,
      bloodGroup: _bloodGroupRhesus!,
      isPregnant: bool.parse(_isPregnant!),
      isLactating: bool.parse(_isLactating!),
      isAMother: false,
    );
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
                        "Profiling",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: AppColors.titleColor,
                            ),
                      ),
                      const SizedBox(height: AppEdgeInsets.normal),
                      Text(
                        "We'd need to know a few things about your health status in order to cater to you properly",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.titleColor,
                            ),
                      ),
                      const SizedBox(height: AppEdgeInsets.dolphin),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Gender",
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
                          const SizedBox(height: AppEdgeInsets.big),
                          Row(
                            children: [
                              SizedBox(
                                width: 150,
                                child: RadioListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(
                                    "Male",
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
                                  value: "male",
                                  groupValue: _gender,
                                  onChanged: (value) {
                                    onGenderChange(value!);
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 150,
                                child: RadioListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(
                                    "Female",
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
                                  value: "female",
                                  groupValue: _gender,
                                  onChanged: (value) {
                                    onGenderChange(value!);
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppEdgeInsets.huge),
                          AppTextField(
                            label: "Age",
                            controller: _ageController,
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(height: AppEdgeInsets.huge),
                          AppTextField(
                            label: "Height",
                            hint: "Conversion rate",
                            keyboardType: TextInputType.number,
                            suffixWidget: Center(
                              child: Text(
                                "inches",
                                textAlign: TextAlign.right,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.titleColor,
                                    ),
                              ),
                            ),
                            controller: _heightController,
                          ),
                          const SizedBox(height: AppEdgeInsets.huge),
                          AppTextField(
                            label: "Weight",
                            keyboardType: TextInputType.number,
                            suffixWidget: Center(
                              child: Text(
                                "Kg",
                                textAlign: TextAlign.right,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.titleColor,
                                    ),
                              ),
                            ),
                            controller: _weightController,
                          ),
                          const SizedBox(height: AppEdgeInsets.huge),
                          if (_gender != null && _gender == "female")
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Are you pregnant?",
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
                                const SizedBox(height: AppEdgeInsets.big),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 150,
                                      child: RadioListTile(
                                        contentPadding: EdgeInsets.zero,
                                        title: Text(
                                          "Yes",
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
                                        value: "true",
                                        groupValue: _isPregnant,
                                        onChanged: (value) {
                                          onPregnancyStatusChange(value!);
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: 150,
                                      child: RadioListTile(
                                        contentPadding: EdgeInsets.zero,
                                        title: Text(
                                          "No",
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
                                        value: "false",
                                        groupValue: _isPregnant,
                                        onChanged: (value) {
                                          onPregnancyStatusChange(value!);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: AppEdgeInsets.huge),
                                Text(
                                  "Are you a mother?",
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
                                const SizedBox(height: AppEdgeInsets.big),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 150,
                                      child: RadioListTile(
                                        contentPadding: EdgeInsets.zero,
                                        title: Text(
                                          "Yes",
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
                                        value: "true",
                                        groupValue: _isAMother,
                                        onChanged: (value) {
                                          onMotherStatusChange(value!);
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: 150,
                                      child: RadioListTile(
                                        contentPadding: EdgeInsets.zero,
                                        title: Text(
                                          "No",
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
                                        value: "false",
                                        groupValue: _isAMother,
                                        onChanged: (value) {
                                          onMotherStatusChange(value!);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: AppEdgeInsets.huge),
                                Text(
                                  "Currently breast feeding?",
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
                                const SizedBox(height: AppEdgeInsets.big),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 150,
                                      child: RadioListTile(
                                        contentPadding: EdgeInsets.zero,
                                        title: Text(
                                          "Yes",
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
                                        value: "true",
                                        groupValue: _isLactating,
                                        onChanged: (value) {
                                          onLactatingStatusChange(value!);
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: 150,
                                      child: RadioListTile(
                                        contentPadding: EdgeInsets.zero,
                                        title: Text(
                                          "No",
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
                                        value: "false",
                                        groupValue: _isLactating,
                                        onChanged: (value) {
                                          onLactatingStatusChange(value!);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: AppEdgeInsets.huge),
                              ],
                            ),
                          const SizedBox(height: AppEdgeInsets.huge),
                          Text(
                            "Genotype",
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
                          Wrap(
                            children: [
                              SizedBox(
                                width: 100,
                                child: RadioListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(
                                    "AA",
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
                                  value: "AA",
                                  groupValue: _genotype,
                                  onChanged: (value) {
                                    onGenotypeChange(value!);
                                  },
                                ),
                              ),
                              const SizedBox(width: AppEdgeInsets.normal),
                              SizedBox(
                                width: 100,
                                child: RadioListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(
                                    "AC",
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
                                  value: "AC",
                                  groupValue: _genotype,
                                  onChanged: (value) {
                                    onGenotypeChange(value!);
                                  },
                                ),
                              ),
                              const SizedBox(width: AppEdgeInsets.normal),
                              SizedBox(
                                width: 100,
                                child: RadioListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(
                                    "AS",
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
                                  value: "AS",
                                  groupValue: _genotype,
                                  onChanged: (value) {
                                    onGenotypeChange(value!);
                                  },
                                ),
                              ),
                              const SizedBox(width: AppEdgeInsets.normal),
                              SizedBox(
                                width: 100,
                                child: RadioListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(
                                    "CC",
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
                                  value: "CC",
                                  groupValue: _genotype,
                                  onChanged: (value) {
                                    onGenotypeChange(value!);
                                  },
                                ),
                              ),
                              const SizedBox(width: AppEdgeInsets.normal),
                              SizedBox(
                                width: 100,
                                child: RadioListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(
                                    "SC",
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
                                  value: "SC",
                                  groupValue: _genotype,
                                  onChanged: (value) {
                                    onGenotypeChange(value!);
                                  },
                                ),
                              ),
                              const SizedBox(width: AppEdgeInsets.normal),
                              SizedBox(
                                width: 100,
                                child: RadioListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(
                                    "SS",
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
                                  value: "SS",
                                  groupValue: _genotype,
                                  onChanged: (value) {
                                    onGenotypeChange(value!);
                                  },
                                ),
                              ),
                              const SizedBox(width: AppEdgeInsets.normal),
                            ],
                          ),
                          Text(
                            "Blood Group",
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
                          Wrap(
                            children: [
                              SizedBox(
                                width: 80,
                                child: RadioListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(
                                    "A",
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
                                  value: "A",
                                  groupValue: _bloodGroup,
                                  onChanged: (value) {
                                    onBloodGroupChange(value!);
                                  },
                                ),
                              ),
                              const SizedBox(width: AppEdgeInsets.normal),
                              SizedBox(
                                width: 80,
                                child: RadioListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(
                                    "B",
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
                                  value: "B",
                                  groupValue: _bloodGroup,
                                  onChanged: (value) {
                                    onBloodGroupChange(value!);
                                  },
                                ),
                              ),
                              const SizedBox(width: AppEdgeInsets.normal),
                              SizedBox(
                                width: 80,
                                child: RadioListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(
                                    "AB",
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
                                  value: "AB",
                                  groupValue: _bloodGroup,
                                  onChanged: (value) {
                                    onBloodGroupChange(value!);
                                  },
                                ),
                              ),
                              const SizedBox(width: AppEdgeInsets.normal),
                              SizedBox(
                                width: 80,
                                child: RadioListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(
                                    "O",
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
                                  value: "O",
                                  groupValue: _bloodGroup,
                                  onChanged: (value) {
                                    onBloodGroupChange(value!);
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppEdgeInsets.huge),
                          if (_bloodGroup != null)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RadioListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(
                                    "$_bloodGroup+",
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
                                  value: "$_bloodGroup+",
                                  groupValue: _bloodGroupRhesus,
                                  onChanged: (value) {
                                    onBloodGroupRhesusChange(value!);
                                  },
                                ),
                                RadioListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(
                                    "$_bloodGroup-",
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
                                  value: "$_bloodGroup-",
                                  groupValue: _bloodGroupRhesus,
                                  onChanged: (value) {
                                    onBloodGroupRhesusChange(value!);
                                  },
                                ),
                                const SizedBox(height: AppEdgeInsets.huge),
                              ],
                            ),
                          AppTextField(
                            label: "Any Current STDs or STIs",
                            controller: _stdController,
                          ),
                          const SizedBox(height: AppEdgeInsets.huge),
                          AppTextField(
                            label: "Notable allergies",
                            controller: _allergyController,
                          ),
                        ],
                      ),
                      const SizedBox(height: AppEdgeInsets.dolphin),
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
                        onPressed: () {
                          widget.proceed.call(prepareResponse());
                        },
                        backgroundColor: AppColors.appBackground,
                        title: "Proceed",
                        loaderColor: AppColors.appBlack,
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
                          style:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
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
