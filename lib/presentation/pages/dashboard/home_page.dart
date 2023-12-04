import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_test/presentation/controllers/profile_controller.dart';

import 'package:project_test/utils/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  List<String> roles = [
    'Semua',
    'Tank',
    'Fighter',
    'Assassin',
    'Mage',
    'Marksman',
    'Support',
  ];

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: const EdgeInsets.only(
            top: defaultMargin, left: defaultMargin, right: defaultMargin),
        child: GetBuilder(
          init: Get.find<ProfileController>(),
          builder: (profile) {
            return Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profile.isLoading == true
                            ? 'Hallo, .......'
                            : 'Hallo, ${profile.userModel!.fullName!.split(" ")[0]}',
                        style: primaryTextStyle.copyWith(
                            fontSize: 21, fontWeight: semiBold),
                      ),
                      Text(
                        profile.isLoading == true
                            ? '@ .......'
                            : '@${profile.userModel!.fullName!.split(" ")[0]}',
                        style: subtitleTextStyle.copyWith(
                            fontSize: 16, fontWeight: regular),
                      )
                    ],
                  ),
                ),
                if (profile.isLoading == true)
                  Container(
                    width: 54,
                    height: 54,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/image_profile.png'),
                      ),
                    ),
                  )
                else
                  CachedNetworkImage(
                    imageUrl: profile.userModel!.profilePhoto ?? '',
                    imageBuilder: (context, imageProvider) => Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: primaryTextColor,
                          width: 1.5,
                        ),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => Container(
                      width: 54,
                      height: 54,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/image_profile.png'),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      width: 54,
                      height: 54,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/image_profile.png'),
                        ),
                      ),
                    ),
                  )
              ],
            );
          },
        ),
      );
    }

    return SafeArea(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header(),
            ],
          ),
        ],
      ),
    );
  }
}
