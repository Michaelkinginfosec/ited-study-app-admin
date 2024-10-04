import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ited_study_app_admin/core/constants/boxsize.dart';
import 'package:ited_study_app_admin/core/constants/style.dart';
import 'package:ited_study_app_admin/core/widgets/form_field.dart';

import '../presentation/provider/country_provider.dart';

class UploadCountry extends ConsumerStatefulWidget {
  const UploadCountry({super.key});

  @override
  ConsumerState<UploadCountry> createState() => UploadCountryState();
}

class UploadCountryState extends ConsumerState<UploadCountry> {
  final TextEditingController _countryController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool isObscure = false;

  @override
  Widget build(BuildContext context) {
    final countryState = ref.watch(countryNotifierProvider);
    ref.listen(
      countryNotifierProvider,
      (previous, next) {
        if (next.status == CountryStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(next.message ?? "Country Created Successfully"),
            ),
          );
        } else if (next.status == CountryStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(next.error ?? "Error"),
            ),
          );
        }
      },
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 450, vertical: 250),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
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
              CustomBoxSize.medium,
              Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child: Column(
                    children: [
                      CustomBoxSize.medium,
                      CustomFormField(
                        label: "Country",
                        obscure: isObscure,
                        controller: _countryController,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter Country Name";
                          }
                          return null;
                        },
                      ),
                      CustomBoxSize.medium,
                    ],
                  ),
                ),
              ),
              CustomBoxSize.medium,
              countryState.status == CountryStatus.loading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 80),
                      child: InkWell(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            ref
                                .read(countryNotifierProvider.notifier)
                                .country(_countryController.text);
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
                              "Add Country",
                              style: CustomStyle.loginStyle,
                            ),
                          ),
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
