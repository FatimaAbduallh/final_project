import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project/Core/commn_widgets/custom_button.dart';
import 'package:new_project/Core/commn_widgets/custom_text_field.dart';
import 'package:new_project/features/family_management/logic/mother_cubit.dart';
import 'package:new_project/features/family_management/logic/mother_state.dart';

class MotherForm extends StatelessWidget {
  const MotherForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MotherCubit>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // الاسم الأول والأخير
            Row(
              children: [
                Expanded(
                  child: CustomInputField(
                    controller: cubit.firstNameController,
                    label: 'الاسم الأول',
                    keyboardType: InputType.text,
                    textInputAction: TextInputAction.next,
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'الرجاء إدخال الاسم الأول'
                        : null,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomInputField(
                    controller: cubit.lastNameController,
                    label: 'الاسم الأخير',
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'الرجاء إدخال الاسم الأخير'
                        : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // الجنسية وحالة الوفاة
            Row(
              children: [
                Expanded(
                    flex: 2,
                    child: DropdownButtonFormField<int>(
                      value: cubit.selectedNationalityId,
                      decoration: const InputDecoration(
                        labelText: 'الجنسية',
                        border: OutlineInputBorder(),
                      ),
                      items: cubit.nationalities
                          .map(
                            (nat) => DropdownMenuItem(
                              value: nat.id,
                              child: Text(nat.country_name),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        cubit.selectedNationalityId = value;
                        cubit.emit(MotherFormDataLoaded());
                      },
                      validator: (val) =>
                          val == null ? 'يرجى اختيار الجنسية' : null,
                    )),
                const SizedBox(width: 16),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('هل الأم متوفاه؟'),
                      Switch(
                        value: cubit.isDead,
                        onChanged: cubit.setIsDead,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            if (!cubit.isDead) ...[
              // البريد وتاريخ الميلاد
              Row(
                children: [
                  Expanded(
                    child: CustomInputField(
                      controller: cubit.emailController,
                      label: 'البريد الإلكتروني',
                      keyboardType: InputType.email,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomInputField(
                      controller: cubit.birthDateController,
                      label: 'تاريخ الميلاد',
                      keyboardType: InputType.date,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // المدينة والحي
             Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        DropdownButtonFormField<String>(
                          value: cubit.selectedCity,
                          decoration: const InputDecoration(
                            labelText: 'المدينة',
                            border: OutlineInputBorder(),
                          ),
                          items: cubit.cities
                              .map(
                                (city) => DropdownMenuItem(
                                  value: city.city_name,
                                  child: Text(city.city_name),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value != null) cubit.setCity(value);
                          },
                          validator: (val) =>
                              val == null ? 'يرجى اختيار المدينة' : null,
                        ),

                        const SizedBox(height: 16),

                        // Dropdown الحي
                        DropdownButtonFormField<int>(
                          value: cubit.selectedAreaId,
                          decoration: const InputDecoration(
                            labelText: 'الحي',
                            border: OutlineInputBorder(),
                          ),
                          items: cubit.areas.map((area) {
                            return DropdownMenuItem<int>(
                              value: area.id,
                              child:
                                  Text(area.area_name), // عرض اسم المنطقة فقط
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              cubit.setArea(value);
                            }
                          },
                          validator: (val) =>
                              val == null ? 'يرجى اختيار الحي' : null,
                          selectedItemBuilder: (context) {
                            // هذه هي الإضافة المهمة
                            return cubit.areas.map((area) {
                              return Text(
                                area.area_name,
                                style: Theme.of(context).textTheme.titleMedium,
                              );
                            }).toList();
                          },
                        )
                      ],
                    ),
                  ),
                ],
                

              const SizedBox(height: 20),

              // رقم الهاتف والهوية
              Row(
                children: [
                  Expanded(
                    child: CustomInputField(
                      controller: cubit.phoneController,
                      label: 'رقم الهاتف',
                      keyboardType: InputType.phone,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomInputField(
                      controller: cubit.identityController,
                      label: 'رقم الهوية',
                      keyboardType: InputType.number,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // الجنس والحالة
               // الجنس والحالة
              BlocBuilder<MotherCubit, MotherState>(
                builder: (context, state) {
                  final cubit = context.read<MotherCubit>();

                  return Row(
                    children: [
                      // الجنس
                      Expanded(
                        child: CustomInputField(
                          label: 'الجنس',
                          keyboardType: InputType.radio,
                          radioOptions: const ['ذكر', 'أنثى'],
                          selectedValue: cubit.selectedGender,
                          onChanged: (val) => cubit.setGender(val!),
                        ),
                      ),

                      const SizedBox(width: 16),

                      // الحالة
                      Expanded(
                        child: CustomInputField(
                          label: 'الحالة',
                          keyboardType: InputType.radio,
                          radioOptions: const ['غير نشط', 'نشط'],
                          selectedValue:
                              cubit.is_Active == 1 ? 'نشط' : 'غير نشط',
                          onChanged: (val) {
                            cubit.setIsActive(val == 'نشط' ? 1 : 0);
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 20),

              // عدد الأطفال
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'عدد الأطفال',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onChanged: cubit.setChildCount,
              ),
              const SizedBox(height: 20),

              // زر الحفظ
            SizedBox(
                width: double.infinity,
                child: CustomButton(
                  text: 'حفظ البيانات',
                  onPressed: () => cubit.submitMother(context),
                ),
              ),
            ],
        ),
      ),
    );
  }
}
