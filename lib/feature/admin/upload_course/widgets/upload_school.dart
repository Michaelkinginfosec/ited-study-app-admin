import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ited_study_app_admin/core/constants/boxsize.dart';
import 'package:ited_study_app_admin/core/constants/style.dart';
import 'package:ited_study_app_admin/core/widgets/form_field.dart';
import 'package:ited_study_app_admin/feature/admin/upload_course/presentation/provider/school_provider.dart';

class UploadSchool extends ConsumerStatefulWidget {
  const UploadSchool({super.key});

  @override
  ConsumerState<UploadSchool> createState() => UploadSchoolState();
}

class UploadSchoolState extends ConsumerState<UploadSchool> {
  final TextEditingController _schooolController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool isObscure = false;
  String? selectedCountry;
  List<String> countryNames = [];

  @override
  void initState() {
    super.initState();
    _loadCountryList();
  }

  Future<void> _loadCountryList() async {
    var box = Hive.box('notes');

    List<Map<String, String>> currentCountryList =
        (box.get('countryList', defaultValue: []) as List)
            .map((e) => Map<String, String>.from(e))
            .toList();

    setState(() {
      countryNames =
          currentCountryList.map((country) => country.keys.first).toList();
    });
  }

  Future<String?> getCountryIdByName(String countryName) async {
    var box = Hive.box('notes');

    List<Map<String, String>> currentCountryList =
        (box.get('countryList', defaultValue: []) as List)
            .map((e) => Map<String, String>.from(e))
            .toList();

    for (var country in currentCountryList) {
      if (country.containsKey(countryName)) {
        return country[countryName];
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final schoolState = ref.watch(schoolNotifierProvider);
    ref.listen(
      schoolNotifierProvider,
      (previous, next) {
        if (next.status == SchoolStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(next.message ?? "School Created Successfully"),
            ),
          );
        } else if (next.status == SchoolStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(next.error ?? "Error"),
            ),
          );
        } else if (next.status == SchoolStatus.loading) {
          Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
      },
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 450, vertical: 250),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(189, 193, 200, 1),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Add  University",
                  style: CustomStyle.mediumSubtitleText,
                ),
                CustomBoxSize.big,
                Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child: Column(
                      children: [
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            label: Text("Select Country"),
                            hintStyle: const TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontSize: 10,
                            ),
                            contentPadding:
                                const EdgeInsets.only(left: 10, right: 10),
                            hintText: 'Select Country',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(0, 5, 45, 1),
                                width: 1,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(0, 5, 45, 1),
                                width: 1,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(0, 5, 45, 1),
                                width: 1,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(0, 5, 45, 1),
                                width: 1,
                              ),
                            ),
                            enabled: true,
                          ),
                          hint: Text('Select a Country'),
                          value: selectedCountry,
                          items: countryNames.map((String countryName) {
                            return DropdownMenuItem<String>(
                              value: countryName,
                              child: Text(countryName),
                            );
                          }).toList(),
                          onChanged: (String? newCountry) async {
                            setState(() {
                              selectedCountry = newCountry;
                            });
                            if (newCountry != null) {
                              await getCountryIdByName(newCountry);
                            }
                          },
                        ),
                        CustomBoxSize.medium,
                        CustomFormField(
                          label: "School",
                          obscure: isObscure,
                          controller: _schooolController,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter School ";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                CustomBoxSize.medium,
                schoolState.status == SchoolStatus.loading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 80,
                        ),
                        child: InkWell(
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              if (selectedCountry != null) {
                                ref
                                    .read(schoolNotifierProvider.notifier)
                                    .school(_schooolController.text,
                                        selectedCountry!);
                              }
                            }
                          },
                          child: Container(
                            height: 40,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color.fromRGBO(0, 16, 147, 1),
                                  Color.fromRGBO(0, 5, 45, 1),
                                ],
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "Add School",
                                style: CustomStyle.loginStyle,
                              ),
                            ),
                          ),
                        ),
                      ),
                CustomBoxSize.big,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
