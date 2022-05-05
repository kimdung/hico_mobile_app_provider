class Time {
  String content = '';
  int experienceCode = 0;
  bool isFeatured = false;

  Time(
      {required this.content,
      required this.experienceCode,
      required this.isFeatured});
}

final translatationExperiences = [
  Time(
    content: 'Chưa có kinh nghiệm',
    experienceCode: 1,
    isFeatured: false,
  ),
  Time(content: '1-3 năm', experienceCode: 2, isFeatured: false),
  Time(content: '4-6 năm', experienceCode: 3, isFeatured: false),
  Time(content: '7-10 năm', experienceCode: 4, isFeatured: false),
  Time(content: 'Trên 10 năm', experienceCode: 5, isFeatured: false),
];

final interpretationExperiences = [
  Time(content: 'Chưa có kinh nghiệm', experienceCode: 1, isFeatured: false),
  Time(content: '1-3 năm', experienceCode: 2, isFeatured: false),
  Time(content: '4-6 năm', experienceCode: 3, isFeatured: false),
  Time(content: '7-10 năm', experienceCode: 4, isFeatured: false),
  Time(content: 'Trên 10 năm', experienceCode: 5, isFeatured: false),
];

final numberYearsInJapanList = [
  Time(content: 'Chưa đến Nhật', experienceCode: 1, isFeatured: false),
  Time(content: '1-3 năm', experienceCode: 2, isFeatured: false),
  Time(content: '4-6 năm', experienceCode: 3, isFeatured: false),
  Time(content: '7-10 năm', experienceCode: 4, isFeatured: false),
  Time(content: 'Trên 10 năm', experienceCode: 5, isFeatured: false),
];
