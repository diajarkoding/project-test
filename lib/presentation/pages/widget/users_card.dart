import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project_test/model/users_model.dart';
import 'package:project_test/utils/theme.dart';

class UsersCard extends StatelessWidget {
  const UsersCard({
    Key? key,
    required this.users,
  }) : super(key: key);

  final UsersModel users;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(bottom: defaultMargin),
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: users.avatar ?? '',
              imageBuilder: (context, imageProvider) => Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: backgroudColor6,
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: imageProvider,
                  ),
                ),
              ),
              placeholder: (context, url) => Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: backgroudColor6,
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    image: AssetImage('assets/image_profile.png'),
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: backgroudColor6,
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    image: AssetImage('assets/image_profile.png'),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${users.firstName} ${users.lastName}',
                  style: primaryTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                      overflow: TextOverflow.ellipsis),
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  users.email!,
                  style: secondaryTextStyle.copyWith(fontWeight: medium),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
