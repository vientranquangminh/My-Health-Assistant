import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:my_health_assistant/src/pages/admin/admin_screen.dart';
import 'package:my_health_assistant/src/pages/admin/widget/appbar_admin.dart';
import 'package:my_health_assistant/src/pages/admin/widget/button_add_account.dart';
import 'package:my_health_assistant/src/pages/admin/widget/doctor/doctor_object.dart';
import 'package:my_health_assistant/src/styles/colors.dart';
import 'package:my_health_assistant/src/styles/font_styles.dart';
import 'package:my_health_assistant/src/widgets/buttons/my_elevated_button.dart';

class DoctorPage extends StatelessWidget {
  const DoctorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppBarAdmin(),
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Doctor',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w800),
                        ),
                        Text(
                          'Manage All Doctor',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w800),
                        )
                      ]),
                ),
                const ButtonAddAccountDoctor(),
                const SizedBox(height: 10),
                Container(
                  height: MediaQuery.of(context).size.height / 1.5,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: const [
                            TitleAdminScreen(
                              title: 'ID',
                              width: 50,
                            ),
                            TitleAdminScreen(
                              title: 'Doctor Name',
                              width: 200,
                            ),
                            TitleAdminScreen(
                              title: 'Department',
                              width: 150,
                            ),
                            TitleAdminScreen(
                              title: 'Email',
                              width: 250,
                            ),
                            TitleAdminScreen(
                              title: 'Day Of Birth',
                              width: 150,
                            ),
                            TitleAdminScreen(
                              title: 'Phone Number',
                              width: 170,
                            ),
                            TitleAdminScreen(
                              title: 'Gender',
                              width: 150,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 16),
                                child: Row(
                                  children: [
                                    SizedBox(
                                        width: 50,
                                        child: Text(listDoctor[index].id,
                                            style: MyFontStyles.blackColorH2)),
                                    SizedBox(
                                        width: 200,
                                        child: Text(listDoctor[index].name,
                                            style: MyFontStyles.blackColorH2)),
                                    SizedBox(
                                        width: 150,
                                        child: Text(
                                            listDoctor[index].department,
                                            style: MyFontStyles.blackColorH2)),
                                    SizedBox(
                                        width: 250,
                                        child: Text(listDoctor[index].email,
                                            style: MyFontStyles.blackColorH2)),
                                    SizedBox(
                                        width: 150,
                                        child: Text(
                                            listDoctor[index].dayOfBirth,
                                            style: MyFontStyles.blackColorH2)),
                                    SizedBox(
                                        width: 170,
                                        child: Text(listDoctor[index].phone,
                                            style: MyFontStyles.blackColorH2)),
                                    SizedBox(
                                        width: 150,
                                        child: Text(listDoctor[index].gender,
                                            style: MyFontStyles.blackColorH2)),
                                    SizedBox(
                                      child: Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(Icons.delete)),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(Icons.edit))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => const Divider(
                                  thickness: 2,
                                ),
                            itemCount: listDoctor.length),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
