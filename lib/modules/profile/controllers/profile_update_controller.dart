import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ui_api/models/master_data/bank_model.dart';
import 'package:ui_api/models/user/address_model.dart';
import 'package:ui_api/models/user/user_info_model.dart';
import 'package:ui_api/repository/hico_ui_repository.dart';

import '../../../base/base_controller.dart';
import '../../../data/app_data_global.dart';
import '../../../models/time.dart';
import '../../../resource/assets_constant/icon_constants.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/constants/common.dart';
import '../../../shared/utils/date_formatter.dart';
import '../../../shared/utils/dialog_util.dart';
import '../../../shared/widget_hico/data_general/banks.dart';
import '../../../shared/widget_hico/data_general/data_form_widget.dart';
import '../../../shared/widget_hico/dialog/normal_widget.dart';
import '../../../shared/widgets/image_widget/image_widget.dart';
import '../../../shared/widgets/showbottom_sheet/show_bottom_sheet.dart';

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
  final documentFrontSide = Rx<File>(File(''));
  final documentBackSide = Rx<File>(File(''));
  final updateForm = GlobalKey<FormState>();
  final TextEditingController zipCode = TextEditingController();
  final TextEditingController province = TextEditingController();
  final TextEditingController district = TextEditingController();

  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
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

  //bank
  Rx<String> bankName = Rx('');
  int? bankId;
  List<BankLocalModel> lstBanks = [];
  //*******/

  /* year in japan */
  Rx<int> isNumberYearsInJapan = Rx(0);
  Rx<int> isInterpretationExperience = Rx(0);
  Rx<int> isTranslatationExperience = Rx(0);
  /*end year in japan*/

  RxList<Time> numberYearJapanDataList = RxList(numberYearsInJapanList);
  RxList<Time> interpretationExperienceDataList =
      RxList(interpretationExperiences);
  RxList<Time> translationExperienceDataList = RxList(translatationExperiences);

  //remove data
  List<String> removeCurriculumVitaeFiles = [];
  List<String> removeWorkExperienceFiles = [];
  List<int> removeDocumentsCertificate = [];

  int preIndex = 0;

  ProfileUpDateController() {
    _loadData();
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
    level.text = info.value.level ?? '';
    bankId = info.value.bankId ?? 0;
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

    isNumberYearsInJapan.value = info.value.numberOfYearsInJapan ?? 0;
    isInterpretationExperience.value = info.value.interpretationExperience ?? 0;
    isTranslatationExperience.value = info.value.translationExperience ?? 0;
  }

  /*Change avatar */
  Future pickAvatar(BuildContext context) async {
    try {
      final source = await imageWidget.showImageSource(context);
      if (source == null) return;

      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      //call api
      await updateAvatar(imageTemporary);
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future updateAvatar(File image) async {
    try {
      await EasyLoading.show();
      await _uiRepository.updateAvatar(image).then((response) {
        EasyLoading.dismiss();
        if (response.status == CommonConstants.statusOk) {
          info.value = response.data!.info!;
          info.refresh();
          AppDataGlobal.userInfo = info.value;
        }
      });
    } catch (e) {
      await EasyLoading.dismiss();
    }
  }
  /*End change avatar*/

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

  /* Choose gender */
  Future selectGender(int value) async {
    genderId.value = value;
  }

  /* End choose gender */
  /* Choose birthday */
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

  /* End choose birthday */
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

  void closeSuggest() {
    showSuggest.value = 0;
  }

  Future<void> getNumberYearsInJapan(BuildContext context) async {
    await ShowBottomSheet().showBottomSheet(
        child: Container(
          width: double.infinity,
          height: Get.height / 1.7,
          child: DataFormWidget(
            dataList: numberYearJapanDataList
                .where((p0) => p0.experienceCode != 0)
                .toList(),
            title: 'profile.update.number_years_in_japan'.tr,
            currentSelected: isNumberYearsInJapan.value,
          ),
        ),
        context: context,
        onValue: (value) {
          if (value != null && value is int) {
            isNumberYearsInJapan.value = value;
          }
        });
  }

  Future<void> getTranslationExperience(BuildContext context) async {
    await ShowBottomSheet().showBottomSheet(
        child: Container(
          width: double.infinity,
          height: Get.height / 1.7,
          child: DataFormWidget(
            dataList: translationExperienceDataList
                .where((p0) => p0.experienceCode != 0)
                .toList(),
            title: 'profile.update.translation_experience'.tr,
            currentSelected: isTranslatationExperience.value,
          ),
        ),
        context: context,
        onValue: (value) {
          if (value != null && value is int) {
            isTranslatationExperience.value = value;
          }
        });
  }

  Future<void> getInterpretationExperience(BuildContext context) async {
    await ShowBottomSheet().showBottomSheet(
        child: Container(
          width: double.infinity,
          height: Get.height / 1.7,
          child: DataFormWidget(
            dataList: interpretationExperienceDataList
                .where((p0) => p0.experienceCode != 0)
                .toList(),
            title: 'profile.update.interpreting_experience'.tr,
            currentSelected: isInterpretationExperience.value,
          ),
        ),
        context: context,
        onValue: (value) {
          if (value != null && value is int) {
            isInterpretationExperience.value = value;
          }
        });
  }

  Future<void> updated() async {
    try {
      //await EasyLoading.show();
      if (updateForm.currentState?.validate() ?? false) {
        var msg = '';
        if (info.value.documentFrontSide.isEmpty &&
            documentFrontSide.value.path == '') {
          msg = 'profile.update.front_side_required'.tr;
        } else if (info.value.documentBackSide.isEmpty &&
            documentBackSide.value.path == '') {
          msg = 'profile.update.back_side_required'.tr;
        } else if (isNumberYearsInJapan.value == 0) {
          msg = 'profile.update.number_years_in_japan_required'.tr;
        } else if (isInterpretationExperience.value == 0) {
          msg = 'profile.update.interpretation_experience_required'.tr;
        } else if (isTranslatationExperience.value == 0) {
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
          documentFrontSide.value.path.isNotEmpty
              ? documentFrontSide.value
              : null,
          documentBackSide.value.path.isNotEmpty
              ? documentBackSide.value
              : null,
          education.text,
          level.text,
          experience.text,
          isNumberYearsInJapan.value,
          isTranslatationExperience.value,
          isInterpretationExperience.value,
          translationExperienceDetail.text.isNotEmpty
              ? translationExperienceDetail.text
              : '',
          interpretingExperienceDetail.text.isNotEmpty
              ? interpretingExperienceDetail.text
              : '',
          removeCurriculumVitaeFiles
              .toString()
              .replaceAll('[', '')
              .replaceAll(']', ''),
          removeWorkExperienceFiles
              .toString()
              .replaceAll('[', '')
              .replaceAll(']', ''),
          removeDocumentsCertificate,
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
                removeCurriculumVitaeFiles = [];
                removeWorkExperienceFiles = [];
                removeDocumentsCertificate = [];
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
      await DialogUtil.showPopup(
        dialogSize: DialogSize.Popup,
        barrierDismissible: false,
        backgroundColor: Colors.transparent,
        child: NormalWidget(
          icon: IconConstants.icFail,
          title: 'notif.error'.tr,
        ),
        onVaLue: (value) {},
      );
    }
  }

  String getFileName(String filePath) {
    return filePath.split('/').last;
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

  //upload file
  Future pickFile(int type) async {
    try {
      final result = await FilePicker.platform.pickFiles();
      if (result != null) {
        final file = File(result.files.single.path!);
        await updateFile(file, type);
      }
    } on PlatformException catch (e) {
      log(e.message.toString());
    }
  }

  Future updateFile(File file, int type) async {
    try {
      await EasyLoading.show();
      await _uiRepository.uploadFile(file, type).then((response) {
        EasyLoading.dismiss();
        if (response.status == CommonConstants.statusOk) {
          if (type == CommonConstants.curriculumVitaeFiles) {
            info.value.curriculumVitaeFiles!.add(response.data!);
          } else {
            info.value.workExperienceFiles!.add(response.data!);
          }
          info.refresh();
          AppDataGlobal.userInfo = info.value;
        } else {
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
            onVaLue: (value) {},
          );
          return;
        }
      });
    } catch (e) {
      await EasyLoading.dismiss();
    }
  }

  Future<void> onRemoveFile(int index, int type) async {
    try {
      if (type == CommonConstants.curriculumVitaeFiles) {
        removeCurriculumVitaeFiles.add(info.value.curriculumVitaeFiles![index]);
        info.value.curriculumVitaeFiles!.removeAt(index);
      } else {
        removeWorkExperienceFiles.add(info.value.workExperienceFiles![index]);
        info.value.workExperienceFiles!.removeAt(index);
      }
      info.refresh();
    } catch (e) {
      await EasyLoading.dismiss();
    }
  }

  //file cetificate
  Future pickCetificateImage(BuildContext context) async {
    try {
      final source = await imageWidget.showImageSource(context);
      if (source != null) {
        final image = await ImagePicker().pickImage(source: source);
        if (image != null) {
          final imageTemporary = File(image.path);
          //call api
          await updateCetificateFile(imageTemporary, 1);
        }
      }
    } on PlatformException catch (e) {
      log(e.message.toString());
    }
  }

  Future pickCetificateFile() async {
    try {
      final result = await FilePicker.platform.pickFiles();
      if (result != null) {
        final file = File(result.files.single.path!);
        await updateCetificateFile(file, 2);
      }
    } on PlatformException catch (e) {
      log(e.message.toString());
    }
  }

  Future updateCetificateFile(File file, int type) async {
    try {
      await EasyLoading.show();
      await _uiRepository.uploadCetificateFile(file, type).then((response) {
        EasyLoading.dismiss();
        if (response.status == CommonConstants.statusOk) {
          info.value.documentsCertificate.add(response.data!);
          info.refresh();
          AppDataGlobal.userInfo = info.value;
        } else {
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
            onVaLue: (value) {},
          );
          return;
        }
      });
    } catch (e) {
      await EasyLoading.dismiss();
    }
  }

  Future<void> onRemoveCetificateFile(int index) async {
    try {
      removeDocumentsCertificate
          .add(info.value.documentsCertificate[index].id!);
      info.value.documentsCertificate.removeAt(index);
      info.refresh();
    } catch (e) {
      await EasyLoading.dismiss();
    }
  }
}
