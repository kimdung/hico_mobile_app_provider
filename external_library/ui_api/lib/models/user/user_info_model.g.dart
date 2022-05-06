// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoModel _$UserInfoModelFromJson(Map<String, dynamic> json) =>
    UserInfoModel(
      id: json['id'] as int?,
      avatarImage: json['avatar_image'] as String? ?? '',
      name: json['name'] as String?,
      gender: json['gender'] as int?,
      dateOfBirth: json['date_of_birth'] as String? ?? '',
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as String? ?? '',
      bankId: json['bank_id'] as int?,
      bankName: json['bank_name'] as String? ?? '',
      bankBranchName: json['bank_branch_name'] as String? ?? '',
      bankAccountHolder: json['bank_account_holder'] as String? ?? '',
      bankAccountNumber: json['bank_account_number'] as String? ?? '',
      address: json['address'] == null
          ? null
          : AddressModel.fromJson(json['address'] as Map<String, dynamic>),
      nearestStation: json['nearest_station'] as String? ?? '',
      documentFrontSide: json['document_front_side'] as String? ?? '',
      documentBackSide: json['document_back_side'] as String? ?? '',
      education: json['education'] as String?,
      documentsCertificate: (json['documents_certificate'] as List<dynamic>)
          .map((e) =>
              DocumentsCertificateModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      level: json['level'] as String?,
      experience: json['experience'] as String?,
      numberOfYearsInJapan: json['number_of_years_in_japan'] as int?,
      interpretationExperience: json['interpretation_experience'] as int?,
      translationExperience: json['translation_experience'] as int?,
      interpretationExperienceDetail:
          json['interpretation_experience_detail'] as String?,
      translationExperienDetail:
          json['translation_experience_detail'] as String?,
      services: (json['services'] as List<dynamic>?)
          ?.map((e) =>
              UserServicesCategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      workplaces: (json['workplaces'] as List<dynamic>?)
          ?.map((e) => WorkplacesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      userTime: (json['user_time'] as List<dynamic>?)
          ?.map((e) => UserTimeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      kycStatus: json['kyc_status'] as int?,
      isUpdate: json['is_update'] as int?,
      conversationInfo: json['conversation_info'] == null
          ? null
          : ConversationInfoModel.fromJson(
              json['conversation_info'] as Map<String, dynamic>),
      accountBalance: json['account_balance'] as int?,
    );

Map<String, dynamic> _$UserInfoModelToJson(UserInfoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'avatar_image': instance.avatarImage,
      'name': instance.name,
      'gender': instance.gender,
      'date_of_birth': instance.dateOfBirth,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'bank_id': instance.bankId,
      'bank_name': instance.bankName,
      'bank_branch_name': instance.bankBranchName,
      'bank_account_holder': instance.bankAccountHolder,
      'bank_account_number': instance.bankAccountNumber,
      'address': instance.address,
      'nearest_station': instance.nearestStation,
      'document_front_side': instance.documentFrontSide,
      'document_back_side': instance.documentBackSide,
      'education': instance.education,
      'documents_certificate': instance.documentsCertificate,
      'level': instance.level,
      'experience': instance.experience,
      'number_of_years_in_japan': instance.numberOfYearsInJapan,
      'interpretation_experience': instance.interpretationExperience,
      'translation_experience': instance.translationExperience,
      'interpretation_experience_detail':
          instance.interpretationExperienceDetail,
      'translation_experience_detail': instance.translationExperienDetail,
      'services': instance.services,
      'workplaces': instance.workplaces,
      'user_time': instance.userTime,
      'kyc_status': instance.kycStatus,
      'is_update': instance.isUpdate,
      'conversation_info': instance.conversationInfo,
      'account_balance': instance.accountBalance,
    };
