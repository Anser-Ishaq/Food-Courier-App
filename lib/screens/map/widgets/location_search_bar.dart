import 'package:flutter/material.dart';
import 'package:food_couriers/constants/colors/app_colors.dart';

class LocationSearchBar extends StatelessWidget {
  const LocationSearchBar({
    super.key,
    required this.textEditingController,
    required this.placesList,
    required this.onTapPlace,
  });

  final TextEditingController textEditingController;
  final List<dynamic> placesList;
  final void Function(String) onTapPlace;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.8,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 43,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 32),
            padding: const EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              gradient: AppColors.gradientSecondary,
              // color: AppColors.red.withOpacity(0.3),
              borderRadius: BorderRadius.circular(7),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.search_rounded,
                  size: 20,
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: TextField(
                    controller: textEditingController,
                    textAlignVertical: TextAlignVertical.center,
                    style: const TextStyle(
                      color: AppColors.black,
                      decorationColor: AppColors.black,
                      fontFamily: 'Roboto',
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.01,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Where is your location',
                      hintStyle: TextStyle(
                        color: AppColors.grey,
                        fontFamily: 'Roboto',
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.01,
                      ),
                    ),
                    expands: true,
                    maxLines: null,
                  ),
                ),
              ],
            ),
          ),
          placesList.isNotEmpty
              ? Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 32),
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                    gradient: AppColors.gradientSecondary,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: ListView.builder(
                    itemCount: placesList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(placesList[index]['description']),
                        onTap: () {
                          onTapPlace(placesList[index]['description']);
                        },
                      );
                    },
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
