import '../repository/course_repository.dart';

class CountryUsecase {
  final CourseRepository _countryRepository;
  CountryUsecase(this._countryRepository);

  Future<void> country(String country) async {
    return await _countryRepository.country(country);
  }
}
