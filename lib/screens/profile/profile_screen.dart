import 'package:flutter/material.dart';
import 'package:food_couriers/components/back_notification_row.dart';
import 'package:food_couriers/constants/colors/app_colors.dart';
import 'package:food_couriers/constants/images/images.dart';
import 'package:food_couriers/screens/profile/widgets/custom_button.dart';
import 'package:food_couriers/screens/profile/widgets/list_container.dart';
import 'package:food_couriers/screens/profile/widgets/list_data.dart';
import 'package:food_couriers/screens/profile/widgets/list_item_row.dart';
import 'package:food_couriers/screens/profile/widgets/list_label.dart';
import 'package:food_couriers/screens/profile/widgets/pfp_box.dart';
import 'package:food_couriers/screens/profile/widgets/subheading_text.dart';
// import 'package:food_couriers/screens/profile_screen/widgets/switch_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
    required this.index,
    required this.onTapBack,
    required this.dismissKeyboard,
  });

  final int index;
  final void Function(int) onTapBack;
  final VoidCallback dismissKeyboard;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _occupationController;
  late TextEditingController _employerController;
  late TextEditingController _numberController;
  late TextEditingController _emailController;

  // bool _switchValue = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: 'Joyce Johnson');
    _occupationController = TextEditingController(text: 'Manager');
    _employerController = TextEditingController(text: 'Food Couriers');
    _numberController = TextEditingController(text: '+234 813 0400 445');
    _emailController = TextEditingController(text: 'ekamcy@mail.com');
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _occupationController.dispose();
    _employerController.dispose();
    _numberController.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                Images.primaryPattern,
                alignment: Alignment.topRight,
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  BackNotificationRow(
                    index: widget.index,
                    onTapBack: () async {
                      widget.dismissKeyboard();
                      await Future.delayed(
                        const Duration(
                          milliseconds: 90,
                        ),
                      );
                      widget.onTapBack(widget.index);
                    },
                    onTapNotification: () {},
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 32),
                    child: const Text(
                      'Profile',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        height: 32.76 / 25,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          PfpBox(
                            imageURL: Images.person,
                            onTap: () {},
                          ),
                          Column(
                            children: [
                              const SubheadingText(
                                text: 'Personal Info',
                              ),
                              ListContainer(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListItemRow(
                                      label: const ListLabel(text: 'Your name'),
                                      data: ListData(
                                        textEditingController: _nameController,
                                        readOnly: false,
                                        keyboardType: TextInputType.name,
                                      ),
                                    ),
                                    ListItemRow(
                                      label:
                                          const ListLabel(text: 'Occupation'),
                                      data: ListData(
                                        textEditingController:
                                            _occupationController,
                                        readOnly: false,
                                        keyboardType: TextInputType.text,
                                      ),
                                    ),
                                    ListItemRow(
                                      label: const ListLabel(text: 'Employer'),
                                      data: ListData(
                                        textEditingController:
                                            _employerController,
                                        readOnly: false,
                                        keyboardType: TextInputType.text,
                                      ),
                                    ),
                                    // ListItemRow(
                                    //   label: const ListLabel(text: 'Nigeria'),
                                    //   data: SwitchButton(
                                    //     onTap: (value) {
                                    //       setState(() {
                                    //         _switchValue = value;
                                    //       });
                                    //     },
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const SubheadingText(
                                text: 'Contact Info',
                              ),
                              ListContainer(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListItemRow(
                                      label:
                                          const ListLabel(text: 'Phone number'),
                                      data: ListData(
                                        textEditingController:
                                            _numberController,
                                        readOnly: false,
                                        keyboardType: TextInputType.number,
                                      ),
                                    ),
                                    ListItemRow(
                                      label: const ListLabel(text: 'Email'),
                                      data: ListData(
                                        textEditingController: _emailController,
                                        readOnly: true,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          CustomButton(
                            buttonText: 'Edit',
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
