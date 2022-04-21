import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:stream_chat/stream_chat.dart';
import 'package:ui_api/models/user/address_model.dart';
import 'package:ui_api/models/user/documents_certificate_model.dart';
import 'package:ui_api/models/user/user_services_model.dart';
import 'package:ui_api/models/user/user_time_model.dart';
import 'package:ui_api/models/user/workplaces_model.dart';

import '../chat/conversation_info_model.dart';
part 'user_info_model.g.dart';

@JsonSerializable()
class UserInfoModel {
  int? id;
  @JsonKey(name: 'avatar_image', defaultValue: '')
  String? avatarImage;
  String? name;
  int? gender;
  @JsonKey(name: 'date_of_birth', defaultValue: '')
  String? dateOfBirth;
  String? email;
  @JsonKey(name: 'phone_number', defaultValue: '')
  String? phoneNumber;
  @JsonKey(name: 'bank_name', defaultValue: '')
  String? bankName;
  @JsonKey(name: 'bank_branch_name', defaultValue: '')
  String? bankBranchName;
  @JsonKey(name: 'bank_account_holder', defaultValue: '')
  String? bankAccountHolder;
  @JsonKey(name: 'bank_account_number', defaultValue: '')
  String? bankAccountNumber;
  AddressModel? address;
  @JsonKey(name: 'nearest_station', defaultValue: '')
  String? nearestStation;
  @JsonKey(name: 'document_front_side', defaultValue: '')
  String? documentFrontSide;
  @JsonKey(name: 'document_back_side', defaultValue: '')
  String? documentBackSide;
  String? education;
  @JsonKey(name: 'documents_certificate')
  List<DocumentsCertificateModel>? documentsCertificate;
  String? level;
  String? experience;
  @JsonKey(name: 'number_of_years_in_japan')
  int? numberOfYearsInJapan;
  @JsonKey(name: 'interpretation_experience')
  int? interpretationExperience;
  @JsonKey(name: 'translation_experience')
  int? translationExperience;
  @JsonKey(name: 'interpretation_experience_detail')
  String? interpretationExperienceDetail;
  @JsonKey(name: 'translation_experience_detail')
  String? translationExperienDetail;
  List<UserServicesCategoryModel>? services;
  List<WorkplacesModel>? workplaces;
  @JsonKey(name: 'user_time')
  List<UserTimeModel>? userTime;
  @JsonKey(name: 'kyc_status')
  int? kycStatus;
  @JsonKey(name: 'is_update')
  int? isUpdate;
  @JsonKey(name: 'conversation_info')
  ConversationInfoModel? conversationInfo;

  UserInfoModel({
    this.id,
    this.avatarImage,
    this.name,
    this.gender,
    this.dateOfBirth,
    this.email,
    this.phoneNumber,
    this.bankName,
    this.bankBranchName,
    this.bankAccountHolder,
    this.bankAccountNumber,
    this.address,
    this.nearestStation,
    this.documentFrontSide,
    this.documentBackSide,
    this.education,
    this.documentsCertificate,
    this.level,
    this.experience,
    this.numberOfYearsInJapan,
    this.interpretationExperience,
    this.translationExperience,
    this.interpretationExperienceDetail,
    this.translationExperienDetail,
    this.services,
    this.workplaces,
    this.userTime,
    this.kycStatus,
    this.isUpdate,
    this.conversationInfo,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) =>
      _$UserInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoModelToJson(this);

  User getChatUser() {
    return User(
      id: id.toString(),
      name: name,
      image: avatarImage,
    );
  }
}
