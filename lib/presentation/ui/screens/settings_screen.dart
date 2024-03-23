import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_db/presentation/components/app_colors.dart';
import 'package:movie_db/presentation/components/app_style.dart';
import '../widgets/user_profile_widget.dart';



class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.mainDark,
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 100),
          const UserProfileWidget(),
          const SizedBox(height: 25),
          Text(
            'Настройки и другое',
            style: AppStyle.titleStyle.copyWith(fontWeight: FontWeight.w400, fontSize: 20),
          ),
          const SizedBox(height: 20),
          settingCard(
              iconData: Icons.settings,
              title: 'Настройки',
              subTitle: 'Настрой приложение на свой вкус',
              context: context),
          settingCard(iconData: Icons.loop, title: 'MovieDb', subTitle: 'Авторизация для MovieDb', context: context),
          settingCard(iconData: Icons.group_outlined, title: 'Соцсети', subTitle: 'Мы в соцсетях!', context: context),
          settingCard(
              iconData: Icons.arrow_circle_up_outlined,
              title: 'Проверить обновление',
              subTitle: 'Версия 1.6.1',
              context: context),

          ElevatedButton(onPressed: (){context.go('/');}, child: Text('go'))

        ],
      ),
    );
  }

  Widget settingCard(
      {required IconData iconData, required String title, required String subTitle, required BuildContext context}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(color: AppColors.appDark, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Icon(
            iconData,
            size: 35,
            color: AppColors.whiteColor,
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppStyle.titleStyle.copyWith(fontSize: 16),
              ),
              Text(
                subTitle,
                style: AppStyle.normalStyle.copyWith(fontSize: 12),
              ),
            ],
          )
        ],
      ),
    );
  }
}
