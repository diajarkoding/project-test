import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_test/presentation/controllers/auth_controller.dart';
import 'package:project_test/presentation/controllers/profile_controller.dart';
import 'package:project_test/utils/format.dart';
import 'package:project_test/utils/theme.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final auth = Get.put(AuthController());

    PreferredSizeWidget header() {
      return AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: backgroudColor1,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Profile',
          style: primaryTextStyle,
        ),
        actions: [
          IconButton(
            onPressed: () => auth.logout(),
            icon: const Icon(
              Icons.exit_to_app,
              color: primaryColor,
            ),
          )
        ],
      );
    }

    Widget content() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
        child: GetBuilder<ProfileController>(
            init: Get.find<ProfileController>(),
            builder: (profile) {
              return ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  profile.isLoading == true
                      ? Center(
                          child: Container(
                            width: 100,
                            height: 100,
                            margin: const EdgeInsets.only(
                                top: defaultMargin, bottom: defaultMargin),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/image_profile.png'),
                              ),
                            ),
                          ),
                        )
                      : Center(
                          child: CachedNetworkImage(
                            imageUrl: profile.userModel!.profilePhoto ?? '',
                            imageBuilder: (context, imageProvider) => Container(
                              width: 100,
                              height: 100,
                              margin: const EdgeInsets.only(
                                  top: defaultMargin, bottom: defaultMargin),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: primaryTextColor,
                                  width: 2,
                                ),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            placeholder: (context, url) => Container(
                              width: 100,
                              height: 100,
                              margin: const EdgeInsets.only(
                                  top: defaultMargin, bottom: defaultMargin),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage('assets/image_profile.png'),
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              width: 100,
                              height: 100,
                              margin: const EdgeInsets.only(
                                  top: defaultMargin, bottom: defaultMargin),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage('assets/image_profile.png'),
                                ),
                              ),
                            ),
                          ),
                        ),
                  ProfileInput(
                    title: 'Nama',
                    hintText: profile.userModel!.fullName ?? '',
                  ),
                  ProfileInput(
                    title: 'Email',
                    hintText: profile.userModel!.email ?? '',
                  ),
                  ProfileInput(
                    title: 'Jenis Kelamin',
                    hintText: profile.userModel!.gender ?? '',
                  ),
                  ProfileInput(
                    title: 'Tanggal Lahir',
                    hintText:
                        formatTanggal(profile.userModel!.birthDate!.toString()),
                  ),
                  ProfileInput(
                    title: 'Provinsi',
                    hintText: profile.userModel!.province ?? '',
                  ),
                ],
              );
            }),
      );
    }

    return Scaffold(
      backgroundColor: backgroudColor3,
      appBar: header(),
      body: content(),
      // resizeToAvoidBottomInset: false,
    );
  }
}

class ProfileInput extends StatelessWidget {
  const ProfileInput({
    super.key,
    required this.title,
    required this.hintText,
  });
  final String title;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: secondaryTextStyle.copyWith(fontSize: 13),
          ),
          TextFormField(
            style: primaryTextStyle.copyWith(fontSize: 16),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: primaryTextStyle.copyWith(fontSize: 16),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: subtitleTextColor),
              ),
            ),
          )
        ],
      ),
    );
  }
}
