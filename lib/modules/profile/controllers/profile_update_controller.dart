import 'dart:developer';
import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hico/models/time.dart';
import 'package:hico/shared/constants/colors.dart';
import 'package:hico/shared/styles/text_style/text_style.dart';
import 'package:hico/shared/widget_hico/data_general/banks.dart';
import 'package:hico/shared/widgets/showbottom_sheet/show_bottom_sheet.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ui_api/models/master_data/bank_model.dart';
import 'package:ui_api/models/user/address_model.dart';
import 'package:ui_api/models/user/user_info_model.dart';
import 'package:ui_api/repository/hico_ui_repository.dart';

import '../../../base/base_controller.dart';
import '../../../data/app_data_global.dart';
import '../../../resource/assets_constant/icon_constants.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/constants/common.dart';
import '../../../shared/utils/date_formatter.dart';
import '../../../shared/utils/dialog_util.dart';
import '../../../shared/widget_hico/data_general/data_form_widget.dart';
import '../../../shared/widget_hico/dialog/normal_widget.dart';
import '../../../shared/widgets/image_widget/image_widget.dart';

class ProfileUpDateController extends BaseController {
  final imageWidget = ImageWidgetController();

  late Rx<String> images;
  Rx<UserInfoModel> info = Rx(UserInfoModel(
    avatarImage: '',
    documentBackSide: '',
    documentFrontSide: '',
    documentsCertificate: [],
  ));
  final _uiRepository = Get.find<HicoUIRepository>();
  Rx<int> genderId = Rx(CommonConstants.male);
  Rx<String> birthDay = Rx('');
  Rx<int> showSuggest = Rx<int>(0);
  RxList<AddressModel> addressList = RxList<AddressModel>();
  int addressId = 0;
  final avatar = Rx<File>(File(''));
  final documentFrontSide = Rx<File>(File(''));
  final documentBackSide = Rx<File>(File(''));
  RxList<File> degree = RxList<File>();
  RxList<File> curriculumVitae = RxList<File>();
  RxList<File> workExperiences = RxList<File>();
  final documentListFiles = RxList<File>();

  final updateForm = GlobalKey<FormState>();
  final TextEditingController zipCode = TextEditingController();
  final TextEditingController province = TextEditingController();
  final TextEditingController district = TextEditingController();

  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  //final TextEditingController bankName = TextEditingController();
  final TextEditingController bankBranchName = TextEditingController();
  final TextEditingController bankAccountHolder = TextEditingController();
  final TextEditingController bankAccountNumber = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController station = TextEditingController();
  final TextEditingController education = TextEditingController();
  final TextEditingController level = TextEditingController();
  final TextEditingController interpretingExperienceDetail =
      TextEditingController();
  final TextEditingController translationExperienceDetail =
      TextEditingController();
  final TextEditingController experience = TextEditingController();

  Rx<String> bankName = Rx('');
  RxBool isNumberYearsInJapanClicked = false.obs;
  RxBool isInterpretationExperienceClicked = false.obs;
  RxBool isTranslatationExperienceClicked = false.obs;

  int? bankId;
  List<BankLocalModel> lstBanks = [];
  Rx<Time> resultValue =
      Rx(Time(content: '', experienceCode: 0, isFeatured: false));
  Rx<Time> numberYearsInJapan =
      Rx(Time(content: '', experienceCode: 0, isFeatured: false));
  Rx<Time> interpretationExperience =
      Rx(Time(content: '', experienceCode: 0, isFeatured: false));
  Rx<Time> translationExperience =
      Rx(Time(content: '', experienceCode: 0, isFeatured: false));

  RxList<Time> numberYearJapanDataList = RxList(numberYearsInJapanList);
  RxList<Time> interpretationExperienceDataList =
      RxList(interpretationExperiences);
  RxList<Time> translationExperienceDataList = RxList(translatationExperiences);

  int preIndex = 0;

  ProfileUpDateController() {
    _loadData();
  }

  @override
  Future<void> onInit() {
    return super.onInit();
  }

  Future _loadData() async {
    try {
      await EasyLoading.show();
      await _uiRepository.getInfo().then((response) {
        EasyLoading.dismiss();
        if (response.status == CommonConstants.statusOk &&
            response.data != null &&
            response.data!.info != null) {
          info.value = response.data!.info!;
          AppDataGlobal.userInfo = response.data!.info!;
          _prepareData();
          return;
        }
      });
    } catch (e) {
      await EasyLoading.dismiss();
    }
  }

  Future _prepareData() async {
    name.text = info.value.name ?? '';
    genderId.value = info.value.gender ?? CommonConstants.male;
    email.text = info.value.email ?? '';
    birthDay.value = info.value.dateOfBirth ?? '';
    phone.text = info.value.phoneNumber ?? '';
    bankName.value = info.value.bankName ?? '';
    bankBranchName.text = info.value.bankBranchName ?? '';
    bankAccountHolder.text = info.value.bankAccountHolder ?? '';
    bankAccountNumber.text = info.value.bankAccountNumber ?? '';
    addressId = info.value.address != null ? info.value.address!.id! : 0;
    zipCode.text =
        info.value.address != null ? info.value.address!.code ?? '' : '';
    province.text = info.value.address != null
        ? info.value.address!.provinceName ?? ''
        : '';
    district.text = info.value.address != null
        ? info.value.address!.districtName ?? ''
        : '';
    address.text =
        info.value.address != null ? info.value.address!.address ?? '' : '';
    station.text = info.value.nearestStation ?? '';
    education.text = info.value.education ?? '';
    experience.text = info.value.experience ?? '';
    interpretingExperienceDetail.text =
        info.value.interpretationExperienceDetail ?? '';
    translationExperienceDetail.text =
        info.value.translationExperienDetail ?? '';
    numberYearsInJapan.value.content = NumberYearsInJapan
        .values[
            info.value.numberOfYearsInJapan ?? NumberYearsInJapan.None.index]
        .numberYearsInJapan;
    interpretationExperience.value.content = WorkExperience
        .values[
            info.value.interpretationExperience ?? WorkExperience.None.index]
        .value;
    translationExperience.value.content = WorkExperience
        .values[info.value.translationExperience ?? WorkExperience.None.index]
        .value;
  }

  Future pickAvatar(BuildContext context) async {
    try {
      final source = await imageWidget.showImageSource(context);
      if (source == null) return;

      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      avatar.value = File(image.path);
    } on PlatformException catch (e) {
      print(e);
    }
  }

  //Chọn mặt trước của tài liệu
  Future pickDocumentFrontSide(BuildContext context) async {
    try {
      final source = await imageWidget.showImageSource(context);
      if (source == null) return;

      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      documentFrontSide.value = File(image.path);
    } on PlatformException catch (e) {
      print(e);
    }
  }

  //Chọn mặt sau của tài liệu
  Future pickDocumentBackSide(BuildContext context) async {
    try {
      final source = await imageWidget.showImageSource(context);
      if (source == null) {
        return;
      }

      final image = await ImagePicker().pickImage(source: source);
      if (image == null) {
        return;
      }

      documentBackSide.value = File(image.path);
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future pickImageList(BuildContext context, List<File> files) async {
    try {
      final source = await imageWidget.showImageSource(context);
      if (source == null) {
        return;
      }

      final image = await ImagePicker().pickImage(source: source);
      if (image == null) {
        return;
      }

      final imageTmp = File(image.path);
      files.add(imageTmp);
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future pickListFilePdf(BuildContext context, List<File> files) async {
    try {
      final result = await FilePicker.platform.pickFiles();
      if (result != null) {
        final file = File(result.files.single.path!);
        files.add(file);
      } else {
        // User canceled the picker
      }
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future<void> removeFile(int index, List<File> files) async {
    try {
      files.removeAt(index);
    } catch (e) {
      await EasyLoading.dismiss();
    }
  }

  Future selectGender(int value) async {
    genderId.value = value;
  }

  Future<void> showDate(BuildContext context) async {
    await DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      onConfirm: (date) {
        birthDay.value = DateFormatter.formatDate(date);
      },
      currentTime: DateTime.now(),
    );
  }

  Future<void> loadAddress(String keyword) async {
    try {
      province.text = '';
      district.text = '';
      if (keyword != '') {
        await _uiRepository.addressList(20, 0, keyword).then((response) {
          if (response.status == CommonConstants.statusOk &&
              response.data != null &&
              response.data!.rows != null &&
              response.data!.rows!.isNotEmpty) {
            addressList.value = response.data!.rows!;
            showSuggest.value = 1;
          }
        });
      }
    } catch (e) {
      await EasyLoading.dismiss();
    }
  }

  Future<void> getBank(BuildContext context) async {
    try {
      await EasyLoading.show();
      await _uiRepository.banks().then((response) {
        EasyLoading.dismiss();
        if (response.status == CommonConstants.statusOk &&
            response.data != null &&
            response.data!.rows != null) {
          lstBanks = response.data!.rows!;
          return;
        }
      });
      await ShowBottomSheet().showBottomSheet(
        child: Container(
          height: Get.height / 2,
          child: BanksWidget(
            banks: lstBanks,
            currentId: bankId,
          ),
        ),
        context: context,
        onValue: (_value) {
          if (_value != null && _value is BankLocalModel) {
            bankId = _value.id;
            bankName.value = _value.name ?? '';
          }
        },
      );
    } catch (e) {
      await EasyLoading.dismiss();
    }
  }

  Future<void> selectAddress(AddressModel item) async {
    try {
      zipCode.text = item.code!;
      province.text = item.provinceName!;
      district.text = item.districtName!;
      addressId = item.id!;
      address.text = item.address!;
      showSuggest.value = 0;
    } catch (e) {
      await EasyLoading.dismiss();
    }
  }

  void closeSuggest() {
    showSuggest.value = 0;
  }

  Future<void> getNumberYearsInJapan(BuildContext context) async {
    await ShowBottomSheet().showBottomSheet(
        child: Container(
          width: double.infinity,
          height: Get.height / 2,
          child: DataFormWidget(
            dataList: numberYearJapanDataList,
            title: 'profile.update.number_years_in_japan'.tr,
          ),
        ),
        context: context,
        onValue: (value) {
          if (value != null && value is Time) {
            isNumberYearsInJapanClicked.value = true;
            numberYearsInJapan.value = value;
            log('Number is japan: ${isNumberYearsInJapanClicked.value} - ${value.experienceCode}  ${value.content}');
          }
        });
  }

  Future<void> getTranslationExperience(BuildContext context) async {
    await ShowBottomSheet().showBottomSheet(
        child: Container(
          width: double.infinity,
          height: Get.height / 2,
          child: DataFormWidget(
            dataList: translationExperienceDataList,
            title: 'profile.update.translation_experience'.tr,
          ),
        ),
        context: context,
        onValue: (value) {
          if (value != null && value is Time) {
            isTranslatationExperienceClicked.value = true;
            translationExperience.value = value;
            log('Translation experience: ${isTranslatationExperienceClicked.value} - ${value.experienceCode}  ${value.content}');
          }
        });
  }

  Future<void> getInterpretationExperience(BuildContext context) async {
    await ShowBottomSheet().showBottomSheet(
        child: Container(
          width: double.infinity,
          height: Get.height / 2,
          child: DataFormWidget(
            dataList: interpretationExperienceDataList,
            title: 'profile.update.interpreting_experience'.tr,
          ),
        ),
        context: context,
        onValue: (value) {
          if (value != null && value is Time) {
            isInterpretationExperienceClicked.value = true;
            interpretationExperience.value = value;
            log('Interpretation experience: ${isInterpretationExperienceClicked.value} - ${value.experienceCode}  ${value.content}');
          }
        });
  }

  Future<void> updated() async {
    documentListFiles.addAll(curriculumVitae);
    documentListFiles.addAll(degree);
    documentListFiles.addAll(workExperiences);
    log('List file: $documentListFiles');
    try {
      await EasyLoading.show();
      if (updateForm.currentState?.validate() ?? false) {
        var msg = '';
        if (avatar.value == null) {
          msg = 'profile.update.avatar_required'.tr;
        } else if (documentFrontSide.value == null) {
          msg = 'profile.update.front_side_required'.tr;
        } else if (documentBackSide.value == null) {
          msg = 'profile.update.back_side_required'.tr;
        } else if (numberYearsInJapan.value.content == '') {
          msg = 'profile.update.number_years_in_japan_required'.tr;
        } else if (interpretationExperience.value.content == '') {
          msg = 'profile.update.interpretation_experience_required'.tr;
        } else if (translationExperience.value.content == '') {
          msg = 'profile.update.translation_experience_required'.tr;
        }
        if (msg != '') {
          await EasyLoading.dismiss();
          await DialogUtil.showPopup(
            dialogSize: DialogSize.Popup,
            barrierDismissible: false,
            backgroundColor: Colors.transparent,
            child: NormalWidget(
              icon: IconConstants.icFail,
              title: msg,
            ),
            onVaLue: (value) {},
          );
          return;
        }

        await _uiRepository
            .updateProfile(
          avatar.value,
          name.text,
          genderId.value,
          birthDay.value,
          email.text,
          phone.text,
          bankId ?? 0,
          bankBranchName.text,
          bankAccountHolder.text,
          bankAccountNumber.text,
          addressId,
          address.text,
          station.text,
          documentFrontSide.value,
          documentBackSide.value,
          education.text,
          documentListFiles,
          level.text,
          experience.text,
          numberYearsInJapan.value.experienceCode,
          translationExperience.value.experienceCode,
          interpretationExperience.value.experienceCode,
          translationExperienceDetail.text.isNotEmpty
              ? translationExperienceDetail.text
              : '',
          interpretingExperienceDetail.text.isNotEmpty
              ? interpretingExperienceDetail.text
              : '',
          curriculumVitae,
          workExperiences,
        )
            .then((response) {
          EasyLoading.dismiss();
          DialogUtil.showPopup(
            dialogSize: DialogSize.Popup,
            barrierDismissible: false,
            backgroundColor: Colors.transparent,
            child: NormalWidget(
              icon: response.status == CommonConstants.statusOk
                  ? IconConstants.icSuccess
                  : IconConstants.icFail,
              title: response.message,
            ),
            onVaLue: (value) {
              if (response.status == CommonConstants.statusOk) {
                Get.toNamed(Routes.SERVICE);
              }
            },
          );
        });
      } else {
        await EasyLoading.dismiss();
      }
    } catch (e) {
      await EasyLoading.dismiss();
    }
  }

  String getFileName(String filePath) {
    return filePath.split('/').last;
  }

  void chooseTime(int currentIndex, List<Time> timeDataList) {
    timeDataList[currentIndex].isFeatured = true;
    timeDataList[preIndex].isFeatured = false;
    preIndex = currentIndex;
    resultValue.value = timeDataList[currentIndex];
    update();
  }

  @override
  void onClose() {
    numberYearJapanDataList.clear();
    interpretationExperienceDataList.clear();
    translationExperienceDataList.clear();

    numberYearJapanDataList.close();
    interpretationExperienceDataList.close();
    translationExperienceDataList.close();
  }
}
