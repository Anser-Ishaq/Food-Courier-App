import 'package:flutter/material.dart';
import 'package:food_couriers/components/gradient_text.dart';
import 'package:food_couriers/constants/colors/app_colors.dart';
import 'package:food_couriers/constants/images/images.dart';
import 'package:food_couriers/services/navigation_service.dart';
import 'package:get_it/get_it.dart';

class FinishOrderScreen extends StatefulWidget {
  const FinishOrderScreen({super.key});

  @override
  State<FinishOrderScreen> createState() => _FinishOrderScreenState();
}

class _FinishOrderScreenState extends State<FinishOrderScreen> {
  final GetIt _getIt = GetIt.instance;
  final _feedbackController = TextEditingController();

  late NavigationService _navigationService;

  final _outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(7),
    borderSide: const BorderSide(
      color: Color(0xFFF6F6F6),
    ),
  );

  int _rating = 0;

  @override
  void initState() {
    super.initState();
    _navigationService = _getIt.get<NavigationService>();
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              Images.splashPattern,
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.274,
            left: MediaQuery.of(context).size.width * 0.277,
            child: Container(
              width: 21,
              height: 21,
              decoration: const BoxDecoration(
                gradient: AppColors.gradientPrimary,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.306,
            left: MediaQuery.of(context).size.width * 0.701,
            child: Container(
              width: 13,
              height: 13,
              decoration: const BoxDecoration(
                gradient: AppColors.gradientPrimary,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.435,
            left: MediaQuery.of(context).size.width * 0.277,
            child: Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                gradient: AppColors.gradientPrimary,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.469,
            left: MediaQuery.of(context).size.width * 0.68,
            child: Container(
              width: 5,
              height: 5,
              decoration: const BoxDecoration(
                gradient: AppColors.gradientPrimary,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.363,
            left: 0,
            right: 0,
            bottom: 0,
            child: SizedBox(
              child: Column(
                children: [
                  Expanded(
                    child: _staticInfo(),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                  _feedbackField(),
                  _buttomRow(),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _feedbackField() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        controller: _feedbackController,
        maxLines: 5,
        minLines: 1,
        style: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.5),
        decoration: InputDecoration(
          hintText: 'Leave feedback',
          hintStyle: TextStyle(
            color: AppColors.charcoalGray.withOpacity(0.3),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          prefixIcon: const Icon(
            Icons.edit_square,
            color: AppColors.primary,
          ),
          focusedBorder: _outlineInputBorder,
          enabledBorder: _outlineInputBorder,
        ),
      ),
    );
  }

  Widget _buttomRow() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: AppColors.gradientPrimary,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    color: AppColors.white,
                    fontFamily: 'Roboto',
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: GestureDetector(
              onTap: () {
                _navigationService.goBack();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(7),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadowBlue.withOpacity(0.2),
                      offset: const Offset(12, 26),
                      blurRadius: 50,
                    )
                  ],
                ),
                child: const GradientText(
                  text: 'Skip',
                  gradient: AppColors.gradientPrimary,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _staticInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _checkCircle(),
        _thankyouText(),
        const SizedBox(
          height: 10,
        ),
        _starRating(),
      ],
    );
  }

  Widget _starRating() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _rating = index + 1;
            });
          },
          child: SizedBox(
            width: 45,
            child: Icon(
              Icons.star_rate_rounded,
              size: 30,
              color: index < _rating
                  ? const Color(0xFFFEAD1D)
                  : const Color(0xFFFEAD1D).withOpacity(0.3),
            ),
          ),
        );
      }),
    );
  }

  Widget _thankyouText() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Thank You!\nOrder Completed',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.black,
            fontFamily: 'Poppins',
            fontSize: 25,
            fontWeight: FontWeight.w700,
            height: 32.76 / 25,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Please rate your last Driver',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.charcoalGray.withOpacity(0.3),
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            height: 21 / 14,
          ),
        ),
      ],
    );
  }

  Widget _checkCircle() {
    return Container(
      width: 82,
      height: 82,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF40BFFF).withOpacity(0.24),
            blurRadius: 30,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: const Icon(
        Icons.check_rounded,
        color: AppColors.white,
        size: 27,
      ),
    );
  }
}
